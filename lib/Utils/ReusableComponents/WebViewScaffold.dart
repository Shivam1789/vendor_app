import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;


import '../ReusableWidgets.dart';
import '../UniversalFunctions.dart';
import 'customLoader.dart';

class WebViewScaffold extends StatefulWidget {
  final String title;
  final String url;
  final bool needAppBar;

  const WebViewScaffold({
    Key key,
    @required this.title,
    @required this.url,
    this.needAppBar:true,
  }) : super(key: key);

  @override
  _WebViewScaffoldState createState() => _WebViewScaffoldState();
}

class _WebViewScaffoldState extends State<WebViewScaffold> {
  /// PASS THIS CONTROLLER TO YOUR LIST WIDGET LIKE BELOW
  /// controller: productList.length >= Constants.itemsCount ? scrollController : null,
  /// ABOVE CONDITION IS REQUIRED DUE TO A PROBLEM WITH RefreshIndicator. PROBLEM IS :
  /// PULL TO REFRESH WILL NOT WORK IF THE SCREEN IS NOT FILLED WITH CONTENT
  /// Constants.itemsCount this will tell how many items are required per_page
  final scrollController = ScrollController();
  bool isLoading = true;
  int pageNumber = 1;

  /// SPECIFY YOUR TYPE OF DATA HERE example : List<Product>
  Size screenSize;

  final title = "PAYMENT";
  final kAndroidUserAgent =
      'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';


//  final kAndroidUserAgent =
//      'Mozilla/5.0 (Linux; Android 4.4.4; One Build/KTU84L.H4) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/33.0.0.0 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/28.0.0.20.16;]';

  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  bool _isLoading = true;
  Timer timer;

  StreamSubscription _onDestroy;
  StreamSubscription<WebViewStateChanged> _onStateChange;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  double appbarHeight;

  bool _pageLoaded = false;

  bool _canReload = false;

   get appBar => getAppThemeAppBar(context, titleText: "${widget.title}");

  @override
  void initState() {
    super.initState();
    //flutterWebViewPlugin.close();
    flutterWebViewPlugin.cleanCookies();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((obj) {
      if (mounted) {
        // Actions like show a info toast.
        Navigator.pop(context);
      }
    });

    _onStateChange = flutterWebViewPlugin.onStateChanged.listen((state) {
      if (mounted) {
        print("State of web view:::: ${state.type}");
        switch (state.type) {
          case WebViewState.startLoad:
            flutterWebViewPlugin.hide();
            checkInternetForPostMethod(
              context: context,
              onSuccess: () {},
              onFail: () {
                flutterWebViewPlugin.hide();
                setState(() {
                  _canReload = true;
                });
              },
              mounted: mounted,
            );
            print('Start loading...');
            break;

          case WebViewState.shouldStart:
            print('Should loading...');
            break;
          case WebViewState.finishLoad:
            flutterWebViewPlugin.show();
            setState(() {
              _pageLoaded = true;
            });
            print('Finished loading...');
            break;
          default:
            break;
        }
      }
    });


    timer = new Timer(const Duration(seconds: 0), () async {
      double statusBarHeight = MediaQuery.of(context).padding.top;
      appbarHeight = appBar.preferredSize.height + statusBarHeight;
      flutterWebViewPlugin.launch(
        widget.url,
        userAgent: kAndroidUserAgent,
        rect: new Rect.fromLTWH(
            0.0,
            appbarHeight,
            MediaQuery.of(context).size.width,
            (MediaQuery.of(context).size.height - appbarHeight)),
        withJavascript: true,
        supportMultipleWindows: false,
        withZoom: false,
        scrollBar: false,
        clearCache: true,
        appCacheEnabled: true,
        withLocalStorage: true
      );
    });
  }

  Future<bool> _onWillPopScope() async {
    flutterWebViewPlugin.close();
//    Navigator.pop(context, Constants.PAYMENT_FAILED);
    return false;
  }

  @override
  void dispose() {
    scrollController.dispose();
    flutterWebViewPlugin.close();
    _onDestroy.cancel();
    _onStateChange.cancel();
    flutterWebViewPlugin.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    print("URL : ${widget.url}");

    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: new Material(
        child: new Scaffold(
          backgroundColor: Colors.white,
          appBar:widget.needAppBar? appBar:null,
          body: new Offstage(
            offstage: _pageLoaded,
            child: new Center(
              child: _canReload
                  ? getNoDataView(context: context,
                      msg: "",
                      onRetry: () {
                        setState(() {
                          _canReload = false;
                          _pageLoaded = false;
                          flutterWebViewPlugin.reloadUrl(widget.url);
                        });
                      },
                    )
                  : CustomLoader().buildLoader(isTransparent: true),
            ),
          ),
        ),
      ),
    );
  }

}

