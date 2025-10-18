import 'package:flatten/helpers/widgets/my_middleware.dart';
import 'package:flutter/material.dart';

class MyRoute {
  String name;
  WidgetBuilder builder;
  List<MyMiddleware>? middlewares;

  MyRoute({required this.name, required this.builder, this.middlewares});
}
