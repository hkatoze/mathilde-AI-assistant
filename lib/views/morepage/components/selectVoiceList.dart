import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathilde/models/voiceItemModel.dart';
import 'package:mathilde/services/databaseManager.dart';

class SelectVoiceList extends StatefulWidget {
  const SelectVoiceList({super.key});

  @override
  State<SelectVoiceList> createState() => _SelectVoiceListState();
}

class _SelectVoiceListState extends State<SelectVoiceList> {
  double speechRate = 0.55;
  double voice = 1.2;
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('speech_rate', speechRate);
    await prefs.setDouble('voice', voice);
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      speechRate = prefs.getDouble('speech_rate') ?? 0.55;
      voice = prefs.getDouble('voice') ?? 1.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  _saveSettings();
                  Navigator.pop(context);
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    width: 50,
                    color: Colors.transparent,
                    child: Center(
                        child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    )))),
            title: Text(
              "Voice",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: currentWidth * 0.05,
                  ),
                  Text(
                    "Speech rate",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFf1f2f4)),
                    child: Column(children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            speechRate = 0.55;
                          });
                        },
                        child: OptionItem(
                          label: '0.5x',
                          isChecked: speechRate == 0.55 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            speechRate = 0.75;
                          });
                        },
                        child: OptionItem(
                          label: '0.75x',
                          isChecked: speechRate == 0.75 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            speechRate = 1.0;
                          });
                        },
                        child: OptionItem(
                          label: '1x',
                          isChecked: speechRate == 1.0 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            speechRate = 1.5;
                          });
                        },
                        child: OptionItem(
                          label: '1.5x',
                          isChecked: speechRate == 1.5 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            speechRate = 2.0;
                          });
                        },
                        child: OptionItem(
                          label: '2x',
                          isChecked: speechRate == 2.0 ? true : false,
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Voice",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFf1f2f4)),
                    child: Column(children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            voice = 0.5;
                          });
                        },
                        child: OptionItem(
                          label: "Voice 1",
                          isChecked: voice == 0.5 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            voice = 0.7;
                          });
                        },
                        child: OptionItem(
                          label: "Voice 2",
                          isChecked: voice == 0.7 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            voice = 1.0;
                          });
                        },
                        child: OptionItem(
                          label: "Voice 3",
                          isChecked: voice == 1.0 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            voice = 1.2;
                          });
                        },
                        child: OptionItem(
                          label: "Voice 4",
                          isChecked: voice == 1.2 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            voice = 1.5;
                          });
                        },
                        child: OptionItem(
                          label: "Voice 5",
                          isChecked: voice == 1.5 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            voice = 1.7;
                          });
                        },
                        child: OptionItem(
                          label: "Voice 6",
                          isChecked: voice == 1.7 ? true : false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            voice = 2.0;
                          });
                        },
                        child: OptionItem(
                          label: "Voice 7",
                          isChecked: voice == 2.0 ? true : false,
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          _saveSettings();
          return true;
        });
  }
}

class OptionItem extends StatefulWidget {
  OptionItem({super.key, required this.isChecked, required this.label});
  final String label;
  final bool isChecked;

  @override
  State<OptionItem> createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.label}"),
            Icon(
              Icons.check,
              color: widget.isChecked ? Colors.green : Color(0xFFf1f2f4),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey.withOpacity(0.1),
        )
      ]),
    );
  }
}
