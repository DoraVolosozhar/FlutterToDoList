import 'package:to_do_list/data/data_providers/users_provider.dart';
import 'package:to_do_list/domain/models/user_model.dart';

class UsersRepository {

  final _usersProvider = UsersProvider();

  /// This method returns List of all UserModels
  List<UserModel> get users => _usersProvider.users;

  /// This method returns UserModel object by  it id
  UserModel getUserById({required int? id}) {
    List<UserModel> users = _usersProvider.users;
    return users.firstWhere((user) => user.id == id);
  }

}