import 'package:flutter/material.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';

class CustomizedDrawer extends StatefulWidget {
  final Widget drawer;
  final Widget home;
  final OpenableController openableController;

  CustomizedDrawer(
      {@required this.drawer,
      @required this.home,
      @required this.openableController});

  @override
  _CustomizedDrawerState createState() => _CustomizedDrawerState();
}

class _CustomizedDrawerState extends State<CustomizedDrawer>
    with SingleTickerProviderStateMixin {
  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    width = MediaQuery.of(context).size.width * 0.65;
    height = MediaQuery.of(context).size.height;
    return Material(
      color: AppColors.kGreen,
      child: Stack(
        children: <Widget>[
          FractionalTranslation(
            translation:
                Offset((widget.openableController.percentOpen) - 1.0, 0.0),
            child: widget.drawer,
          ),
          Transform(
              transform: Matrix4.translationValues(
                  widget.openableController.percentOpen * width, 0.0, 0.0),
              child: Center(
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                      height: height -
                          (widget.openableController.percentOpen *
                              (width / 1.2)),
                      width: screenWidth,
                      child: new Stack(
                        children: <Widget>[
                          widget.home,
                          new Offstage(
                            offstage: !widget.openableController.isOpen(),
                            child: new GestureDetector(
                              onTap: () {
                                widget.openableController.isOpen()
                                    ? widget.openableController.close()
                                    : null;
                              },
                              child: new Container(
                                height: height,
                                width: screenWidth,
                                color: Colors.transparent,
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              )),
        ],
      ),
    );
  }
}

class OpenableController extends ChangeNotifier {
  OpenedState _state;
  AnimationController openingController;

  OpenableController(
      {@required TickerProvider vsync, @required Duration openDuration})
      : openingController =
            AnimationController(vsync: vsync, duration: openDuration) {
    openingController
      ..addListener(notifyListeners)
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = OpenedState.opening;
            break;
          case AnimationStatus.reverse:
            _state = OpenedState.closing;
            break;
          case AnimationStatus.completed:
            _state = OpenedState.open;
            break;
          case AnimationStatus.dismissed:
            _state = OpenedState.closed;
            break;
        }

        notifyListeners();
      });
  }

  get state => _state;

  get percentOpen => openingController.value;

  bool isOpen() {
    return _state == OpenedState.open;
  }

  bool isOpening() {
    return _state == OpenedState.opening;
  }

  bool isClosed() {
    return _state == OpenedState.closed;
  }

  bool isClosing() {
    return _state == OpenedState.closing;
  }

  void open() {
    openingController.forward();
  }

  void close() {
    openingController.reverse();
  }

  void toggle() {
    if (isClosed()) {
      open();
    } else if (isOpen()) {
      close();
    }
  }
}

enum OpenedState { open, closed, opening, closing }
