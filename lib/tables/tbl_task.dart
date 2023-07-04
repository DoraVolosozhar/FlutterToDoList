/// The `Task` class represents the schema for a task in the database.
class Task {
  /// The name of the table in the database.
  String tableName = 'Task';

  /// A map where each key-value pair represents a column in the database table.
  /// The key is the name of the column and the value is the data type of the column.
  Map<String,String> colums = {
    'ID': 'INTEGER',       // The ID of the task. This is usually the primary key.
    'DESCRIPTION': 'STRING', // The description of the task.
    'CREATIONDATE' : 'STRING' ,
    'DEADLINE': 'STRING',   // The deadline for the task.
    'PRIORITY': 'STRING',   // The priority level of the task.
    'CREATORID': 'INTEGER', // The ID of the user who created the task.
  };
}
