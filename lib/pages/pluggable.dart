part of '../toolkit.dart';

abstract class Pluggable {
  String get name;
  int get index;
  void onTrigger();
  Widget? buildWidget(BuildContext context);
  Widget? iconWidget();
}

typedef StreamFilter = bool Function(dynamic);

abstract class PluggableWithStream extends Pluggable {
  Stream get stream;
  StreamFilter get streamFilter;
}

abstract class PluggableWithNestedWidget extends Pluggable {
  Widget buildNestedWidget(Widget child);
}
