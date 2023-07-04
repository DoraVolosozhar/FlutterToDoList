import 'package:flutter/cupertino.dart';
import 'package:to_do_list/domain/models/task_model.dart';
import 'package:to_do_list/domain/models/user_model.dart';


/// The state of the [TaskDetailPage].
@immutable
class TaskDetailPageState {

  /// Constructs a TaskDetailPageState object.
  const TaskDetailPageState({
    this.taskModel = const TaskModel(),
    this.currentUser,
    this.users = const [],
    this.isPending=false,
    this.currentPriority,
    this.isEditMode = false});

  /// The task model associated with the Task Detail page.
  final TaskModel taskModel;
  /// Indicates whether the task is pending or not.
  final bool isPending;

  /// Indicates whether it is edit mode
  final bool isEditMode;

  /// List of all user that can create a task
  final List<UserModel> users;

  /// User that create a task
  final UserModel? currentUser;

  /// Task priority
 final Priority? currentPriority;

  /// Creates a copy of the current TaskDetailPageState instance with modified properties.
  TaskDetailPageState copyWith({
    TaskModel? taskModel,
    List<UserModel>? users,
    bool? isPending,
    bool? isEditMode,
    UserModel? currentUser,
    Priority? currentPriority
  }) {
    return TaskDetailPageState(
      taskModel: taskModel ?? this.taskModel,
      users: users ?? this.users,
      isPending: isPending ?? this.isPending,
      isEditMode: isEditMode?? this.isEditMode,
      currentUser: currentUser ?? this.currentUser,
      currentPriority: currentPriority ?? this.currentPriority,
    );
  }
}
