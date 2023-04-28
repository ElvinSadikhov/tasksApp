import 'package:flutter_tasks_app/blocs/bloc_exports.dart';

class Formatter {
  Formatter._();

  static formatTasksCounterTitle(TasksState tasksState) =>
      "${tasksState.pendingTasks.length} Pending | ${tasksState.completedTasks.length} Completed";
}
