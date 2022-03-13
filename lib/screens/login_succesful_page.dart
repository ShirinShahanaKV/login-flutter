import 'package:flutter/material.dart';
import 'package:login_and_signin_flutter/models/user_model.dart';
import 'package:login_and_signin_flutter/services/login_service.dart';
import 'package:login_and_signin_flutter/services/signin_service.dart';

class LoginSuccessful extends StatelessWidget {
  final String emailId;
  final bool isLogIn;
  final String? name;
  final String? photourl;


 // final UserModel user;
   LoginSuccessful({Key? key, required this.emailId, required this.isLogIn, this.name,this.photourl}) : super(key: key);

  final  _signInService = GoogleSignin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.center, colors: [
              Colors.orange[900]!,
              Colors.orange[700]!,
              Colors.orange[400]!
            ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if(isLogIn ==false)CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(photourl!),
              ),
              SizedBox(height: 20,),
              if(isLogIn ==false) Text("Name : $name",
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),),
              SizedBox(height: 20,),
              Text("Email Id : $emailId",
                style: const TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),),

             // Text(user.token),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),

                    primary: Colors.white,
                    onPrimary: Colors.deepOrange,
                   /* minimumSize: Size(double.infinity, 50)*/),
                icon: Text('Logout',
                 ),
                label: Icon(Icons.logout),
                onPressed: () async {
                  if(isLogIn==true){
                    final logoutValue = await LoginService().logout();
                    if (logoutValue == true) {
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text(
                            'error with your token, have to login again',
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  } else {
                    _signInService.logout();
                    Navigator.of(context).pop();
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
