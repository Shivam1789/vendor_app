import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/bloc/gallery_bloc.dart';

class GalleryImages extends StatefulWidget {
  @override
  _GalleryImagesState createState() => _GalleryImagesState();
}

class _GalleryImagesState extends State<GalleryImages> {
  GalleryBloc _loanBloc = new GalleryBloc();

  @override
  void initState() {
    super.initState();
    _loanBloc.getImagesList(context);

    _loanBloc.isLoading.add(false);
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
                onPressed: (){},
                highlightedBorderColor: AppColors.kGreen,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),)
            ),
            SizedBox(height: 20,),
            Expanded(child: gridView),
          ],
        ),
      ),
    );
  }

  var gridView = new GridView.builder(
      itemCount: 20,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.center,
              child: new Text('Item $index'),
            ),
          ),
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              child: new CupertinoAlertDialog(
                title: new Column(
                  children: <Widget>[
                    new Text("GridView"),
                    new Icon(
                      Icons.favorite,
                      color: Colors.green,
                    ),
                  ],
                ),
                content: new Text("Selected Item $index"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text("OK"))
                ],
              ),
            );
          },
        );
      });
}
