import 'package:to_do_list/domain/models/user_model.dart';

class UsersProvider {

  factory UsersProvider() {return instance;}

  /// Private constructor to prevent direct instantiation of UsersProvider.
  UsersProvider._internal();

  /// Static instance of UsersProvider for singleton access.
  static UsersProvider instance = UsersProvider._internal();

  /// List of of users
  final List<UserModel> _users = [
    UserModel(id: 1, name: "Darya", surname: "Volososhar"),
    UserModel(id: 2, name: "Margo", surname: "Meow"),
    UserModel(id: 3, name: "Lesya", surname: "Ukrainka"),
    UserModel(id: 4,name: "Olga", surname: "Kobylanska"),
    UserModel(id: 5, name: "Bohdan ", surname: "Khmelnytsky"),
  ];

  /// This method returns List of all UserModels
  List<UserModel> get users => _users;

}