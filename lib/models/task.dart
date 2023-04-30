// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  bool? isDone;
  bool? isRemoved;
  bool? isFavorite;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isDone,
    this.isRemoved,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isRemoved = isRemoved ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    bool? isDone,
    bool? isRemoved,
    bool? isFavorite,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: title ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isRemoved: isRemoved ?? this.isRemoved,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isDone': isDone,
      'isRemoved': isRemoved,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      isRemoved: map['isRemoved'] != null ? map['isRemoved'] as bool : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, date, isDone, isRemoved, isFavorite];
}
