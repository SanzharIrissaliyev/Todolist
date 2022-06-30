import 'package:flutter/material.dart';

import 'package:todolistdb/domain/data_provider/box_manager.dart';
import 'package:todolistdb/domain/entity/task.dart';

class TasksFormWidgetModel {
  int groupKey;
  var tasksText = '';
  TasksFormWidgetModel({
    required this.groupKey,
  });
  void saveTask(BuildContext context) async {
    if (tasksText.isEmpty) return;
    final task = Task(text: tasksText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    await BoxManager.instance.closeBox(box);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}

class TasksFormWidgetModelProvider extends InheritedWidget {
  final TasksFormWidgetModel model;
  const TasksFormWidgetModelProvider({
    Key? key,
    required this.child,
    required this.model,
  }) : super(key: key, child: child);

  @override
  // ignore: overridden_fields
  final Widget child;

  static TasksFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksFormWidgetModelProvider>();
  }

  static TasksFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksFormWidgetModelProvider>()
        ?.widget;
    return widget is TasksFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
