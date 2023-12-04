import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

part 'list_repository.g.dart';

@visibleForTesting

/// Data Source in memory cache
Map<String, TaskList> listDb = {};

@JsonSerializable()

/// Task List class
class TaskList extends Equatable {
  /// constructor
  const TaskList({required this.id, required this.name});

  ///de-serialization
  factory TaskList.fromJson(Map<String, dynamic> json) =>
      _$TaskListFromJson(json);

  /// List's id
  final String id;

  /// List's name
  final String name;

  /// serialization
  Map<String, dynamic> toJson() => _$TaskListToJson(this);

  /// copyWith method
  TaskList copywith({
    String? id,
    String? name,
  }) {
    return TaskList(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  List<Object?> get props => [id, name];
}

///Repository class for TaskList
class TaskListRepository {
  ///check in the internal data source for a list with the given id
  Future<TaskList?> listById(String id) async {
    return listDb[id];
  }

  /// Get all the list from data source
  Map<String, dynamic> getAllList() {
    // final formatedList = <String, dynamic>{};
    // if (listDb.isNotEmpty) {
    //   listDb.forEach((key, value) {
    //     final currentList = listDb[key];
    //     formatedList[key] = currentList?.toJson();
    //   }) as void Function(String key, TaskList value);
    // }
    return listDb;
  }

  ///Create a new list with a given[name]
  String createList({required String name}) {
    // Dynamically generates the id
    final id = name.hashValue;

    /// Create new TaskList object and pass params
    final list = TaskList(id: id, name: name);

    /// Add a new TaskList object to data source
    listDb[id] = list;

    return id;
  }

  /// Deletes the TaskList object with the given [id]
  void deleteList(String id) {
    listDb.remove(id);
  }

  /// Update TaskList object
  Future<void> updateList({required String id, required String name}) async {
    final currentList = listDb[id];
    if (currentList == null) {
      return Future.error(Exception('List not found'));
    }

    listDb[id] = TaskList(id: id, name: name);
  }
}
