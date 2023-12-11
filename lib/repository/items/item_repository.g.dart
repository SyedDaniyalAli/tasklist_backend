// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) => TaskItem(
      listId: json['listId'] as String,
      description: json['description'] as String,
      status: json['status'] as bool,
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'id': instance.id,
      'listId': instance.listId,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
    };
