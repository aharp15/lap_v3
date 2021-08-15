import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatRoom.dart';

class LawyerReviews extends StatefulWidget{

  final DocumentReference lawyer;
  final String uid;

  LawyerReviews({Key key, this.lawyer, this.uid});

  LawyerReviewsState createState() => LawyerReviewsState();

}


class LawyerReviewsState extends State<LawyerReviews>{

  Future<Widget> Noti(String _id) async{

    return showDialog(context: context,
        builder: (BuildContext context){

          var _user2 = FirebaseFirestore.instance.collection('users').doc(_id);
          return AlertDialog(
            title: StreamBuilder(
              stream: _user2.snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> doc){
                if(!doc.hasData){
                  return CircularProgressIndicator();
                }
                return Text("Reach out to " + doc.data.get('fName'));
              },
            ),

            actions: <Widget>[
              TextButton(
                  onPressed: (){

                    //generate CHAT ID
                    genChatId(String a, String b) {
                      if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
                        return "$b\_$a";
                      } else {
                        return "$a\_$b";
                      }
                    }
                    String chatID = genChatId(widget.uid, _user2.id);
                    
                    //Create Chat room with ID and both users
                    //Can pretty set() up with a list variable
                    FirebaseFirestore.instance.collection('chat').doc(chatID).set({'users':[widget.uid, _user2]});

                    /*FirebaseFirestore.instance.collection('users').doc(widget.uid).collection('chats').get().then((value){

                    });*/
                   /* FirebaseFirestore.instance.runTransaction((transaction)
                    async {
                      FirebaseFirestore.instance.collection('chat').doc(chatID).set({'chatID': chatID});
                    });
                    FirebaseFirestore.instance.runTransaction((transaction)
                    async {
                      FirebaseFirestore.instance.collection('users').doc(widget.uid).collection('chats').doc(chatID).set({'chatID': chatID});
                    });
                    FirebaseFirestore.instance.runTransaction((transaction)
                    async {
                      FirebaseFirestore.instance.collection('users').doc(_user2.id).collection('chats').doc(chatID).set({'chatID': chatID});
                    });*/


                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(user: widget.uid, user2: _user2, chatID: chatID,)));


                  },
                  child: Text("Absolutely!")
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Return")
              )
            ],
          );
        }
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("See What Others Have Said"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
              image: AssetImage('lib/src/assets/books.jpg'),
              fit: BoxFit.cover),
        ),

        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('reviews').where("lawyerId", isEqualTo: widget.lawyer.id).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> docs){
              if(!docs.hasData){
                return CircularProgressIndicator();
              }

              return ListView.builder(
                itemCount: docs.data.docs.length,
                itemExtent: 250.0,
                itemBuilder: (context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Card(
                        child: ListTile(
                          title: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('users').doc(docs.data.docs[index].get('uid')).snapshots(),
                            builder: (builder, AsyncSnapshot<DocumentSnapshot> doc){
                              if(!doc.hasData){
                                return CircularProgressIndicator();
                              }
                              return Text(doc.data.get('fName'));
                            },
                          ),
                          subtitle: SingleChildScrollView(
                            child: Text(docs.data.docs[index].get('content')),
                          ),
                          onTap: (){
                            var id = docs.data.docs[index].get('uid');
                            Noti(id).then((value) {});
                          },
                        ),
                      ),
                    ),
                  );

                },

              );
            },
          ),

      ),
    );
  }
}