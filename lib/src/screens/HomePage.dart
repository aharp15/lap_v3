import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lap_v3/src/screens/ChatList.dart';
import 'package:lap_v3/src/screens/LeaveReview.dart';
import 'package:path/path.dart' as Path;

import 'package:lap_v3/src/screens/BrowseIssues.dart';

class HomePage extends StatefulWidget{

  final String uid;
  HomePage({Key key, this.uid}) : super(key: key);

  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

  String _fName;
  String _lName;
  List<String> _lawList;
  final picker = ImagePicker();
  File _imgFile;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState((){
      _imgFile = File(pickedFile.path);

    });

    uploadImageToFirebase(_imgFile);
  }

  Future<void> uploadImageToFirebase(File pImgFile) async {
    String url;
    try{
      await FirebaseStorage.instance.ref('uploads/${Path.basename(pImgFile.path)}').putFile(pImgFile).whenComplete(() async{
        url = await FirebaseStorage.instance.ref('uploads/${Path.basename(_imgFile.path)}').getDownloadURL().whenComplete((){

          FirebaseFirestore.instance.collection('urls').add({'url': url});

          FirebaseFirestore.instance.runTransaction((transaction) async{
            await FirebaseFirestore.instance.collection('users').doc(widget.uid).update({'picUrl': url});

          });

        });


      });

    } on FirebaseException catch (e) {
      print(e);
    }

  }

  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').doc(widget.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> doc){
                if(doc.hasData){
                  print(widget.uid);
                  return Text("Hello " +  doc.data['fName']);
                }
                return CircularProgressIndicator();

              },
            ),

          GestureDetector(
                 child: Icon(Icons.chat),
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatList(uid: widget.uid)));
                 },
               ),

          ],
        )

      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                image: AssetImage('lib/src/assets/books.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Stack(
                    children: [

                      Center(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('users').doc(widget.uid).snapshots(),
                          builder: (context, AsyncSnapshot<DocumentSnapshot> doc){
                            //String url = doc.data.get('picUrl');
                            if(!doc.hasData){
                              return Text("Fuck");
                            }
                            if(doc.data.get('picUrl') != ""){

                              return CircleAvatar(
                                maxRadius: 100.0,
                                backgroundImage: NetworkImage(doc.data.get('picUrl')),
                              );
                            }
                            if(doc.data.get('picUrl') == ""){
                              return CircleAvatar(
                                maxRadius: 100.0,
                                backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/lapv3-87afe.appspot.com/o/profilepic.jpg?alt=media&token=5f15764e-c8a1-4564-8bf9-0bb130fd3a04'),
                              );
                            }
                            else{
                              return CircleAvatar(
                                maxRadius: 100.0,
                                backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/lapv3-87afe.appspot.com/o/profilepic.jpg?alt=media&token=5f15764e-c8a1-4564-8bf9-0bb130fd3a04'),
                              );
                            }
                          },
                        ),
                      ),
                      Positioned(
                        left: 280.0,
                        top: 120.0,

                        child: FloatingActionButton(
                            backgroundColor: Colors.blueAccent,
                            child: Icon(
                                Icons.add
                            ),
                            onPressed: (){

                              pickImage();
                            }
                        ),
                      ),
                    ],
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100.0, bottom: 200.0),
                child: Column(
                  children: [
                    Container(
                        width: 300.0,
                        height: 50.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: ElevatedButton(
                          child: Text("Rate A Lawyer"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff2f72ad),

                          ),
                          onPressed: (){
                            print(widget.uid);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveReview(uid: widget.uid, lawList: _lawList)));
                          },
                        )
                    ),
                    Container(
                      width: 300.0,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: ElevatedButton(
                        child: Text("Find A Lawyer"),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffe0cf4a),
                        ),

                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BrowseIssues(uid: widget.uid,)));
                        },
                      ),
                    ),
                    Container(
                      width: 300.0,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: ElevatedButton(
                        child: Text("Black's Law Dictionary"),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff2f72ad),
                        ),

                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BrowseIssues(uid: widget.uid)));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('lawyers').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> docs){
                    if(!docs.hasData){
                      return CircularProgressIndicator();
                    }
                    if(docs.hasError){
                      return CircularProgressIndicator();

                    }
                    else{
                      var arr = <String>[];

                      for(int i = 0; i < docs.data.docs.length; i++) {
                        _fName = docs.data.docs[i].get('fName');
                        _lName = docs.data.docs[i].get('lName');
                        var _name = _fName + " " + _lName;
                        arr.add(_name);
                      }
                      print(arr);
                      //print(_lawList);
                      _lawList = arr;
                      return Container();
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

}