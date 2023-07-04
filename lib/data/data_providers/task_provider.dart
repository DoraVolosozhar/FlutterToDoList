import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/db/db_provider.dart';
import 'package:to_do_list/domain/models/task_model.dart';

///This class provides actions with TaskModel objects.
///It contains methods to save and retrieve tasks

class TaskProvider {
  /// Factory constructor to return the singleton instance.
  ///
  /// Returns the singleton instance of TaskProvider stored in the
  /// TaskProvider.instance variable. This allows other parts of the
  /// application to access the same instance of TaskProvider throughout the
  /// application.
  factory TaskProvider() {return instance;}

  /// Private constructor to prevent direct instantiation of TaskProvider.
  TaskProvider._internal();

  /// Static instance of TaskProvider for singleton access.
  static TaskProvider instance = TaskProvider._internal();

  ///List of tasks
  List<TaskModel> toDoTasks = [];

  /// Saves a task to the list of to-do tasks with a delay of 3 seconds.
  Future<void> setSaveTask({required TaskModel dataToSave}) async {
    final List<Map<String, dynamic>> result = await DBProvider.db.query('Task');
    final int? count =  Sqflite.firstIntValue(result);
    dataToSave = dataToSave.copyWith(id:count);
    DBProvider.db.insert('Task', dataToSave.toMap());
  }

  /// This method retrieves the priority of a task based on its ID.
  // Future<String> getTaskPriority({required int TaskId}) async{
  //   final List<Map<String,dynamic>> result = await DBProvider.db.rawQuery("SELECT PRIORITY FROM TASK WHERE ID=?", [TaskId]);
  //   String taskPriority = result[0]["TITLE"];
  //   return taskPriority;
  // }

  /// This method retrieves all tasks from the database and returns them as a list of TaskModel objects.
  Future<List<Map<String, dynamic>>> getTasks() async {
    final List<Map<String, dynamic>> rows = await  DBProvider.db.query('TASK');
    return rows;
  }

  /// Updates a specific task in the database.
  Future<void> updateTask({required TaskModel updatedData}) async{
    await DBProvider.db.update('Task', updatedData.toMap(), 'id =?',  [updatedData.id]);
  }

  ///  Deletes a specific task from the database.
  Future<void> deleteTask({required int taskToDeleteId}) async {
    await DBProvider.db.delete("TASK", 'id=?',  [taskToDeleteId]);
  }

}
