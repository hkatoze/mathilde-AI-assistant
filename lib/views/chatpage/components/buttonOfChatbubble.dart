import 'package:flutter/material.dart';

class ButtonOfChatbubble extends StatelessWidget {
  final String title;
  final IconData icon;
  const ButtonOfChatbubble(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            child: Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 226, 226, 226), //New
                blurRadius: 1.0,
                offset: Offset(0, 0))
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 13,
                ),
                Text(
                  "  ${title}",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    )));
  }
}
