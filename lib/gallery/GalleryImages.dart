import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/Messages.dart';
import 'package:vendor_flutter/Utils/ReusableComponents/customLoader.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/bloc/gallery_bloc.dart';
import 'package:vendor_flutter/data/ImageList.dart';
import 'package:vendor_flutter/networks/api_urls.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GalleryImages extends StatefulWidget {
  @override
  _GalleryImagesState createState() => _GalleryImagesState();
}

class _GalleryImagesState extends State<GalleryImages> {
  GalleryBloc _galleryBloc = new GalleryBloc();
  File _image;
  ScrollController _scrollController = new ScrollController();
  var imagesList = new List<ImageList>();
  var isLoading = true;
  CustomLoader _customLoader = CustomLoader();

  var _isVisible = false;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: _isVisible,
              child: Container(
                width: getScreenSize(context: context).width,
                height: 50,
                alignment: Alignment.center,
                color: Colors.red,
                child: Text("Uploading Image. Please wait",
                  style: TextStyle(color: Colors.white, fontSize: 14),),),),
            SizedBox(height: 20,),
            new OutlineButton(
                child: new Text("Upload Image"),
                onPressed: () {
                  getImage();
                },
                highlightedBorderColor: AppColors.kGreen,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),)
            ),
            SizedBox(height: 20,),
            Expanded(child: isLoading & imagesList.isEmpty ? Center(
              child: CircularProgressIndicator(),) : getGridView())
          ],
        ),
      ),
    );
  }


  Widget getGridView() {
    return new GridView.builder(
        itemCount: imagesList.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: Stack(
              children: <Widget>[
                new Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: getCachedNetworkImage(
                        url: 'http://gk3.puneetchawla.in/${imagesList[index]
                            .image}')
                ),
                Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(
                      icon: Icon(Icons.delete, size: 20, color: Colors.red,),
                      onPressed: () {
                        deleteImage(imagesList[index].id);
                      }),
                ),
              ],

            ),
            onTap: () {

            },
          );
        });
  }


  _getNoItemView() {
    return getRetryView(
      context: context,
      message: "You have not applied for any loan yet.",
      optionText: "START APLLYING LOANS",
      onRetry: () {},
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _isVisible = true;
    });
    var response = await _galleryBloc.uploadImage(_image, context);
    _isVisible = false;
    setState(() {

    });
    if (response != null) {
      fetchImages();
    }
  }


  fetchImages() async {
    String url = "${ApiUrl.baseUrl}image?token=${MemoryManagement
        .getAccessToken()}";
    print(url);
    final response =
    await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      imagesList = list.map((model) => ImageList.fromJson(model)).toList();
      print("ImageList $imagesList");
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load post');
    }
  }

  deleteImage(int id) async {
    _customLoader.showLoader(context);
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      _customLoader.hideLoader();
      showAlertDialog(
          context: context,
          title: "Error",
          message: AppMessages.noInternetError);
      return;
    }
    String url = "${ApiUrl.baseUrl}image?id=$id";
    print(url);
    Map<String, String> header = {
      "id": "$id",
      "Accept": "application/json",
      "token": MemoryManagement
          .getAccessToken()
    };
    print(header);
    final response =
    await http.delete(url, headers: header);
    print("delete response==> ${response.statusCode}");
    print("delete response==> ${response.body}");
    if (response.statusCode == 200) {
      _customLoader.hideLoader();
      fetchImages();
    } else {
      _customLoader.hideLoader();
      showAlertDialog(
          context: context,
          title: "Error",
          message: "${AppMessages.generalError}");
    }
  }

}
