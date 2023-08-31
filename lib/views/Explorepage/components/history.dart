import 'package:flutter/material.dart';
import 'package:mathilde/models/historyModel.dart';
import 'package:mathilde/services/databaseManager.dart';
import 'historyItem.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  PageController controller = PageController(
    viewportFraction: 0.90,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HistoryItemModel>>(
        stream: DatabaseManager.instance.historyData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<HistoryItemModel>> snapshot) {
          if (snapshot.hasData) {
            List<HistoryItemModel> datas = snapshot.data!;
            return datas.isEmpty
                ? SizedBox()
                : Container(
                    height: 180,
                    child: PageView.builder(
                        controller: controller,
                        reverse: false,
                        itemCount: datas.length,
                        itemBuilder: ((context, index) {
                          final dataReversed = datas.reversed.toList();
                          final history = dataReversed[index];
                          return HistoryItem(
                            id: history.id!,
                            botMsg: history.botMsg,
                            userMsg: history.userMsg,
                            date: history.date_sended,
                          );
                        })));
          } else {
            return SizedBox();
          }
        });
  }
}
