// Importing required Flutter library
import 'package:flutter/cupertino.dart';

/// The `@immutable` annotation ensures that this class can only be assigned once, at its instantiation.
/// This helps with performance and predictability of the code. All instance fields must be final.
@immutable
class UserModel {

  /// Constructor for UserModel.
  /// Takes an ID, a name and a surname. All values are optional and have default values.
  const UserModel({
    this.id = 0,
    this.name = '',
    this.surname = '',
  });
  /// Name of the user
  final String name;

  /// Surname of the user
  final String surname;

  /// Unique identifier for a user
  final int id;

  /// Override equality operator to compare objects of UserModel.
  /// Two UserModel objects are equal if they are identical (refer to the same instance),
  /// or if their runtime types are the same and their surnames are equal.
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserModel && runtimeType == other.runtimeType && surname == other.surname;

  /// Override hashCode to provide a hash code consistent with this class's equality operator.
  /// Two objects that are equal according to the `==` operator must return the same hash code.
  @override
  int get hashCode => surname.hashCode;
}
