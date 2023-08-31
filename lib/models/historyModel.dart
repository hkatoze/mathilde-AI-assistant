import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItemModel {
  int? id;
  String userMsg;
  String botMsg;
  DateTime date_sended;

  HistoryItemModel(
      {this.id,
      required this.botMsg,
      required this.userMsg,
      required this.date_sended});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_msg': userMsg,
      'bot_msg': botMsg,
      'date_sended': "${date_sended}"
    };
  }

  factory HistoryItemModel.fromJson(Map<String, dynamic> map) =>
      new HistoryItemModel(
          id: map['id'],
          userMsg: map['user_msg'],
          botMsg: map['bot_msg'],
          date_sended: DateTime.parse(map['date_sended']));
}
