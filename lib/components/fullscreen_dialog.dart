import 'package:flutter/material.dart';

class FullscreenDialogRoute<T> extends PageRouteBuilder<T> {
  FullscreenDialogRoute({required WidgetBuilder builder})
      : super(
    pageBuilder: (context, _, __) => builder(context),
    transitionsBuilder: (context, animation, _, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween =
      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    fullscreenDialog: false,
  );
}
