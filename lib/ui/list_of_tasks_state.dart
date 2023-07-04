import 'package:flutter/cupertino.dart';
import 'package:to_do_list/domain/models/task_model.dart';


///State for [ListOfTasksPage]
@immutable
class ListOfTasksState {

  ///Construct for ListOfTasksState object
  const ListOfTasksState({
    this.tasks = const [],
  });

  /// The list of tasks.
  final List<TaskModel> tasks;

  /// Creates a copy of the current ListOfTasksState instance with modified properties.
  ListOfTasksState copyWith({  List<TaskModel>? tasks}) {
    return ListOfTasksState(
      tasks: tasks ?? this.tasks,
    );
  }

}
