import "package:flutter/material.dart";

class MorepageItemWithPrefixImageAndSuffixIcon extends StatelessWidget {
  MorepageItemWithPrefixImageAndSuffixIcon(
      {super.key, required this.wording, required this.image});
  final String wording;
  final String image;

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
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/${image}"))),
                ),
                Text(
                  "   ${wording}",
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.black.withOpacity(0.5),
            )
          ]),
    );
  }
}
