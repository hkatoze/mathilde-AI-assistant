import 'package:flutter/material.dart';

class MorepageItemWithPrefixIcon extends StatelessWidget {
  const MorepageItemWithPrefixIcon(
      {super.key, required this.prefixIcon, required this.wording});
  final String wording;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
            height: 35,
            width: 35,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 206, 205, 205)),
            child: Center(
              child: Icon(
                prefixIcon,
              ),
            )),
        Text(
          "   ${wording}",
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }
}
