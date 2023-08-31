import 'package:flutter/material.dart';
import 'package:mathilde/models/categoryModel.dart';

class CategoryItem extends StatelessWidget {
  final CategoryItemModel model;
  const CategoryItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 3, top: 10, bottom: 10),
        child: Material(
          borderRadius: BorderRadius.circular(25),
          elevation: 1.5,
          child: Container(
            width: 125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 226, 226, 226), //New
                    blurRadius: 1.0,
                    offset: Offset(0, 0))
              ],
              color: model.bgColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
              child: Center(
                child: Text(
                  "${model.title}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ));
  }
}
