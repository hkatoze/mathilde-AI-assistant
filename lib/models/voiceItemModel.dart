import 'package:flutter/material.dart';

class VoiceItemModel {
  VoiceItemModel({required this.speechRate, required this.voice, this.id});

  String speechRate;
  String voice;
  int? id;

  Map<String, dynamic> toJson() {
    return {'id': id, 'speech_rate': speechRate, 'voice': voice};
  }

  factory VoiceItemModel.fromJson(Map<String, dynamic> map) =>
      new VoiceItemModel(
        speechRate: map['speech_rate'],
        voice: map['voice'],
      );
}
