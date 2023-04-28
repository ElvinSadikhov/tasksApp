// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final TasksState state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    final List<Task> pendingTasks = List.from(state.pendingTasks);
    final List<Task> completedTasks = List.from(state.completedTasks);

    if (task.isDone!) {
      pendingTasks.insert(0, task.copyWith(isDone: false));
      completedTasks.remove(task);
    } else {
      pendingTasks.remove(task);
      completedTasks.insert(0, task.copyWith(isDone: true));
    }

    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isRemoved: true))));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
