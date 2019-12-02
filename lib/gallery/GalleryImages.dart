import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryImages extends StatefulWidget {
  @override
  _GalleryImagesState createState() => _GalleryImagesState();
}

class _GalleryImagesState extends State<GalleryImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: gridView,
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
