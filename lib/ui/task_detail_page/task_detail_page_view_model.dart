import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/data/repositories/task_repository.dart';
import 'package:to_do_list/data/repositories/users_repository.dart';
import 'package:to_do_list/domain/models/task_model.dart';
import 'package:to_do_list/domain/models/user_model.dart';
import 'package:to_do_list/ui/task_detail_page/task_detail_stage_state.dart';

///ViewModel for [TaskDetailPage]
class TaskDetailPageViewModel extends ChangeNotifier {


   ///Constructor
  TaskDetailPageViewModel({required this.context,  TaskModel? task, bool? isAdd}) {
    setInitials(task: task, editMode: isAdd);
  }


  /// Globalkey for Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///Context for widgets
  final BuildContext context;

  final TextEditingController _descriptionEditingController = TextEditingController();

  final TextEditingController _titleEditingController = TextEditingController();

  final TextEditingController _createDateEditingController = TextEditingController();

  final TextEditingController _deadlineEditingController = TextEditingController();

 ///Provider which connect DataModel object with View Model
  //final TaskProvider listOfTasksProvider = TaskProvider();
  final TaskRepository taskRepository = TaskRepository();

  /// Provider which connect UserModel object with repository
  final UsersRepository _usersRepository = UsersRepository();

  /// Gets the [TextEditingController] for the description field.
  TextEditingController get descriptionEditingController => _descriptionEditingController;

  /// Gets the [TextEditingController] for the create date field.
  TextEditingController get createDateEditingController => _createDateEditingController;

  /// Gets the [TextEditingController] for the title field.
  TextEditingController get titleEditingController => _titleEditingController;


  /// Gets the [TextEditingController] for the deadline field.
  TextEditingController get deadlineEditingController => _deadlineEditingController;

  TaskDetailPageState _state = const TaskDetailPageState();


  ///Key for FormState
  GlobalKey<FormState> get formKey => _formKey;

  /// Gets the state of the Task Detail page.
  ///
  /// The [_state] variable holds the state of the Task Detail page.
  TaskDetailPageState get state => _state;

  /// Define method to set the initial state
  void setInitials({required TaskModel? task, required bool? editMode}) {
    _state = _state.copyWith(taskModel: task, isEditMode: editMode,users: _usersRepository.users);
    if (!_state.isEditMode) return;
    _titleEditingController.text = _state.taskModel.title;
    _descriptionEditingController.text = _state.taskModel.description;
    _createDateEditingController.text = setFormattedDate(_state.taskModel.creationDate);
    _deadlineEditingController.text = setFormattedDate(_state.taskModel.deadLine);
    final UserModel user = _usersRepository.getUserById(id: _state.taskModel.creatorId);
    final Priority priority = Priority.values.firstWhere((p) => p.name == _state.taskModel.priority, orElse: () => Priority.none);
    _state = _state.copyWith(currentPriority: priority, currentUser: user);
    notifyListeners();
  }

  /// Function for formatting  date
  String setFormattedDate(String date) {
    final DateTime parsedDate =  DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd MM');
    return formatter.format(parsedDate);
  }


  ///Save deadLine
  Future<void> saveDeadLine() async {
    final DateTime? pickedTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),);
    if (pickedTime != null) {
      final DateFormat formatter = DateFormat('dd MM');
      _state = _state.copyWith(taskModel: _state.taskModel.copyWith(deadLine: pickedTime.toString()));
      notifyListeners();
      deadlineEditingController.text = formatter.format(pickedTime);
    }
  }

  /// Function for saving task created date
  Future<void> saveCreatedDate() async {
    final DateTime? pickedTime = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),);
    if(pickedTime != null) {
      final DateFormat formatter = DateFormat('dd MM');
      _state = _state.copyWith(taskModel: _state.taskModel.copyWith(creationDate: pickedTime.toString()));
      notifyListeners();
      createDateEditingController.text = formatter.format(pickedTime);
    }
  }

  /// Sets the priority for the task.
  Future<void> setPriority({required Priority? priority}) async {
    _state = _state.copyWith(taskModel: _state.taskModel.copyWith(priority: priority?.name));
    notifyListeners();
  }

  /// Returns the color associated with the given priority.
  Color getPriorityColor({required Priority priority}) {
    final Color priorityColor = switch (priority) {
      Priority.height => Colors.red,
      Priority.average => Colors.yellow,
      Priority.low => Colors.green,
      _ => Colors.grey,
    };
    return priorityColor;
  }

  /// Sets the creator for the task.
  Future<void> setCreator({UserModel? creator}) async {
    _state = _state.copyWith(taskModel: _state.taskModel.copyWith(creatorId: creator?.id ));
    notifyListeners();
  }


  /// Saves the task and navigates back.
  Future<void> setSaveTask() async {
    _state = _state.copyWith(isPending: true);
    notifyListeners();
    final TaskModel toDoItem = TaskModel(
      title: _titleEditingController.text,
      description: _descriptionEditingController.text,
      creationDate:  _state.taskModel.creationDate,
      deadLine: _state.taskModel.deadLine,
      priority: _state.taskModel.priority,
      creatorId: _state.taskModel.creatorId,
    );
    await taskRepository.setSaveTask(dataToSave: toDoItem);
    Navigator.of(context).pop();
  }


  /// Updates task and navigates back
  Future<void> setUpdateTask() async {
    notifyListeners();
    final TaskModel updateData = TaskModel(
      title: _titleEditingController.text,
      description: _descriptionEditingController.text,
      creationDate:  _state.taskModel.creationDate,
      deadLine: _state.taskModel.deadLine,
      priority: _state.taskModel.priority,
      creatorId: _state.taskModel.creatorId,
    );
    await taskRepository.updateTask(updatedData: updateData);
    Navigator.of(context).pop();
  }


/// Override dispose method to dispose of controllers when not in use
  @override
  void dispose() {
    _createDateEditingController.dispose();
     _descriptionEditingController.dispose();
     _titleEditingController.dispose();
     _deadlineEditingController.dispose();
    super.dispose();
  }
}
