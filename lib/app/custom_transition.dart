import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  final AxisDirection direction;
  SlidePageRoute({required this.page, this.direction = AxisDirection.right})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          switch (direction) {
            case AxisDirection.up:
              begin = const Offset(0.0, 1.0);
              break;
            case AxisDirection.down:
              begin = const Offset(0.0, -1.0);
              break;
            case AxisDirection.left:
              begin = const Offset(-1.0, 0.0);
              break;
            case AxisDirection.right:
              // default:
              begin = const Offset(1.0, 0.0);
          }

          var end = Offset.zero;
          var curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      );
}

class FadePageRoute extends PageRouteBuilder {
  final Widget page;
  final Duration duration;

  FadePageRoute({
    required this.page,
    this.duration = const Duration(milliseconds: 500),
  }) : super(
         transitionDuration: duration, // Atur durasi animasi
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           var curve = Curves.ease;
           var tween = Tween<double>(
             begin: 0.0,
             end: 1.0,
           ).chain(CurveTween(curve: curve));

           return FadeTransition(opacity: animation.drive(tween), child: child);
         },
       );
}

// ==========================================================
// SECTION: Navigasi Scale
// ==========================================================
class ScalePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  ScalePageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(scale: animation, child: child);
        },
      );
}

// ==========================================================
// SECTION: Extension Navigate
// ==========================================================
extension NavigationExtensions on BuildContext {
  // Slide
  void slideTo(Widget page) {
    Navigator.push(this, SlidePageRoute(page: page));
  }

  void slideReplace(Widget page) {
    Navigator.pushReplacement(this, SlidePageRoute(page: page));
  }

  void slideRemoveUntil(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      SlidePageRoute(page: page),
      (route) => false,
    );
  }

  // Fade
  void fadeTo(Widget page) {
    Navigator.push(this, FadePageRoute(page: page));
  }

  void fadeReplace(Widget page) {
    Navigator.pushReplacement(this, FadePageRoute(page: page));
  }

  void fadeRemoveUntil(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      FadePageRoute(page: page),
      (route) => false,
    );
  }

  // Scale
  void scaleTo(Widget page) {
    Navigator.push(this, ScalePageRoute(page: page));
  }

  void scaleReplace(Widget page) {
    Navigator.pushReplacement(this, ScalePageRoute(page: page));
  }

  void scaleRemoveUntil(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      ScalePageRoute(page: page),
      (route) => false,
    );
  }
}
