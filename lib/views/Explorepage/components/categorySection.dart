import 'package:flutter/material.dart';
import 'package:mathilde/models/categoryModel.dart';
import 'package:mathilde/views/Explorepage/explorepage.dart';
import 'package:mathilde/views/chatpage/chatView.dart';
import 'package:page_transition/page_transition.dart';

import 'categoryItem.dart';

class CategorySection extends StatelessWidget {
  final List<CategoryItemModel> data;
  CategorySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      margin: EdgeInsets.only(top: 12, bottom: 3),
      child: ListView.builder(
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.scale,
                      alignment: Alignment.center,
                      duration: Duration(milliseconds: 300),
                      childCurrent: Explorepage(),
                      reverseDuration: Duration(milliseconds: 300),
                      child: ChatviewPage(
                        isNewDiscussion: true,
                        query: data[index].query,
                      )),
                );
              },
              child: CategoryItem(
                model: data[index],
              )))),
    );
  }
}
