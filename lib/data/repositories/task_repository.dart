import 'package:to_do_list/data/data_providers/task_provider.dart';
import 'package:to_do_list/domain/models/task_model.dart';


///Repository that helps to work TaskProvider
class TaskRepository{

    final TaskProvider _taskProvider = TaskProvider();

    /// Saves a task to the list of to-do tasks with a delay of 3 seconds.
    Future<void> setSaveTask({required TaskModel dataToSave}) async {
      await Future.delayed(const Duration(seconds: 3));
      await _taskProvider.setSaveTask(dataToSave: dataToSave);
    }

    /// This method retrieves all tasks from the database and returns them as a list of TaskModel objects.
    Future<List<TaskModel>> getTasks() async {
      final List<Map<String, dynamic>> rows = await _taskProvider.getTasks();
      return rows.map(TaskModel.fromMap).toList();
    }

    /// Updates a specific task in the database.
    Future<void> updateTask({required TaskModel updatedData}) async{
      await _taskProvider.updateTask(updatedData: updatedData);
    }

    ///  Deletes a specific task from the database.
    Future<void> deleteTask({required int taskToDeleteId}) async {
      await _taskProvider.deleteTask(taskToDeleteId: taskToDeleteId);
    }

}

