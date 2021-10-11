import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CreateAccount.dart';
import 'HomePage.dart';

class Login extends StatefulWidget{
  @override

  Login({Key key}): super(key: key);

  _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login>{

  String _email, _password, _uid;
  final _auth = FirebaseAuth.instance;
  static final _formKey = new GlobalKey<FormState>();

  void initState(){
    super.initState();

  }
  Future<Widget> Noti(e) async{

    return showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("THIS ACCOUNT INFORMATION DOES NOT MATCH OUR RECORDS"),

          actions: <Widget>[
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            },
              child: Text("Return"))
            ],
        );
      }
    );
  }

  Future<User> _getUser() async{
    UserCredential userCred;
    final formState = _formKey.currentState;

    if(formState.validate()){
      formState.save();

      try{
        userCred = await _auth.signInWithEmailAndPassword(
            email: _email,
            password: _password);

      } on FirebaseAuthException catch(e){
        Noti(e);

      }
    }
    return userCred.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                image: AssetImage('lib/src/assets/books.jpg'),
                fit: BoxFit.cover),
          ),
          child: Center(

              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(

                    children: [
                      TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter something';
                          }
                          return  null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                        onChanged: (value){
                          setState(() {
                            _email = value.trim();
                          });
                        },
                      ),
                      TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter something';
                          }
                          return  null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                        ),
                        onChanged: (value){
                          setState(() {
                            _password = value.trim();
                          });
                        },
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                child: Text("Login"),
                                onPressed: (){
                                  _getUser().then((value) {
                                    print(value.uid); Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uid: value.uid)));
                                  });

                                },
                              ),
                              ElevatedButton(
                                child: Text("Create Account"),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount()));
                                },
                              ),
                            ],
                          ),
                      )
                    ],
                  ),
                ),
              ),
          ),
        ),

    );
  }

}