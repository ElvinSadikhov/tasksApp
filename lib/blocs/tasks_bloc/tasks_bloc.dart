// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteTask>(_onDeleteTask);
    on<DeleteAllRemovedTask>(_onDeleteAllRemovedTask);
    on<AddTaskToBookmarks>(_onAddTaskToBookmarks);
    on<RemoveTaskFromBookmarks>(_onRemoveTaskFromBookmarks);
    on<EditTask>(_onEditTask);
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
    List<Task> favoriteTasks = List.from(state.favoriteTasks);

    if (task.isDone!) {
      pendingTasks.insert(0, task.copyWith(isDone: false));
      completedTasks.remove(task);
      if (task.isFavorite!) {
        favoriteTasks = favoriteTasks
            .map<Task>((e) => e == task ? e.copyWith(isDone: false) : e)
            .toList();
      }
    } else {
      pendingTasks.remove(task);
      completedTasks.insert(0, task.copyWith(isDone: true));
      if (task.isFavorite!) {
        favoriteTasks = favoriteTasks
            .map<Task>((e) => e == task ? e.copyWith(isDone: true) : e)
            .toList();
      }
    }

    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
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

  void _onDeleteAllRemovedTask(
      DeleteAllRemovedTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: const <Task>[]));
  }

  void _onAddTaskToBookmarks(
      AddTaskToBookmarks event, Emitter<TasksState> emit) {
    final Task task = event.task;
    if (task.isFavorite!) return;
    final state = this.state;

    emit(TasksState(
        pendingTasks: task.isDone!
            ? state.pendingTasks
            : _findTaskAndChangeState(
                tasks: state.pendingTasks, task: task, isFavorite: true),
        completedTasks: task.isDone!
            ? _findTaskAndChangeState(
                tasks: state.completedTasks, task: task, isFavorite: true)
            : state.completedTasks,
        favoriteTasks: List.from(state.favoriteTasks)
          ..add(task.copyWith(isFavorite: true)),
        removedTasks: state.removedTasks));
  }

  void _onRemoveTaskFromBookmarks(
      RemoveTaskFromBookmarks event, Emitter<TasksState> emit) {
    final Task task = event.task;
    if (!event.task.isFavorite!) return;
    final state = this.state;

    emit(TasksState(
        pendingTasks: task.isDone!
            ? state.pendingTasks
            : _findTaskAndChangeState(
                tasks: state.pendingTasks, task: task, isFavorite: false),
        completedTasks: task.isDone!
            ? _findTaskAndChangeState(
                tasks: state.completedTasks, task: task, isFavorite: false)
            : state.completedTasks,
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: state.removedTasks));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;

    // all edited tasks will be in pending list
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: List.from(state.completedTasks)..remove(event.oldTask),
        favoriteTasks: event.oldTask.isFavorite!
            ? (List.from(state.favoriteTasks)
              ..remove(event.oldTask)
              ..insert(0, event.newTask))
            : state.favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.task)
          ..insert(
              0,
              event.task.copyWith(
                  isDone: false, isRemoved: false, isFavorite: false)),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  List<Task> _findTaskAndChangeState(
          {required List<Task> tasks,
          required Task task,
          bool? isDone,
          bool? isRemoved,
          bool? isFavorite}) =>
      List.from(tasks)
          .map<Task>((e) => e == task
              ? e.copyWith(
                  isDone: isDone, isRemoved: isRemoved, isFavorite: isFavorite)
              : e)
          .toList();

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
