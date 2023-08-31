import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mathilde/services/firebase_services.dart';
import 'package:mathilde/views/congratulations/congratulations.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:mathilde/views/subscription/components/socialBtn.dart';
import 'package:mathilde/views/subscription/subscription.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';

class SubscriptionForm extends StatefulWidget {
  String plan;

  SubscriptionForm({super.key, required this.plan});

  @override
  State<SubscriptionForm> createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailOrNumberController = TextEditingController();
  bool _isSending = false;
  String? _emailOrPhone;

  Future<void> _sendEmail(String identifiant, String plan) async {
    String username =
        'harounakinda19@gmail.com'; // Remplacez par votre adresse e-mail
    String password = 'sagesse1404'; // Remplacez par votre mot de passe e-mail

    var smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Mathilde')
      ..recipients.add("harounakinda19@gmail.com")
      ..subject = "Abonnement à Mathilde"
      ..text =
          "<strong>Utilisateur :</strong> $identifiant <br /><strong>Formule d'abonnement :</strong> $plan";

    try {
      await send(message, smtpServer);
      print('E-mail envoyé');
    } on MailerException catch (e) {
      print('Erreur lors de l\'envoi de l\'e-mail : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 241, 240, 240),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
              child: Text(
                "Se connecter avec",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Form(
              key: _formKey,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: bgColor.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Icon(
                                Icons.email,
                                color: bgColor.withOpacity(0.7),
                              )),
                          const SizedBox(width: 14 / 2),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              controller: _emailOrNumberController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Entrer une adresse email ou numéro de téléphone valide";
                                }
                                return null;
                              },
                              onSaved: (value) => _emailOrPhone = value,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  hintText:
                                      "Adresse email ou numéro de téléphone",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]))),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: _isSending
                    ? SpinKitCircle(
                        color: bgColor.withOpacity(0.5),
                      )
                    : OutlinedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              _isSending = true;
                            });
                            emailSignIn();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => bgColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(13),
                          child: Text(
                            "Se connecter",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      )),
          ),
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 1,
                  color: Colors.grey,
                ),
                Text(
                  "Ou",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  googleSignIn();
                },
                child: SocialBtn(
                  text: "Se connecter avec google",
                  color: Colors.red.shade800,
                  image: "g",
                ),
              ),
              GestureDetector(
                  onTap: () {
                    facebookSignIn();
                  },
                  child: SocialBtn(
                    text: "Se connecter avec facebook",
                    color: Colors.blue.shade800,
                    image: "f",
                  ))
            ]),
          ),
        ],
      ),
    );
  }

  void emailSignIn() async {
    setState(() {
      _isSending = true;
    });

    await DataBaseService()
        .signInWithEmail(_emailOrNumberController.text, "mathildepassword");

    setState(() {
      _isSending = false;
    });
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            duration: const Duration(milliseconds: 700),
            childCurrent: Subscriptionpage(
              dayLetfIsZero: false,
            ),
            reverseDuration: const Duration(milliseconds: 700),
            child: CongratulationsPage(
              plan: widget.plan,
              userAddress: _emailOrNumberController.text,
            )));
  }

  void googleSignIn() async {
    setState(() {
      _isSending = true;
    });

    var userData = await DataBaseService().signInWithGoogle();

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            duration: const Duration(milliseconds: 700),
            childCurrent: Subscriptionpage(
              dayLetfIsZero: false,
            ),
            reverseDuration: const Duration(milliseconds: 700),
            child: CongratulationsPage(
              userAddress: userData.additionalUserInfo.toString(),
              plan: widget.plan,
            )));
  }

  void facebookSignIn() async {
    setState(() {
      _isSending = true;
    });
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              duration: const Duration(milliseconds: 700),
              childCurrent: Subscriptionpage(
                dayLetfIsZero: false,
              ),
              reverseDuration: const Duration(milliseconds: 700),
              child: CongratulationsPage(
                plan: widget.plan,
                userAddress: userData["email"],
              )));
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Echec de l'autentification"),
                content: Text(
                    "Un problème a survenu lors de la connexion à votre compte facebook"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Ok"))
                ],
              ));
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }
}
