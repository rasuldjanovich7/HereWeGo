import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/sign_in_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/utils_service.dart';

import 'home_page.dart';

class SignUp extends StatefulWidget {
  static const String id = 'sign_up_page';
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignUp(){
    String name = fullNameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();


    AuthService.signUpUser(context, name, email, password).then((firebase) => {
      _getFirebaseUser(firebase),
    });
  }

  _getFirebaseUser(User? firebaseUser) async {
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

              // #fullname
              TextField(
                controller: fullNameController,
                onTap: () {},
                decoration: const InputDecoration(
                    hintText: 'Fullname'
                ),
              ),
              const SizedBox(height: 10),
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

              // #signUp
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                color: const Color(0xFFf54335),
                child: TextButton(
                  onPressed: (){
                   _doSignUp();
                  },
                  child: const Text('Sign Up', style: TextStyle(color: Colors.white),),
                ),
              ),
              const SizedBox(height: 20),

              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Already have an account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, SignIn.id);
                    },
                    child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  )
                ],
              )

            ],
          ),
        )
    );
  }
}
