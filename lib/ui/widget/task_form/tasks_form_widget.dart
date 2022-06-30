import 'package:flutter/material.dart';
import 'package:todolistdb/ui/widget/task_form/tasks_form_widget_model.dart';

class TasksFormWidget extends StatefulWidget {
  final int groupKey;
  const TasksFormWidget({Key? key, required this.groupKey}) : super(key: key);

  @override
  State<TasksFormWidget> createState() => _TasksFormWidgetState();
}

class _TasksFormWidgetState extends State<TasksFormWidget> {
  late final TasksFormWidgetModel _model;
  @override
  void initState() {
    super.initState();
    _model = TasksFormWidgetModel(groupKey: widget.groupKey);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_model == null) {
  //     final groupKey = ModalRoute.of(context)!.settings.arguments as int;
  //     _model = TasksFormWidgetModel(groupKey: groupKey);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return TasksFormWidgetModelProvider(
      model: _model,
      child: const TextFormWidgetBody(),
    );
  }
}

class TextFormWidgetBody extends StatelessWidget {
  const TextFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text zadachi.'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _TaskTextWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            TasksFormWidgetModelProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksFormWidgetModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      minLines: null,
      maxLines: null,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Text zadachi",
      ),
      onChanged: (value) => model?.tasksText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}
