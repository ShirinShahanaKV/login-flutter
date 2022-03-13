import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_and_signin_flutter/models/signin_user_model.dart';
import 'package:login_and_signin_flutter/models/user_model.dart';
import 'package:login_and_signin_flutter/screens/login_succesful_page.dart';
import 'package:login_and_signin_flutter/services/login_service.dart';
import 'package:login_and_signin_flutter/services/signin_service.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final _loginService = LoginService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _signInService = GoogleSignin();

  @override
  void initState() {
    _emailController.clear(); //set the initial value of text field
    _passwordController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        //padding: EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.center, colors: [
          Colors.orange[900]!,
          Colors.orange[700]!,
          Colors.orange[400]!
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Welcome!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(

                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]!))),
                              child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,

                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.grey),
                                  hintText: 'Email Id',
                                  hintStyle:
                                      TextStyle(fontSize: 16, color: Colors.grey),

                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]!))),
                              child: TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,

                                  prefixIcon:
                                       Icon(Icons.lock, color: Colors.grey),
                                  hintText: 'Password',
                                  hintStyle:
                                      TextStyle(fontSize: 16, color: Colors.grey),

                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text("Forgot Password?",
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),

                              primary: Colors.deepOrange,
                              onPrimary: Colors.white,
                              minimumSize: Size(double.infinity, 50)),
                          onPressed: () async {
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              UserModel? user = await _loginService.login(
                                  _emailController.text,
                                  _passwordController.text);
                              if (user != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => LoginSuccessful(
                                        emailId: user.email, isLogIn: true),
                                  ),
                                );
                                _emailController.clear();
                                _passwordController.clear();
                              } else {
                                showTopSnackBar(
                                  context,
                                  const CustomSnackBar.info(
                                    message: "Email or Password incorrect",
                                    backgroundColor: Colors.orange,
                                  ),
                                  displayDuration: const Duration(milliseconds: 1000),
                                );
                                return;
                              }
                            } else {
                              showTopSnackBar(
                                context,
                                const CustomSnackBar.info(
                                  message: "Enter email and password",
                                  backgroundColor: Colors.orange,
                                ),
                                displayDuration: const Duration(milliseconds: 1000),
                              );
                            }
                          },
                          icon:
                          const Icon(Icons.mail,color: Colors.white,),
                          label: const Text("Login with Email")),

                     // ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Divider(
                        height: 50,
                        thickness: 2,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),

                              primary: Colors.deepOrange,
                              onPrimary: Colors.white,
                              minimumSize: Size(double.infinity, 50)),
                          onPressed: () async {
                            UserModelSignIn _userModel =
                                await _signInService.googleLogin();

                            if (_userModel.email != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => LoginSuccessful(
                                      emailId: _userModel.email!,
                                      name: _userModel.name!,
                                      photourl: _userModel.photourl!,
                                      isLogIn: false),
                                ),
                              );
                              _emailController.clear();
                              _passwordController.clear();
                            }
                          },
                          icon:
                              const FaIcon(FontAwesomeIcons.google, color: Colors.white),
                          label: const Text("Sign In with Google"))
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
