import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:vendor_flutter/LogIn/sliding_login.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/createSale/createSale.dart';
import 'package:vendor_flutter/gallery/GalleryImages.dart';
import 'package:vendor_flutter/transactions/TransactionScreen.dart';

enum ActiveScreen {
  Dashboard,
  SalesEntry,
  TransactionHistory,
  Gallery,
  PaymentHistory,
  logout
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // UI Properties
  ActiveScreen _activeScreen = ActiveScreen.Dashboard;
  String _appBarTitle = "DASHBOARD";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          title: Text(_appBarTitle),
          backgroundColorStart: AppColors.kGreen,
          backgroundColorEnd: AppColors.kBlue,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _createHeader(),
              _createDrawerItem(
                  icon: Icons.contacts,
                  text: 'DashBoard',
                  onTap: () {
                    _activeScreen = ActiveScreen.Dashboard;
                    Navigator.of(context).pop();
                  }),
              _createDrawerItem(
                  icon: Icons.event,
                  text: 'Sales entry',
                  onTap: () {
                    _activeScreen = ActiveScreen.SalesEntry;
                    _appBarTitle="Sales Entry";
                    setState(() {});
                    Navigator.of(context).pop();
                  }),
              _createDrawerItem(
                  icon: Icons.note,
                  text: 'Transaction History',
                  onTap: () {
                    _activeScreen = ActiveScreen.TransactionHistory;
                    _appBarTitle='Transaction History';
                    setState(() {});
                    Navigator.of(context).pop();
                  }),
              _createDrawerItem(
                  icon: Icons.collections_bookmark,
                  text: 'Gallery',
                  onTap: () {
                    _activeScreen = ActiveScreen.Gallery;
                    _appBarTitle='Gallery';
                    setState(() {});
                    Navigator.of(context).pop();
                  }),
              _createDrawerItem(
                  icon: Icons.face,
                  text: 'Payment History',
                  onTap: () {
                    _activeScreen = ActiveScreen.PaymentHistory;
                    _appBarTitle='Payment History';
                    setState(() {});
                    Navigator.of(context).pop();
                  }),
              _createDrawerItem(
                  icon: Icons.lightbulb_outline,
                  text: 'Logout',
                  onTap: ()async {
                    _activeScreen = ActiveScreen.logout;
                    setState(() {});
                    Navigator.of(context).pop();
                    MemoryManagement.clearMemory();
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (context) => new LoginScreen()),
                            (Route<dynamic> route) => false);
                  })
            ],
          ),
        ),
        body: _getScreen());
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
              0.1,
              0.4,
              0.6,
              0.9
            ],
                colors: [
              AppColors.kBlue,
              AppColors.kBlue,
              AppColors.kGreen,
              AppColors.kGreen
            ])),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 18.0,
              left: 12.0,
              child: Row(
                children: <Widget>[
                  _getProfilePicField,
                  getSpacer(width: 16),
                  Text("${MemoryManagement.getName()}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500))
                ],
              )),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget defaultWidget = new Center(
    child: new Text(
      "Coming Soon ....",
    ),
  );

  _getScreen() {
    Widget defaultWidget = new Center(
      child: new Text(
        "Coming Soon ....",
      ),
    );
    switch (_activeScreen) {
      case ActiveScreen.Dashboard:
        return defaultWidget;
        break;
      case ActiveScreen.SalesEntry:
        return CreateSales();
        break;
      case ActiveScreen.TransactionHistory:
        return SimpleTable();
        break;
      case ActiveScreen.Gallery:
        return GalleryImages();
        break;
      case ActiveScreen.PaymentHistory:
        return SimpleTable();
        break;
      case ActiveScreen.logout:
        return defaultWidget;
        break;
      default:
        return defaultWidget;
    }
  }

  get _getProfilePicField {
    final double imageWidth = getScreenSize(context: context).width * 0.15;
    final double imageHeight = getScreenSize(context: context).width * 0.15;
    return new Stack(
      children: <Widget>[
        new Container(
          height: imageHeight,
          width: imageWidth,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            border: new Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: new Icon(
            Icons.person,
            size: imageHeight * 0.5,
            color: AppColors.kWhite,
          ),
        )
      ],
    );
  }
}
