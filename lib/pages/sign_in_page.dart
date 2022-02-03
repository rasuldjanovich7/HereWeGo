import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/sign_up_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/utils_service.dart';

import 'home_page.dart';

class SignIn extends StatefulWidget {
  static const String id = 'sign_in_page';

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignIn(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if(email.isEmpty || password.isEmpty) return;
    AuthService.signInUser(context, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser),
    });
  }

  _getFirebaseUser(User? firebaseUser) async{
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // #email
              TextField(
                controller: emailController,
                onTap: () {},
                decoration: const InputDecoration(
                    hintText: 'Email'
                ),
              ),

              // #password
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                controller: passwordController,
                onTap: () {},
                decoration: const InputDecoration(
                    hintText: 'Password'
                ),
              ),

              // #signIn
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                color: const Color(0xFFf54335),
                child: TextButton(
                  onPressed: (){
                    _doSignIn();
                  },
                  child: const Text('Sign In', style: TextStyle(color: Colors.white),),
                ),
              ),
              const SizedBox(height: 20),

              // Don't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Don't have an account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, SignUp.id);
                    },
                    child: const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  )
                ],
              )

            ],
          ),
        )
    );
  }
}
