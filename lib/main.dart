import 'package:chatapp/helper/authenticate.dart';
import 'package:chatapp/views/signin.dart';
import 'package:chatapp/views/signup.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor:Color(0xff1F1F1F),
        primaryColor: Color(0xff145C9E),


        primarySwatch: Colors.blue,
      ),
      home:Authenticate(),
    );
  }
}

