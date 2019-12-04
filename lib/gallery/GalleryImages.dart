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
import 'package:vendor_flutter/networks/api_manager.dart';
import 'package:vendor_flutter/networks/api_urls.dart';

class GalleryImages extends StatefulWidget {
  @override
  _GalleryImagesState createState() => _GalleryImagesState();
}

class _GalleryImagesState extends State<GalleryImages> {
  GalleryBloc _galleryBloc = new GalleryBloc();
  File _image;
  ScrollController _scrollController = new ScrollController();
  Future<List<ImageList>> imagesList;

  @override
  void initState() {
    super.initState();
    imagesList=fetchProducts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            new OutlineButton(
                child: new Text("Upload Image"),
                onPressed: () {
                  getImage();
                },
                highlightedBorderColor: AppColors.kGreen,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),)
            ),
            SizedBox(height: 20,),
            Expanded(child: FutureBuilder<List<ImageList>>(
              future: imagesList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return getGridView(images: snapshot.data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ))
          ],
        ),
      ),
    );
  }


  Widget getGridView({List<ImageList> images, index}) {
    return new GridView.builder(
        itemCount: 20,
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
                  child: Image.network(
                    'https://placeimg.com/640/480/any',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(
                      icon: Icon(Icons.delete, size: 20, color: Colors.red,),
                      onPressed: () {}),
                ),
              ],

            ),
            onTap: () {

            },
          );
        });
  }


//  _buildPage() {
//    return (GalleryBloc.loanList?.length ?? 0) == 0
//        ? _getNoItemView()
//        : Column(children: [
//      Flexible(
//        child: RefreshIndicator(
//          child: ListView.builder(
//              padding: EdgeInsets.only(bottom: 40, top: 15.0),
//              //all list padding
//              controller: _scrollController,
//              physics: AlwaysScrollableScrollPhysics(),
//
//              itemCount: GalleryBloc.loanList.length + 1,
//              itemBuilder: (context, i) {
//                return (i == (GalleryBloc.loanList.length))
//                    ? StreamBuilder<bool>(
//                  initialData: false,
//                  stream: _galleryBloc.isLoading.stream,
//                  builder: (context, snapsot) {
//                    print("snpashot:${snapsot.data}");
//                    return Offstage(
//                      offstage: !snapsot.data ?? true,
//                      child: Center(
//                          child: CupertinoActivityIndicator(
//                            radius: 15,
//                          )),
//                    );
//                  },
//                )
//                    : getGridView(loan: GalleryBloc.loanList[i], index: i);
//              }),
//          onRefresh: () async {
//            _galleryBloc.currentPage = 1;
//            print("Current Page ${_galleryBloc.currentPage}");
//            await _galleryBloc.getImagesList(context);
//            return;
//          },
//        ),
//      ),
//    ]);
//  }

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
      print("Image $_image");
    });
    _galleryBloc.uploadImage(_image);
  }


  getImagesList(context) async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      showAlertDialog(
          context: context,
          title: "Error",
          message: AppMessages.noInternetError);
      return;
    }

    try {
      var result =
      await ApiManager.getLoanList(
          header: {}, body: {}, context: context, pageNumber: 1);
      print("Result:$result");
    } catch (e, st) {
      print("Exception :: $e\n $st");
      showAlertDialog(
          context: context,
          title: "Error",
          message: "${AppMessages.generalError}");
    }
  }

  List<ImageList> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ImageList>((json) => ImageList.fromJson(json)).toList();
  }

  Future<List<ImageList>> fetchProducts() async {
    final response = await http.get(
        "${ApiUrl.getMyLoanREQList}?token=${MemoryManagement
            .getAccessToken()}");
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

}
