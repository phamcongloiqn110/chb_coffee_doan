import 'package:flutter/cupertino.dart';

class BouncyPageRoute extends PageRouteBuilder {
  final Widget widget;

  BouncyPageRoute({this.widget})
      : super(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeOutSine);
            return ScaleTransition(
              alignment: Alignment.bottomRight,
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) => widget,
        );
}
