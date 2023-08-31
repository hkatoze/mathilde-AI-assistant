import 'package:flutter/widgets.dart';
import 'package:mathilde/models/chatModel.dart';
import 'package:mathilde/models/historyModel.dart';
import 'package:mathilde/models/voiceItemModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._();

  static final DatabaseManager instance = DatabaseManager._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'mathilde_database.db'),
      onCreate: (db, version) {
        db.execute('''
    CREATE TABLE IF NOT EXISTS history_item (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_msg TEXT NOT NULL,
      bot_msg TEXT NOT NULL,
      date_sended TEXT NOT NULL
    )
  ''');
        db.execute(
          '''
CREATE TABLE IF NOT EXISTS chat (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  history_item_id INTEGER,
  user TEXT NOT NULL,
  text TEXT NOT NULL,
  date_sended DATETIME NOT NULL,
  FOREIGN KEY (history_item_id) REFERENCES history_item (id) ON DELETE CASCADE)

          ''',
        );
      },
      version: 1,
    );
  }

 

 

  Future<int> addHistoryItem(HistoryItemModel historyItemModel) async {
    final Database db = await database;

    return await db.insert(
      'history_item',
      historyItemModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateHistoryItem(HistoryItemModel historyItemModel) async {
    final Database db = await database;
    await db.update("history_item", historyItemModel.toJson(),
        where: "id = ?", whereArgs: [historyItemModel.id]);
  }

  void deleteHistoryItem(int id) async {
    final Database db = await database;
    db.delete("history_item", where: "id = ?", whereArgs: [id]);
  }

  Stream<List<HistoryItemModel>> historyData() async* {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('history_item');
    List<HistoryItemModel> historyData = List.generate(maps.length, (i) {
      return HistoryItemModel.fromJson(maps[i]);
    });

    if (historyData.isEmpty) {
      for (HistoryItemModel historyItem in defaultHistoryData) {
        addHistoryItem(historyItem);
      }
      historyData = defaultHistoryData;
    }

    yield historyData;
  }

  List<HistoryItemModel> defaultHistoryData = [];

  VoiceItemModel defaultVoiceValue =
      VoiceItemModel(id: 1, speechRate: "1x", voice: "Voice 1");

  //Chat CRUD FONCTION

  Future<int> addChat(ChatModel chatModel) async {
    final Database db = await database;

    return await db.insert(
      'chat',
      chatModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateChat(ChatModel chatModel) async {
    final Database db = await database;
    await db.update("chat", chatModel.toJson(),
        where: "id = ?", whereArgs: [chatModel.id]);
  }

  void deleteChat(int id) async {
    final Database db = await database;
    db.delete("chat", where: "id = ?", whereArgs: [id]);
  }

  Future<List<ChatModel>> chatData(int historyId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query('chat', where: "history_item_id = ?", whereArgs: [historyId]);
    List<ChatModel> chatData = List.generate(maps.length, (i) {
      return ChatModel.fromJson(maps[i]);
    });

    if (chatData.isEmpty) {
      for (ChatModel chatItem in defaultChatData) {
        addChat(chatItem);
      }
      chatData = defaultChatData;
    }

    return chatData;
  }

  List<ChatModel> defaultChatData = [];
}
