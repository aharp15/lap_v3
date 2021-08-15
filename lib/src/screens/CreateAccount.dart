import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lap_v3/src/screens/Login.dart';

import 'HomePage.dart';
import '../classes/User.dart';

class CreateAccount extends StatefulWidget{

  _CreateAccountState createState() => _CreateAccountState();

}

class _CreateAccountState extends State<CreateAccount>{

  String _fName,  _lName, _gender, _email, _password;
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore =  FirebaseFirestore.instance;
  Users _user;

  final _formKey = new GlobalKey<FormState>();

  Future<void> _createUser() async{
    UserCredential userCred;
    final formState = _formKey.currentState;

    if(formState.validate()){
      formState.save();

      try{
        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
            email: _email,
            password: _password
        );
        _user = new Users(
            fName: _fName,
            lName: _lName,
            email: _email,
            gender: _gender,
            password: _password,
            id: userCred.user.uid
        );

        CollectionReference userCollection = _firestore.collection('users');
        await _firestore.runTransaction((transaction) async{

          userCollection.doc(userCred.user.uid).set((_user.toJSON()));
        });

      } on FirebaseAuthException catch(e){
        if(e.code == 'user-not-found'){
          print("error");
        }
      }
    }
    //return userCred.user;
  }

  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Create an Account"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: AssetImage('lib/src/assets/books.jpg'),
              fit: BoxFit.cover
          ),
        ),child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "First Name",
                  ),
                  onChanged: (value){
                    setState(() {
                      _fName = value.trim();
                    });
                  },
                ),TextField(
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                  onChanged: (value){
                    setState(() {
                      _lName = value.trim();
                    });
                  },
                ),TextField(
                  decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.blueAccent
                          )
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.redAccent
                          )
                      )
                  ),
                  onChanged: (value){
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),TextField(
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  onChanged: (value){
                    setState(() {
                      _password = value.trim();
                    });
                  },
                ),TextField(
                  decoration: InputDecoration(
                    hintText: "Gender",
                  ),
                  onChanged: (value){
                    setState(() {
                      _gender = value.trim();
                    });
                  },
                ),

                ElevatedButton(
                    child: Text("Create Account"),
                    onPressed: (){
                      _createUser().then((value){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      });
                    }
                )
              ],
            ),
          )
      ),
      ),
    );
  }

}