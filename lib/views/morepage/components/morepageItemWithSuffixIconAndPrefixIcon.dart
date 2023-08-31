import 'package:flutter/material.dart';

class MorepageItemWithSuffixIconAndPrefixIcon extends StatelessWidget {
  const MorepageItemWithSuffixIconAndPrefixIcon(
      {super.key,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.wording});
  final String wording;
  final IconData prefixIcon;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return Container(
      width: currentWidth,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xFFf1f2f4), borderRadius: BorderRadius.circular(20)),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
            ),
            Icon(
              suffixIcon,
              size: 15,
              color: Colors.black.withOpacity(0.5),
            )
          ]),
    );
  }
}
