import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lap_v3/src/screens/Login.dart';

class App extends StatelessWidget {

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lawyer App',
      theme: ThemeData(
        accentColor: Colors.amberAccent,
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }

}
