import 'package:flutter/material.dart';
import 'package:to_do_list/ui/api_routes.dart';


/// The main application widget.
class Application extends StatelessWidget {

  ///Constructor
  const Application({super.key});


  @override
  Widget build(BuildContext context) {
    final AppNavigation navigation = AppNavigation();
    return MaterialApp(
      initialRoute: ApiRoutes.initialRoute,
      navigatorKey: navigation.navigationKey,
      routes:
        // ListOfTasks.route : (context) => ListOfTasks.render(),
        // TaskDetailPage.route: (context) => TaskDetailPage.render(),
        navigation.routes,
      //home: ListOfTasks.render(),
    );
  }
}
