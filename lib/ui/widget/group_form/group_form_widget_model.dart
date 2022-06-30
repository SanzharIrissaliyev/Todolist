import 'package:flutter/material.dart';
import 'package:todolistdb/domain/data_provider/box_manager.dart';
import 'package:todolistdb/domain/entity/group.dart';

class GroupFormWidgetModel {
  var gropName = '';
  void saveGroup(BuildContext context) async {
    if (gropName.isEmpty) return;
    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: gropName);
    await box.add(group);
    await BoxManager.instance.closeBox(box);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}

class GroupFormWidgetProvider extends InheritedWidget {
  final GroupFormWidgetModel model;
  const GroupFormWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static GroupFormWidgetProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFormWidgetProvider>();
  }

  static GroupFormWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormWidgetProvider>()
        ?.widget;
    return widget is GroupFormWidgetProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
