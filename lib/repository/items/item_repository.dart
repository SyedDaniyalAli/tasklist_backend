import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

part 'item_repository.g.dart';

@visibleForTesting

/// Data Source in memory cache
Map<String, TaskItem> itemDb = {};

@JsonSerializable()

/// Task List class
class TaskItem extends Equatable {
  /// constructor
  const TaskItem({
    required this.listId,
    required this.description,
    required this.status,
    required this.id,
    required this.name,
  });

  ///de-serialization
  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);

  /// List's id
  final String id;

  /// List id where the item belongs
  final String listId;

  /// Items's name
  final String name;

  /// Items's description
  final String description;

  /// Items's status
  final bool status;

  /// serialization
  Map<String, dynamic> toJson() => _$TaskItemToJson(this);

  /// copyWith method
  TaskItem copywith({
    String? id,
    String? name,
    String? listId,
    String? description,
    bool? status,
  }) {
    return TaskItem(
      id: id ?? this.id,
      name: name ?? this.name,
      listId: listId ?? this.listId,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

///Repository class for TaskItem
class TaskItemRepository {
  ///check in the internal data source for an item with the given id
  Future<TaskItem?> itemById(String id) async {
    return itemDb[id];
  }

  /// Get all the items from data source
  Map<String, dynamic> getAllList() {
    // final formatedList = <String, dynamic>{};
    // if (listDb.isNotEmpty) {
    //   listDb.forEach((key, value) {
    //     final currentList = listDb[key];
    //     formatedList[key] = currentList?.toJson();
    //   }) as void Function(String key, TaskItem value);
    // }
    return itemDb;
  }

  ///Create a new item with a given information
  String createItem({
    required String name,
    required String listId,
    required String description,
    required bool status,
  }) {
    // Dynamically generates the id
    final id = name.hashValue;

    /// Create new TaskItem object and pass params
    final item = TaskItem(
      id: id,
      name: name,
      listId: listId,
      description: description,
      status: status,
    );

    /// Add a new TaskItem object to data source
    itemDb[id] = item;

    return id;
  }

  /// Deletes the TaskItem object with the given [id]
  void deleteItem(String id) {
    itemDb.remove(id);
  }

  /// Update TaskItem object
  Future<void> updateItem({
    required String id,
    required String name,
    required String listId,
    required String description,
    required bool status,
  }) async {
    final currentList = itemDb[id];
    if (currentList == null) {
      return Future.error(Exception('List not found'));
    }

    itemDb[id] = TaskItem(
      id: id,
      name: name,
      listId: listId,
      description: description,
      status: status,
    );
  }
}
