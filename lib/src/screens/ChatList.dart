import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatRoom.dart';

class ChatList extends StatefulWidget{

  final uid;
  ChatList({Key key, this.uid}) : super(key:  key);

  ChatListState  createState() => ChatListState();

}

class ChatListState extends State<ChatList>{

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body:  Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').doc(widget.uid).collection('chats').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> docs){
              if(!docs.hasData){return Text("No Chats");}
              else{

                return Container(
                  child: ListView.builder(
                    itemCount: docs.data.docs.length,
                    itemExtent: 250.0,
                    itemBuilder: (context, int index){

                      return ListTile(
                        subtitle: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('chat').doc(docs.data.docs[index].id).snapshots(),
                          builder: (context,AsyncSnapshot<DocumentSnapshot> doc){
                            if(!doc.hasData){return CircularProgressIndicator();}
                            else{
                              var list = doc.data.data()['users'];
                              return StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection('users').doc(list[1]).snapshots(),
                                  builder: (context, AsyncSnapshot<DocumentSnapshot> doc){
                                    if(!doc.hasData){return CircularProgressIndicator();}
                                    else{
                                      return Text(doc.data.get('fName'));
                                    }
                                  });
                            }


                        },
                        ),
                        onTap: (){

                          String _user2;
                          //Get both user Id values
                          //split chatID
                          //whatever value dont match widget.id, set it to user2
                          var ids = docs.data.docs[index].id.split("_");
                          if(ids[0] == widget.uid){
                            _user2 = ids[1];
                          }else{
                            _user2 = ids[0];
                          }

                          var dr = FirebaseFirestore.instance.collection('users').doc(_user2);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(user: widget.uid, user2: dr, chatID: docs.data.docs[index].id, )));
                        },
                      );
                    },
                  ),
                );
              }
            }
          ),
        )
      );
  }
}