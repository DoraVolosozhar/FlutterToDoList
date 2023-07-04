import 'package:flutter/cupertino.dart';
import 'package:to_do_list/ui/list_of_tasks_page.dart';
import 'package:to_do_list/ui/task_detail_page/task_detail_page.dart';

abstract class ApiRoutes {
  static const initialRoute = '/';
  static const taskDetailPageRoute = '/addNewTask';
}


class AppNavigation {

  AppNavigation._privateConstructor();

  static final AppNavigation _instance = AppNavigation._privateConstructor();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

 GlobalKey<NavigatorState> get navigationKey => _navigatorKey;

  factory AppNavigation() {
    return _instance;
  }

final Map<String, Widget Function(BuildContext)> routes= <String, Widget Function(BuildContext)> {
    ApiRoutes.initialRoute : (context)  => ListOfTasks.render(),
    ApiRoutes.taskDetailPageRoute: (context) => TaskDetailPage.render(),

  };
}