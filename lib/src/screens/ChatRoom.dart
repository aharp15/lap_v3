import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget{

  final String user;
  final String chatID;
  final DocumentReference user2;


  ChatRoom({Key key, this.user, this.user2, this.chatID}) : super(key: key);

  ChatRoomState createState() => ChatRoomState();

}

class ChatRoomState extends State<ChatRoom>{

  final _controller = new TextEditingController();

  Widget build(BuildContext context){
    return  Scaffold(
      appBar: AppBar(
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onEditingComplete: (){
                      setState(() {
                        _controller.text = _controller.text;
                      });
                    },
                  ),
                ),

                TextButton(
                    onPressed: (){
                      //get message
                      //Get timestamp
                      //Who sent it?
                      //Put it in a map -  TODO
                      if(_controller.text.isNotEmpty){
                        FirebaseFirestore.instance.runTransaction((transaction) async{
                          FirebaseFirestore.instance.collection('chat').doc(widget.chatID).collection('messages').add({'message': _controller.text,
                            'sentBy': widget.user,
                            'timestamp': DateTime.now().millisecondsSinceEpoch});

                          _controller.text = "";

                        });
                      }
                    },
                    child: Icon(Icons.send)
                )
              ],
            ),
          )

      ),
      //query a snapshot with the document in 'chat' that holds both user and user2 ids
      /*run  transactions
      * update - sender
      *        - timestamp
      *        - send controller.text as message*/
    body: Column(
      children:[
        Container(),
        Expanded(
          child: StreamBuilder(
            //USE CHATID FOR DOC ID
              stream: FirebaseFirestore.instance.collection('chat').doc(widget.chatID).collection('messages').orderBy('timestamp', descending: false).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> docs){
                if(!docs.hasData){ return Text("No  DATA");}
                else
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: docs.data.docs.length,
                      itemBuilder: (context, int index){
                        if(docs.data.docs.isNotEmpty){

                          if(docs.data.docs[index].get('sentBy') == widget.user){
                            return Padding(
                              padding: const EdgeInsets.only(left: 200.0),
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    color: Colors.blue[400],
                                    borderRadius: BorderRadius.circular(25.0)
                                ),
                                child: Text(
                                  docs.data.docs[index].get('message'),
                                ),
                              ),
                            );
                          }else{
                            return Padding(
                              padding: const EdgeInsets.only(right: 200.0),
                              child:  Container(
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    color: Colors.green[300],
                                    borderRadius: BorderRadius.circular(25.0)
                                ),
                                child: Text(docs.data.docs[index].get('message'),
                                ),
                              ),
                            );
                          }

                        }else{
                          return Text("fuck");

                        }

                      }
                  );

              }
          ),
        )
      ]
    )

    );
  }
}
