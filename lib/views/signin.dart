import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatRoomScreen.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController passwordTextEditingController =
  new TextEditingController();
  TextEditingController emailTextEditingController =
  new TextEditingController();
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  bool isLoading = false ;
  QuerySnapshot snapshotUserInfo ;

  signIn(){
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailInSharedPreference(emailTextEditingController.text);

      databaseMethods.getUserByUserEmail(emailTextEditingController.text).then((val){
        val = snapshotUserInfo ;
        HelperFunctions.saveUserNameInSharedPreference(snapshotUserInfo.documents[0].data['name']);
      });



      setState(() {
        isLoading = true ;
      });




      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        if(val!=null){
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(),
              ));

        }
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)
                              ? null
                              : "Enter correct email";
                        },
                        controller: emailTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Email"),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          return val.length < 6
                              ? "Enter Password 6+ characters"
                              : null;
                        },
                        controller: passwordTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Password"),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Text(
                      'Forget Password ?',
                      style: simpleTextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xff007EF4),
                        const Color(0Xff2A75BC),
                      ]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Sign In",
                      style: mediumTextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign In With Google",
                    style: TextStyle(color: Colors.black87, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don t have an account ?",
                      style: mediumTextStyle(),
                    ),
                    GestureDetector(
                      onTap: (){
                        widget.toggle() ;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


