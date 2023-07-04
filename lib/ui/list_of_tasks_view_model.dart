import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/data/data_providers/task_provider.dart';
import 'package:to_do_list/data/data_providers/users_provider.dart';
import 'package:to_do_list/data/repositories/task_repository.dart';
import 'package:to_do_list/data/repositories/users_repository.dart';
import 'package:to_do_list/db/db_provider.dart';
import 'package:to_do_list/domain/models/task_model.dart';
import 'package:to_do_list/domain/models/user_model.dart';
import 'package:to_do_list/ui/list_of_tasks_state.dart';
import 'package:to_do_list/ui/task_detail_page/task_detail_page.dart';

class ListOfTasksViewModel extends ChangeNotifier {
  ListOfTasksViewModel({required this.context}) {
    initialze();
  }

  void initialze() async {
    await DBProvider.db.initDatabase();
    await getTasks();
  }

  final BuildContext context;

  //final TaskProvider listOfTasksProvider = TaskProvider();
  final TaskRepository taskRepository = TaskRepository();

  //final UsersProvider usersProvider = UsersProvider();
  final UsersRepository _usersRepository = UsersRepository();

  ListOfTasksState _state = const ListOfTasksState();

  ListOfTasksState get state => _state;

  Future<void> getTasks() async {
    final List<TaskModel> tasks = await taskRepository.getTasks();
    _state = _state.copyWith(tasks: tasks);
    notifyListeners();
  }

  String getDeadLine({required String deadline}) {
    if (deadline.isEmpty) {
      return '';
    }
    DateTime dateTime = DateTime.parse(deadline);
    final DateFormat formatter = DateFormat('dd MM');
    final String deadLine = formatter.format(dateTime);
    return deadLine;
  }

  Color getTaskPriority({required String priorityS}) {
    Priority priority = Priority.values.firstWhere((p) => p.name == priorityS, orElse: () => Priority.none);
    switch (priority) {
      case Priority.height:
        return Colors.red;
      case Priority.average:
        return Colors.yellow;
      case Priority.low:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Future<void> addNewTask() async {
    await Navigator.of(context).pushNamed(TaskDetailPage.route);
    await getTasks();
  }

  Future<void> updateTask({required TaskModel task}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskDetailPage.render(
                  task: task,
                  isEditeMode: true,
                )));
    await getTasks();
  }

  void deleteTask({required TaskModel task}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete task"),
            content: Text("Are you sure you want to delete task?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    await taskRepository.deleteTask(taskToDeleteId:task.id);
                    Navigator.of(context).pop();
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No"))
            ],
          );
        });
    await getTasks();
  }

  String getCreator({required int userId}) {
    UserModel user = _usersRepository.getUserById(id: userId);
    return user.name[0];
  }
}
