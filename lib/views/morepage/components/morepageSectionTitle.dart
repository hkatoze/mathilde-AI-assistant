import 'package:flutter/material.dart';

class MorepageSectionTitle extends StatelessWidget {
  const MorepageSectionTitle(
      {super.key,
      required this.prefixText,
      required this.suffixText,
      this.underText});

  final String prefixText;
  final String suffixText;
  final String? underText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${prefixText}",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Text(
              "${suffixText}",
              style:
                  TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6)),
            )
          ],
        ),
        if (underText != null)
          SizedBox(
            height: 20,
          ),
        if (underText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${underText}",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(0.5)),
                ),
              ),
              Text(
                "",
                style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.6)),
              )
            ],
          ),
      ],
    );
  }
}
