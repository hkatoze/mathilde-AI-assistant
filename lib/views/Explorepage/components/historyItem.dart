import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mathilde/models/historyModel.dart';
import 'package:mathilde/views/Explorepage/explorepage.dart';
import 'package:mathilde/views/chatpage/chatPreviewPage.dart';
import 'package:page_transition/page_transition.dart';

class HistoryItem extends StatelessWidget {
  int id;
  String userMsg;
  String botMsg;
  DateTime date;
  HistoryItem(
      {required this.id,
      required this.botMsg,
      required this.userMsg,
      required this.date});

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 300),
                  childCurrent: Explorepage(),
                  reverseDuration: Duration(milliseconds: 300),
                  child: ChatPreviewPage(
                    historyModel: HistoryItemModel(
                        id: id,
                        botMsg: botMsg,
                        date_sended: date,
                        userMsg: userMsg),
                  )));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
              color: Color(0xFFf1f2f4),
              borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "History",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      "${DateFormat.yMMMMd().format(date)} - ${DateFormat('HH:mm').format(date)} ",
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.7)),
                    ),
                    Icon(
                      Icons.sms,
                      size: 13,
                      color: Colors.black.withOpacity(0.7),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 209, 209, 209),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 65, 64, 64),
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  "${userMsg}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14),
                ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                    height: 25,
                    width: 25,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Image.asset("assets/images/icon_prev_ui.png"),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  "${botMsg}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14),
                ))
              ],
            )
          ]),
        ));
  }
}
