import 'package:flutter/material.dart';

class ButtonWithoutIcon extends StatelessWidget {
  const ButtonWithoutIcon(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.titleColor,
      required this.onPressed});
  final String title;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return Container(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: bgColor, // couleur de fond
            onPrimary: Colors.white, // couleur du texte
            side: BorderSide(
                color: Colors.black,
                width: 1), // couleur et largeur de la bordure
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: onPressed,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "${title} ",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, color: titleColor),
            ),
          )),
    );
  }
}
