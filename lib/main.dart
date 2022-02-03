import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/sign_in_page.dart';
import 'package:herewego/pages/sign_up_page.dart';
import 'package:herewego/services/prefs_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:const FirebaseOptions(
    apiKey: "AIzaSyCjParRuCQuG_K5oWGTQ0oLCnrnkngszpc",
    appId: "1:733381878838:android:c7c657f2aec93492022497",
    messagingSenderId: "733381878838",
    projectId: "herewego-b938c",
  ),);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  // Widget _startPage(){
  //   return StreamBuilder<User>(
  //     stream: FirebaseAuth.instance.currentUser,
  //     builder: (BuildContext context, snapshot){
  //       if(snapshot.hasData){
  //         Prefs.saveUserId(snapshot.data!.uid);
  //         return const HomePage();
  //       }else{
  //         Prefs.removeUserId();
  //         return const SignIn();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignIn(),
      routes: {
        SignIn.id: (context) => const SignIn(),
        SignUp.id: (context) => const SignUp(),
        HomePage.id: (context) => const HomePage(),
        DetailPage.id: (context) => const DetailPage()
      },
    );
  }
}
