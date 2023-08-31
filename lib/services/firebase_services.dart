import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DataBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference variables =
      FirebaseFirestore.instance.collection('variables');

  CollectionReference users =
      FirebaseFirestore.instance.collection('subscriptersList');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Connection with google
  Future<UserCredential> signInWithGoogle() async {
// Active authentication stream
    final googleUser = await _googleSignIn.signIn();

    //get autorization request details
    final googleAuth = await googleUser!.authentication;
    //Create new ID
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    //If I'm connecte, return user ID

    return await _auth.signInWithCredential(credential);
  }

  // Get state of User
  Stream<User?> get user => _auth.authStateChanges();

  Future<String> apikey() async {
    DocumentSnapshot apikeyDoc = await variables.doc('apikey').get();

    if (apikeyDoc.exists) {
      Map<String, dynamic> data = apikeyDoc.data() as Map<String, dynamic>;
      String apiValue = data['api'];

      return apiValue;
    } else {
      // Le document n'existe pas
      return "";
    }
  }

  Future<bool> UpdateAvailable() async {
    DocumentSnapshot app_version_available =
        await variables.doc('app-version-available').get();

    if (app_version_available.exists) {
      Map<String, dynamic> data =
          app_version_available.data() as Map<String, dynamic>;
      bool app_version_available_value = data['fromVersion1'];

      return app_version_available_value;
    } else {
      // Le document n'existe pas
      return false;
    }
  }

  Future<String> updateLink() async {
    DocumentSnapshot updateLink = await variables.doc('updateLink').get();

    if (updateLink.exists) {
      Map<String, dynamic> data = updateLink.data() as Map<String, dynamic>;
      String updateLinkValue = data['value'];

      return updateLinkValue;
    } else {
      // Le document n'existe pas
      return "";
    }
  }

  void addSubscription(String userAddress, String plan) {
    users.add({
      "userAddress": userAddress,
      "plan": plan,
    });
  }

  Future signInWithEmail(String email, String password) async {
    try {
      final UserCredential authResult =
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      final User? user = authResult.user;

      return user;
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }
}
