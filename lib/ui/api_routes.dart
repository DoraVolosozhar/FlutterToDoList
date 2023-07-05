import 'package:flutter/cupertino.dart';
import 'package:to_do_list/ui/list_of_tasks_page.dart';
import 'package:to_do_list/ui/task_detail_page/task_detail_page.dart';

/// class that store API endpoint routes
abstract class ApiRoutes {
  /// main page endpoint
  static const initialRoute = '/';
  /// endpoint for adding new task
  static const taskDetailPageRoute = '/addNewTask';
}

///Class that controls navigation using endpoints
class AppNavigation {


  /// Factory constructor to return the singleton instance of ApiNavigation.
  factory AppNavigation() {
    return _instance;
  }

  AppNavigation._privateConstructor();

  static final AppNavigation _instance = AppNavigation._privateConstructor();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  ///Required navigation key
 GlobalKey<NavigatorState> get navigationKey => _navigatorKey;

 /// Method that returns map of routs to its widgets
final Map<String, Widget Function(BuildContext)> routes= <String, Widget Function(BuildContext)> {
    ApiRoutes.initialRoute : (context)  => ListOfTasks.render(),
    ApiRoutes.taskDetailPageRoute: (context) => TaskDetailPage.render(),

  };
}
