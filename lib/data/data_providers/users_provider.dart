import 'package:to_do_list/domain/models/user_model.dart';

///This class provides actions with UserModel objects.
///It contains methods to save and retrieve users
class UsersProvider {

  /// Private constructor to prevent direct instantiation of UsersProvider.
  factory UsersProvider() {return instance;}

  /// Private constructor to prevent direct instantiation of UsersProvider.
  UsersProvider._internal();

  /// Static instance of UsersProvider for singleton access.
  static UsersProvider instance = UsersProvider._internal();

  /// List of of users
  final List<UserModel> _users = [
    const UserModel(id: 1, name: 'Darya', surname: 'Volososhar'),
    const UserModel(id: 2, name: 'Margo', surname: 'Meow'),
    const UserModel(id: 3, name: 'Lesya', surname: 'Ukrainka'),
    const  UserModel(id: 4,name: 'Olga', surname: 'Kobylanska'),
    const UserModel(id: 5, name: 'Bohdan ', surname:  'Khmelnytsky'),
  ];

  /// This method returns List of all UserModels
  List<UserModel> get users => _users;

}
