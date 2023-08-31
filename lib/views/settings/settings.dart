import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mathilde/views/constants/change_theme.dart';
import 'package:provider/provider.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  String? mounthSelected;
  bool darkMode = false;

  final List<String> language = [
    'Français',
  ];
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                padding: EdgeInsets.all(5),
                width: 70,
                color: Colors.transparent,
                child: Center(
                    child: Icon(
                  Icons.close,
                  size: 35,
                  color: themeChange.darkTheme
                      ? Colors.white
                      : Colors.black.withOpacity(0.5),
                ))),
          )
        ],
      ),
      body: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "À propos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Langue",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 19),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  textStyle: TextStyle(color: Colors.black)),
                              onPressed: () {},
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Text(
                                    'Français',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  items: language
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: mounthSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      mounthSelected = value;
                                    });
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: 100,
                                  itemHeight: 40,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(children: [
                      Text(
                        "Mode sombre",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 19),
                      ),
                      Switch(
                          activeColor: Color(0xFF43d0ca),
                          value: themeChange.darkTheme,
                          onChanged: (bool value) {
                            themeChange.darkTheme = value;
                          })
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "Avec Mathilde profitez de la vie😋",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 16,
                                color: themeChange.darkTheme
                                    ? Colors.white
                                    : Colors.black),
                            text: "Ceci est la première ",
                            children: [
                          TextSpan(
                              text: "version 1.0.0\n",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: "Nous continuerons à "),
                          TextSpan(
                              text: "developper l'application, ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  "afin d'ajouter d'autres fonctionalités.\n\n"),
                          TextSpan(text: "fonctionnalités à venir :\n"),
                        ])),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "- Demander du contenu multimedia (musique,vidéos,images...) 🎶 📽 🖼",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "- Changer la langue de l'application",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "- Contrôle vocal de votre smartphone 🗣",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "- et plus...",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "All data provided by ",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            "OpenAI",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/openIA.png",
                                scale: 15,
                              )
                            ],
                          )
                        ]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                  ),
                  Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Développé par  ",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Column(
                            children: [
                              Image.asset(
                                themeChange.darkTheme
                                    ? "assets/images/white-logo.png"
                                    : "assets/images/black-logo.png",
                                scale: 3,
                              )
                            ],
                          )
                        ]),
                  ),
                ],
              ))),
    );
  }
}
