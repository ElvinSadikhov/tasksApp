// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  bool? isDone;
  bool? isRemoved;

  Task({
    required this.id,
    required this.title,
    this.isDone,
    this.isRemoved,
  }) {
    isDone = isDone ?? false;
    isRemoved = isRemoved ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    bool? isDone,
    bool? isRemoved,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isRemoved: isRemoved ?? this.isRemoved,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isDone': isDone,
      'isRemoved': isRemoved,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      isRemoved: map['isRemoved'] != null ? map['isRemoved'] as bool : null,
    );
  }

  @override
  List<Object?> get props => [id, title, isDone, isRemoved];
}
