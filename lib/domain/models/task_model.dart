// Importing required libraries
import 'package:flutter/cupertino.dart';


/// Enum representing the priority levels of a task.
enum Priority{ height, average, low, none }

/// Immutable class representing a task.
/// It's marked as `@immutable` which means all instance fields are final.
/// This is a data model class, where each instance represents a task.
@immutable
class TaskModel {

  /// Default constructor for TaskModel
  const TaskModel({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.creationDate = '',
    this.deadLine = '',
    this.priority = '',
    this.creatorId = -1,
  });

  /// Create a TaskModel from a Map
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['ID'] == null ? 0 : map['ID'] as int,
      title: map['TITLE'] == null ? '' : map['TITLE'] as String,
      description: map['DESCRIPTION'] == null ? '' : map['DESCRIPTION'] as String,
      creationDate: map['CREATIONDATE'] == null ? '' : map['CREATIONDATE'] as String,
      deadLine: map['DEADLINE'] == null ? '' : map['DEADLINE'] as String,
      priority: map['PRIORITY'] == null ? '' : map['PRIORITY'] as String,
      creatorId: map['CREATORID'] == null ? 0 : map['CREATORID'] as int,

    );
  }
  /// Unique identifier for a task
  final int id;

  /// Task title
  final String title;

  /// Task description
  final String description;

  /// Task creation date
  final String creationDate;

  /// Task deadline
  final String deadLine;

  /// Task priority
  final String priority;

  /// Task's creator id
  final int creatorId;

  /// Convert a TaskModel object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creationDate': creationDate,
      'deadLine': deadLine,
      'priority': priority,
      'creatorid': creatorId,
    };
  }

  /// Method to create a copy of a TaskModel but with optional replacements
  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    String? creationDate,
    String? deadLine,
    String? priority,
    int? creatorId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      deadLine: deadLine ?? this.deadLine,
      priority: priority ?? this.priority,
      creatorId: creatorId ?? this.creatorId,
    );
  }
}
