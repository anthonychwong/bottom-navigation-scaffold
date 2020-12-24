import 'package:flutter/material.dart';

class PageDetail <T> {
  final PreferredSizeWidget pageAppBar;
  final Widget page;
  final T tab;
  final Widget floatingActionButton;

  PageDetail({this.pageAppBar, @required this.page, @required this.tab, this.floatingActionButton});
}
