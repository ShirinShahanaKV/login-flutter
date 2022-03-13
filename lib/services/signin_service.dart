import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_and_signin_flutter/models/signin_user_model.dart';

class GoogleSignin extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future<UserModelSignIn> googleLogin() async {
   // try {
      UserModelSignIn _userModel = UserModelSignIn();
      GoogleSignInAccount? googleUser;
       googleUser = await GoogleSignIn(scopes: ['profile', 'email'])
          .signIn(); //The popup will be displayed
      if (googleUser == null) return _userModel;
      _user = googleUser;
      _userModel.name = _user?.displayName;
      _userModel.email = _user?.email;
      _userModel.photourl = _user?.photoUrl;
      _userModel.id = _user?.id;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("credentials are $credential");
      return _userModel;
   /* } catch(e){
      print(e.toString());
    }*/

   // return _user!;
  //notifyListeners();
  }

  Future logout() async{
    await googleSignIn.disconnect();
    print("google signed out");
    await FirebaseAuth.instance.signOut();
    print("firbase signed out");
  }
}