import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RateLawyer extends StatefulWidget{


  RateLawyer({Key key});

  _RateLawyerState createState() => _RateLawyerState();
}


class _RateLawyerState extends State<RateLawyer>{


StreamController _streamController;

void initState() {
  super.initState();

  _streamController = new StreamController();
  Stream stream = _streamController.stream;
}

Widget build(BuildContext context){
  return Scaffold(

    appBar: AppBar(),

    body: Container(),
  );

}

}
