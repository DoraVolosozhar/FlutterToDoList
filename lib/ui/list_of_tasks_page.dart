
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/ui/list_of_tasks_view_model.dart';
import 'package:to_do_list/ui/tasks_page_list.dart';

///Widget that build list of tasks
class ListOfTasks extends StatelessWidget {

  ///Constructor
  const ListOfTasks({super.key});

  static const String route = '/';

  /// Renders the ListOfTasks as a widget.
  ///
  /// This method returns a ChangeNotifierProvider with a TaskDetailPageViewModel.
  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => ListOfTasksViewModel(context: context),
      child: const ListOfTasks(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ListOfTasksViewModel listOfTasksViewModel = context.read<ListOfTasksViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Tasks app'),
        actions: const [
          Icon(
            Icons.search,
          ),
          Icon(
            Icons.add_alert,
          ),
          Icon(
            Icons.more_vert,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12),
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: listOfTasksViewModel.addNewTask ,
            child: const Icon(Icons.add),),
      ),
      body: const SafeArea(
        child: TaskPageList(),
      ),
    );
  }
}
