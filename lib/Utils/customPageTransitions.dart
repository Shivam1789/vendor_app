import 'package:flutter/cupertino.dart';

class FadeTransitionRoute<T> extends PageRouteBuilder<T> {
  final Widget widget;

  FadeTransitionRoute({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return widget;
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return new FadeTransition(
      opacity: animation,
      child: child,
    );
  });
}