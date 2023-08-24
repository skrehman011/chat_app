import 'dart:convert';

import 'package:mondaytest/Models/message_model.dart';

class GroupInfo {
  String id, name;
  MessageModel? lastMessage;

//<editor-fold desc="Data Methods">
  GroupInfo({
    required this.id,
    required this.name,
    this.lastMessage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupInfo && runtimeType == other.runtimeType && id == other.id && name == other.name && lastMessage == other.lastMessage);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ lastMessage.hashCode;

  @override
  String toString() {
    return 'GroupInfo{' + ' id: $id,' + ' name: $name,' + ' lastMessage: $lastMessage,' + '}';
  }

  GroupInfo copyWith({
    String? id,
    String? name,
    MessageModel? lastMessage,
  }) {
    return GroupInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'lastMessage': jsonEncode(this.lastMessage?.toMap()),
    };
  }

  factory GroupInfo.fromMap(Map<String, dynamic> map) {
    return GroupInfo(
      id: map['id'] as String,
      name: map['name'] as String,
      lastMessage: MessageModel.fromMap(jsonDecode(map['lastMessage'].toString()) as Map<String, dynamic>),
    );
  }

//</editor-fold>
}