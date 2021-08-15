import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lap_v3/src/screens/LawyerProfile.dart';

import 'AddLawyer.dart';

class LawyerList extends StatefulWidget{

  final String category;
  final String uid;

  LawyerList({Key key, this.category, this.uid})  :  super(key: key);

  _LawyerListState createState() => _LawyerListState();
}

class _LawyerListState extends State<LawyerList>{

  /*
  * For ListTile Add:
  * firmName
  * City
  * Current Rating
  * */
  _ListLawyers(String _pCategory){

    return ;
}
  //pass category  into future  streambuilder
  //pass image path  into future  streambuilder
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(


        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                image: AssetImage('lib/src/assets/books.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              SizedBox(
                  height: 150.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2.0),
                      image: DecorationImage(
                          colorFilter: new ColorFilter.mode(Colors.yellow[300].withOpacity(0.25), BlendMode.srcOver),
                          image: AssetImage('lib/src/assets/books.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: Text("Browse " + widget.category + " Lawyers",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                      ),
                    ),
                  )
              ),
              Flexible(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('lawyers').where("category",  isEqualTo: widget.category).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> docs){
                      if(!docs.hasData){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else return ListView.builder(
                        itemCount: docs.data.docs.length,
                        itemBuilder: (context, int index){
                          return SingleChildScrollView(
                            child: GestureDetector(
                              child: Card(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        //avatar
                                        CircleAvatar(
                                          maxRadius: 50.0,
                                          minRadius: 30.0,
                                          backgroundImage: NetworkImage(docs.data.docs[index].get('picUrl')),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 80.0),
                                          child: Column(
                                            children: [
                                              Text(docs.data.docs[index].get('fName') + " " + docs.data.docs[index].get('lName'), style: TextStyle(
                                                  fontSize: 20.0
                                                ),
                                              ),
                                              Text(docs.data.docs[index].get('firmName')),
                                              Text(docs.data.docs[index].get('city')),

                                            ],
                                          ),
                                        )
                                      ],
                                      //info-Column
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                print(widget.uid);
                                print(widget.category);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerProfile(lawyer: docs.data.docs[index].reference, uid: widget.uid)));

                              },
                            ),
                          );
                        },
                      );
                    },
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                    color: Colors.blue[900]
                ),
                child: TextButton(
                  child: Text("Add a Lawyer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddLawyer(category: widget.category)));
                  },
                ),
              ),
            ],
          ),
        ),


    );
  }
}