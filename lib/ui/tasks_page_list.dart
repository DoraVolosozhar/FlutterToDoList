import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/domain/models/task_model.dart';
import 'package:to_do_list/ui/list_of_tasks_state.dart';
import 'package:to_do_list/ui/list_of_tasks_view_model.dart';


/// Widget that describes the list of tasks cards.
class TaskPageList extends StatelessWidget {

  ///Constructor
  const TaskPageList({super.key});

  @override
  Widget build(BuildContext context) {
    final ListOfTasksState state = context.select((ListOfTasksViewModel viewModel) => viewModel.state);
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 12, top: 12),
            child: Text(
              'Need to do',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.merge(const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 20, bottom: 16, right: 20),
              children: state.tasks.map((TaskModel task) => _CardItem(task: task)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final ListOfTasksViewModel listOfTasksViewModel = context.read<ListOfTasksViewModel>();
    return InkWell(
      onTap: () => listOfTasksViewModel.updateTask(task: task),
      onDoubleTap: () =>  listOfTasksViewModel.deleteTask(task: task),
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 60,
              height: 20,
              decoration: BoxDecoration(
                  color: listOfTasksViewModel.getTaskPriority(priorityS: task.priority),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),),
            ),
            const SizedBox(height: 8),
            Text(
              task.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                const Icon(Icons.access_time_rounded),
                const SizedBox(width: 5),
                Text(
                  listOfTasksViewModel.getDeadLine(deadline: task.deadLine),
                  style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.align_horizontal_left_sharp, size: 18,),
                const Spacer(),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Text(
                        listOfTasksViewModel.getCreator(userId: task.creatorId),
                    ),
                  ),

              ],
            ),
          ],),
        ),
      ),
    );
  }
}
