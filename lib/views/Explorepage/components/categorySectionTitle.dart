import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategorySectionTitle extends StatelessWidget {
  final String title;
  final String icon;
  CategorySectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/${icon}.svg",
            width: 13,
          ),
          Text(
            " ${title}",
            style: TextStyle(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
