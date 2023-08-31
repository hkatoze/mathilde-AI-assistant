import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mathilde/models/chat_model.dart';
import 'package:mathilde/services/firebase_services.dart';
import 'package:mathilde/services/openai_services.dart';
import 'package:mathilde/views/constants/change_theme.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:mathilde/views/home/widgets/camera.dart';
import 'package:mathilde/views/home/widgets/chatBubble.dart';
import 'package:mathilde/views/home/widgets/freeDayLeftBanner.dart';
import 'package:mathilde/views/home/widgets/settingsBtn.dart';
import 'package:mathilde/views/home/widgets/updateBanner.dart';
import 'package:mathilde/views/notificationsPage/notification_services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mathilde/views/subscription/subscription.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Home extends StatefulWidget {
  final String? query;

  const Home({super.key, this.query});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController queryController = TextEditingController();
  NotificationServices notificationServices = NotificationServices();
  bool _isFirstTime = true;
  bool _isNext = false;
  bool _isText = true;
  bool _updateIsAvailable = false;
  bool _isMaths = false;
  List<ChatMessage> chatList = [];
  final ScrollController _chatListScrollController = ScrollController();
  final ScrollController _introducingScrollController = ScrollController();

  int daysLeft = 30;

  final BannerAd myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-6361469072497972/9524797309',
      listener: BannerAdListener(),
      request: AdRequest());

  void initState() {
    super.initState();
    myBanner.load();
    if (widget.query != null) {
      queryController.text = widget.query!;
    }
    _getDayLeft();
    _checkFirstTime();
    updateIsAvailable();
    Future.delayed(Duration(milliseconds: 3000), () {
      setStateIfMounted(() {
        _isNext = true;
      });
    });

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    //notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print('device token');
      print(value);
    });
  }

  void scrollToEnd() {
    _chatListScrollController.animateTo(
      _chatListScrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  void sendQuery() async {
    setState(() {
      chatList.add(ChatMessage(text: queryController.text.trim(), user: "Moi"));
      chatList.add(ChatMessage(text: "", user: "Mathilde"));
    });

    var query = queryController.text.trim();
    queryController.clear();
    String mathildeResponse = await ApiServices.sendMessage(query);

    scrollToEnd();

    setState(() {
      chatList.last.text = mathildeResponse.trim();
    });
    scrollToEnd();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    setState(() {
      _isFirstTime = isFirstTime;
    });
    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }
  }

  void _getDayLeft() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int initialDays = prefs.getInt('initialDays') ?? 30;

    DateTime lastOpened = DateTime.parse(
        prefs.getString('lastOpened') ?? DateTime.now().toString());

    // Calculate the number of days since the last app open
    int daysSinceLastOpened = DateTime.now().difference(lastOpened).inDays;

    // Calculate the new number of days left
    int newDaysLeft = initialDays - daysSinceLastOpened;

    setState(() {
      daysLeft = newDaysLeft;
    });

    // Save the new number of days left and the current date

    prefs.setInt('initialDays', initialDays);
    prefs.setString('lastOpened', DateTime.now().toString());
  }

  updateIsAvailable() async {
    bool isAvailable = await DataBaseService().UpdateAvailable();

    setState(() {
      _updateIsAvailable = isAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final _user = Provider.of<User?>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            "Mathilde",
            style: TextStyle(
                color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
          ),
          leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/icon.png",
                  scale: 20,
                ),
              )),
          actions: [
            _updateIsAvailable ? UpdateBanner() : FreeDayLeftBanner(),
            SettingsBtn(
              dayLeftIsZero: false,
            )
          ],
        ),
        body: Container(
          child: Column(children: [
            if (chatList.isNotEmpty)
              Expanded(
                  child: Container(
                      child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.773,
                        child: ListView.builder(
                            controller: _chatListScrollController,
                            physics: BouncingScrollPhysics(),
                            itemCount: chatList.length,
                            itemBuilder: ((context, index) => ChatBubble(
                                index: index,
                                chatLength: chatList.length,
                                text: chatList[index].text,
                                user: chatList[index].user))),
                      )
                    ]),
              ))),
            if (chatList.isEmpty)
              Expanded(
                child: Container(
                    child: SingleChildScrollView(
                  controller: _introducingScrollController,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        "assets/images/icon.png",
                                        scale: 25,
                                      ),
                                    ),
                                    Container()
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: DefaultTextStyle(
                                    style: const TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: 'Agne',
                                    ),
                                    child: AnimatedTextKit(
                                      isRepeatingAnimation: false,
                                      pause: Duration(milliseconds: 5000),
                                      animatedTexts: [
                                        TypewriterAnimatedText(
                                            _isFirstTime
                                                ? 'Coucou soit la bienvenue 😊, je suis Mathilde ton assistante IA !'
                                                : "Coucou content de te revoir 😊, Que puis je pour toi !",
                                            textStyle: TextStyle(
                                                color: themeChange.darkTheme
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                            speed: Duration(milliseconds: 65)),
                                      ],
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: DefaultTextStyle(
                                    style: const TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: 'Agne',
                                      color: Colors.grey,
                                    ),
                                    child: Visibility(
                                        visible: _isNext,
                                        child: AnimatedTextKit(
                                          isRepeatingAnimation: false,
                                          pause: Duration(milliseconds: 5000),
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                                "Tu as besoin de faire quelque chose ? Demande moi , par exemple:\n\n✍ D'écrire un mail , une courte histoire ou même un essai\n\n🗨 De Créer un article pour ton blog ou ta page sociale\n\n🗣 De Traduire un texte d'une langue à une autre\n\n💡 De Trouvez des idées pour ton prochain projet\n\n👩‍🎓 De t'aider à réviser tes cours\n\nEt même t'aider à devenir la meilleure version de toi même...🤗",
                                                textStyle: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                speed:
                                                    Duration(milliseconds: 65)),
                                          ],
                                          onTap: () {},
                                        )),
                                  ),
                                ),
                              ]),
                        )
                      ]),
                )),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Container(
                  margin: EdgeInsets.all(5),
                  child: SpeedDial(
                    animatedIcon: AnimatedIcons.menu_close,
                    backgroundColor: bgColor,
                    animationCurve: Curves.ease,
                    animatedIconTheme: IconThemeData(size: 22.0),
                    useRotationAnimation: true,
                    activeIcon: Icons.close,
                    animationDuration: Duration(milliseconds: 300),
                    spacing: 3,
                    children: [
                      SpeedDialChild(
                          child: Icon(Icons.photo),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Capture',
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.scale,
                                    alignment: Alignment.center,
                                    duration: Duration(milliseconds: 300),
                                    childCurrent: Home(),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: CameraScreen()));
                          }),
                      /*        SpeedDialChild(
                    child: Text("√x"),
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    label: 'Maths',
                    onTap: () {},
                  ), */
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/motif.jpg"))),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFf6f7fb),
                    border: Border.all(color: Color(0xFFcbcbcb)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextField(
                      controller: queryController,
                      maxLines: null,
                      expands: true,
                      onTap: () {},
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        suffix: GestureDetector(
                            onTap: () {
                              sendQuery();
                            },
                            child: CircleAvatar(
                                backgroundColor: bgColor,
                                child: Icon(
                                  Icons.send,
                                  size: 18,
                                  color: Colors.white,
                                ))),
                        border: InputBorder.none,
                        hintText: "Allez demande moi quelque chose ! ☺",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.none,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
