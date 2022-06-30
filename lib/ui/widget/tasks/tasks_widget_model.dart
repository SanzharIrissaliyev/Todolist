import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:todolistdb/ui/widget/tasks/tasks_widget.dart';

import '../../../domain/data_provider/box_manager.dart';
// import '../../../domain/entity/group.dart';
import '../../../domain/entity/task.dart';
import '../../navigation/main_navigation.dart';

class TasksWidgetModel extends ChangeNotifier {
  TasksWidgetConfiguration configuration;
  late final Future<Box<Task>> _box;

  // late final Future<Box<Group>> _groupBox;
  var _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();

  TasksWidgetModel({required this.configuration}) {
    _setup();
  }
  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.tasksForm,
        arguments: configuration.groupKey);
  }

  Future<void> deleteTasks(int taskIndex) async {
    (await _box).deleteAt(taskIndex);
  }

  Future<void> doneToogle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    await task?.save();
  }

  //Group name v appbare

  Future<void> _readTasksfromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);

    await _readTasksfromHive();
    (await _box).listenable().addListener(_readTasksfromHive);
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;

  const TasksWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}
