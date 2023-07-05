// Flutter and Dart package imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/data/repositories/task_repository.dart';
import 'package:to_do_list/data/repositories/users_repository.dart';
import 'package:to_do_list/db/db_provider.dart';
import 'package:to_do_list/domain/models/task_model.dart';
import 'package:to_do_list/domain/models/user_model.dart';
import 'package:to_do_list/ui/list_of_tasks_state.dart';
import 'package:to_do_list/ui/task_detail_page/task_detail_page.dart';

/// ViewModel for the ListOfTasks screen
class ListOfTasksViewModel extends ChangeNotifier {

  /// Constructor takes in context and initializes the viewmodel
  ListOfTasksViewModel({required this.context}) {
    initialze();
  }

  /// Initializes database and fetches tasks on creation
  Future<void> initialze() async {
    await DBProvider.db.initDatabase();
    await getTasks();
  }

  /// BuildContext to be used within the viewmodel
  final BuildContext context;

  /// Repositories for tasks and users
  final TaskRepository taskRepository = TaskRepository();
  final UsersRepository _usersRepository = UsersRepository();

  /// State object for the ListOfTasks screen
  ListOfTasksState _state = const ListOfTasksState();

  /// Getter for the state object
  ListOfTasksState get state => _state;

  /// Fetch tasks from repository
  Future<void> getTasks() async {
    final List<TaskModel> tasks = await taskRepository.getTasks();
    _state = _state.copyWith(tasks: tasks);
    notifyListeners();
  }

  /// Formats deadline date into 'dd MM' format
  String getDeadLine({required String deadline}) {
    if (deadline.isEmpty) {
      return '';
    }
    final DateTime dateTime = DateTime.parse(deadline);
    final DateFormat formatter = DateFormat('dd MM');
    final String deadLine = formatter.format(dateTime);
    return deadLine;
  }
  /// Returns Color based on task priority
  Color getTaskPriority({required String priorityS}) {
    final Priority priority = Priority.values.firstWhere((p) => p.name == priorityS, orElse: () => Priority.none);
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

  /// Navigation to TaskDetailPage for creating a new task
  Future<void> addNewTask() async {
    await Navigator.of(context).pushNamed(TaskDetailPage.route);
    await getTasks();
  }

  /// Navigation to TaskDetailPage for updating an existing task
  Future<void> updateTask({required TaskModel task}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailPage.render(
          task: task,
          isEditeMode: true,
        ),),);
    await getTasks();
  }


  /// Deletes a task after user confirmation
  Future<void> deleteTask({required TaskModel task}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete task'),
          content: const Text('Are you sure you want to delete task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await taskRepository.deleteTask(taskToDeleteId:task.id);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),)
          ],
        );
      },);
    await getTasks();
  }
  /// Fetches the name of the creator based on userId
  String getCreator({required int userId}) {
    final UserModel user = _usersRepository.getUserById(id: userId);
    return user.name[0];
  }
}
