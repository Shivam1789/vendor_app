import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vendor_flutter/Utils/Messages.dart';
import 'package:vendor_flutter/Utils/ReusableComponents/customLoader.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/data/ImageList.dart';
import 'package:vendor_flutter/networks/api_manager.dart';

import 'bloc.dart';

class GalleryBloc extends BaseBloc {
  CustomLoader _customLoader = CustomLoader();

  //signIn method
  static List<ImageList> loanList = new List();
  BehaviorSubject<int> viewController = new BehaviorSubject();// control main view
  BehaviorSubject<bool> isLoading = new BehaviorSubject();//control bottom loader while paginating
  ValueNotifier<int> fabBuildNotifier = new ValueNotifier(0);
  int perPageLimit=1;//pagination limit
  int currentPage=1;//keep track of current page


  //method get  List of Loan
  getImagesList(context) async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      viewController.add(0);
      showAlertDialog(
          context: context, title: "Error", message: AppMessages.noInternetError);
      return;
    }

    try {
      currentPage==1?null:isLoading.add(true);//show pagination loader
      var result =
      await ApiManager.getLoanList(header: {}, body: {}, context: context ,pageNumber: currentPage);
      int status = int.tryParse("${result['status']}");
      print("bloc Staus:$status");
      switch (status) {
        case 1:
          perPageLimit =result["pagination"]??1;
          await _loadData(result['result'],currentPage:currentPage);
          viewController.add(1);
          fabBuildNotifier.value=status;
          isLoading.add(false);
          break;

        case 0:
          viewController.add(0);
          isLoading.add(false);

          showAlertDialog(
              context: context, title: "Error", message: result['message']);
          break;
        default:
        // _customLoader.hideLoader();
          break;
      }
    } catch (e, st) {
      //_customLoader.hideLoader();
      viewController.add(0);
      isLoading.add(false);
      print("Exception :: $e\n $st");
      showAlertDialog(
          context: context,
          title: "Error",
          message: "${AppMessages.generalError}");
    }
  }


  //method load Loan items to List
  _loadData(resultList,{currentPage}) {
    if(currentPage==1){
      loanList.clear();
    }
    for (Map map in resultList) {
      loanList.add(ImageList.fromJson(map));
    }
  }

  @override
  dispose() {
    viewController.close();
    isLoading.close();
    return null;
  }


//  uploadImage(File imageFile) async {
//    String baseUrl = "http://gk3.puneetchawla.in/api/v1/image";
//    Map<String, String> headers = {
//      "Content-Type": "multipart/form-data",
//      "Token": MemoryManagement
//          .getAccessToken() ?? "",
//      "Accept": "application/json"
//    };
//    print(baseUrl);
//    // open a bytestream
//    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//    // get file length
//    var length = await imageFile.length();
//
//    // string to uri
//    var uri = Uri.parse(baseUrl);
//
//    // create multipart request
//    var request = new http.MultipartRequest("POST", uri);
//
//    request.headers.addAll(headers);
//
//    // multipart that takes file
//    var multipartFile = new http.MultipartFile('file', stream, length,
//        filename: basename(imageFile.path));
//
//    // add file to multipart
//    request.files.add(multipartFile);
//
//    // send
//    var response = await request.send();
//    print(response.statusCode);
//
//    // listen for response
//    response.stream.transform(utf8.decoder).listen((value) {
//      print(value);
//    });
//  }


  Future<http.StreamedResponse> uploadImage(_image,
      BuildContext context) async {
    print("UPLOADING IMAGE");
    String baseUrl = "http://gk3.puneetchawla.in/api/v1/image?token=${MemoryManagement
        .getAccessToken()}";
    var url = Uri.parse(baseUrl); //get url
    String token = MemoryManagement
        .getAccessToken();

    Map<String, String> headers = {
//header
      "Content-Type": "multipart/form-data",
      "Token": token ?? "",
      "Accept": "application/json"
    };

    http.MultipartRequest request =
    new http.MultipartRequest("POST", url); //changed

    request.headers.addAll(headers);
    final fileName = basename(_image.path);
    var bytes = await _image.readAsBytes();

    request.files.add(new http.MultipartFile.fromBytes(
      "image",
      bytes,
      filename: fileName,
    ));
    print("UPLOADING");
    http.StreamedResponse response = await request.send();
    print("UPLOADED");
    print("STATUS CODE: ${response.statusCode}");
    showAlertDialog(
        context: context,
        title: "Information",
        message: "Image uploaded succesfully.");
    return response;
  }
}
