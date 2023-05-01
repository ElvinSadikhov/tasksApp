import 'package:flutter_tasks_app/blocs/bloc_exports.dart';

import '../consts/app_strings.dart';

class Formatter {
  Formatter._();

  static formatTasksCounterTitle(TasksState tasksState) =>
      "${tasksState.pendingTasks.length} ${AppStrings.pending} | ${tasksState.completedTasks.length} ${AppStrings.completed}";
}
