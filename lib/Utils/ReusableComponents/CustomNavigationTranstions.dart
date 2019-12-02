import 'package:flutter/material.dart';

// Navigates to other page with "Fade transition"
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

// Custom Splash page route
class SplashPageRoute<T> extends PageRouteBuilder<T> {
  final Widget widget;

  SplashPageRoute({this.widget})
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

// Custom Dashboard page route
class DashboardPageRoute<T> extends PageRouteBuilder<T> {
  final Widget widget;

  DashboardPageRoute({this.widget})
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
