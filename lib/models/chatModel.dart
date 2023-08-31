import 'package:flutter/material.dart';

class ChatModel {
  int? id;
  int? historiItemId;
  String user;
  String text;
  DateTime date;
  ChatModel(
      {this.id,
      this.historiItemId,
      required this.date,
      required this.text,
      required this.user});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'history_item_id': historiItemId,
      'user': user,
      'text': text,
      'date_sended': "${date}",
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> map) => new ChatModel(
      id: map['id'],
      historiItemId: map['history_item_id'],
      user: map['user'],
      text: map['text'],
      date: DateTime.parse(map['date_sended']));
}
