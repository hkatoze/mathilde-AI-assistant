import "package:flutter/material.dart";
import 'package:mathilde/models/static_values.dart';
import 'package:mathilde/views/Explorepage/components/categorySection.dart';
import 'components/categoryItem.dart';
import 'components/categorySectionTitle.dart';
import 'components/history.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Explorepage extends StatefulWidget {
  Explorepage({
    super.key,
  });

  @override
  State<Explorepage> createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage> {
  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: currentWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(tileMode: TileMode.mirror, colors: [
          Color.fromARGB(255, 225, 214, 228),
          Color.fromARGB(255, 189, 219, 243),
        ])),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: currentHeight * 0.02),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Explore",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          History(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          CategorySectionTitle(
            title: "Travel & Explore",
            icon: "briefcase",
          ),
          CategorySection(
            data: category1Data,
          ),
          CategorySectionTitle(
            title: "Creative idea",
            icon: "light-bulb",
          ),
          CategorySection(
            data: category2Data,
          ),
          CategorySectionTitle(
            title: "Science & Learning",
            icon: "microscope",
          ),
          CategorySection(
            data: category3Data,
          ),
          CategorySectionTitle(
            title: "Beauty & Lifestyle",
            icon: "sun",
          ),
          CategorySection(
            data: category4Data,
          ),
          SizedBox(
            height: currentHeight * 0.01,
          )
        ]),
      ),
    );
  }
}
