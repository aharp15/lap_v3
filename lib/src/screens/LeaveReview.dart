import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lap_v3/src/classes/Review.dart';
import '../classes/Lawyers.dart';
class LeaveReview extends StatefulWidget{

  final String uid;
  final List<String> lawList;
  LeaveReview({Key key, this.uid, this.lawList}) : super(key: key);

  _LeaveReviewState createState() => _LeaveReviewState();

}

class _LeaveReviewState extends State<LeaveReview>{
  String _chosenValue;
  String _listValue = " ";
  TextEditingController _contentController = new TextEditingController();
  double _rating = 0.0;
  String _lawyerID;

  String _fName;
  String _lName;
  Future<List<String>>  _lawList;


  /**************Rating Radio Buttons*******************/
  Widget _radio(int value) {
    return Expanded(
      child: RadioListTile(
        value: value,
        groupValue: _rating,
        dense: true,
        title: Text(
          '$value',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12.0,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _rating = value;
            print('$_rating');
          });
        },
      ),
    );
  }

  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Tell Us About Your Experience"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
              image: AssetImage('lib/src/assets/books.jpg'),
              fit: BoxFit.cover),
        ),
       child:  Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 100.0),
            child: Container(
              child: Column(
                children: [


                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Container(
                        height: 300.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Column(
                          children: [
                          DropdownButton<String>(
                          value: _chosenValue,
                          onChanged: (value){

                            setState(() {
                              _chosenValue = value;
                              _listValue = _chosenValue;
                            });
                            print(_chosenValue);


                          },
                          items: widget.lawList.map((String _value){
                            return DropdownMenuItem<String>(
                              value: _value,
                              child: Text(_value),

                            );

                          }).toList(),
                          hint:  Text("Choose a Lawyer"),

                        ),

                            /*FutureBuilder<List<String>>(
                                future: widget.lawList,
                                builder: (context, snapshot){
                                  
                                  //if(!snapshot.hasData){return CircularProgressIndicator();}
                                   if(snapshot.hasData){
                                    return
                                  }
                                  else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                    return Container();
                                }),*/

                            /*FutureBuilder(
                                future: getLawyer(),
                                builder: (context, AsyncSnapshot<Lawyers> snap){
                                  if(!snap.hasData){ return Container();}
                                  else if(snap.hasData){
                                    return Column(
                                      children: [

                                      ],
                                    );
                                  }
                                  else{
                                    return Text('fuck');
                                  }
                                }
                            ),*/
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('lawyers').where('fName', isEqualTo: _listValue.split(" ").firstWhere((element) => element != ''  , orElse: () => null)).snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> doc){
                        if(!doc.hasData){

                          return Container();
                        }
                        else if(doc.hasError){

                          print('fuck');
                          return Text("fuck");

                        }
                        else if(doc.hasData){

                          // print(_lawyerID);
                          //CircularProgressIndicator();
                          //print(_fName);
                          _lawyerID = doc.data.docs.first.get('id');
                          print(_lawyerID);
                          return Column(

                            children: [
                              Text(doc.data.docs.first.get('fName')),
                              Text(doc.data.docs.first.get('lName')),
                              Text(doc.data.docs.first.get('firmName')),
                              Text(doc.data.docs.first.get('id')),
                            ],
                          );
                        }


                        else{
                          //print(_lawList.last);

                          return CircularProgressIndicator();
                        }
                      },

                    ),

                            Padding(
                                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                                child: SingleChildScrollView(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[350],
                                        borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    child: TextFormField(
                                      controller: _contentController,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),

                                    ),
                                  ),
                                )
                            )
                          ],
                        )
                    ),
            ),

                  RatingBar.builder(
                      initialRating: 0.0,
                      itemCount: 5,
                      itemSize: 70.0,
                      allowHalfRating: true,
                      itemBuilder: (context, index){
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.star,
                              color: Colors.yellow,
                            );
                          case 1:
                            return Icon(
                              Icons.star,
                              color: Colors.yellow,
                            );
                          case 2:
                            return Icon(
                              Icons.star,
                              color: Colors.yellow,
                            );
                          case 3:
                            return Icon(
                              Icons.star,
                              color: Colors.yellow,
                            );
                          case 4:
                            return Icon(
                              Icons.star,
                              color: Colors.yellow,
                            );
                        }
                        return null;
                      },
                      onRatingUpdate: (value){
                        setState(() {
                          _rating = value;
                        });
                        print(_rating);
                      }
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: ElevatedButton(
                        child: Text("Submit"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          minimumSize: Size(150.0, 50.0)
                        ),
                        onPressed: () async {
                          print(widget.uid);
                          FirebaseFirestore _firestore =  FirebaseFirestore.instance;
                          CollectionReference reviewCollection = _firestore.collection('reviews');
                          CollectionReference lawyerCollection = _firestore.collection('lawyers');
                          String _rid = "r" + DateTime.now().toString();

                          Review review =  new Review(
                              rid: _rid,
                              uid: widget.uid,
                              lawyerId: _lawyerID,
                              content: _contentController.text,
                              rating: '$_rating'
                          );

                          await _firestore.runTransaction((Transaction txn) async{
                            reviewCollection.doc(_rid).set(review.toJSON());
                          });

                          await _firestore.runTransaction((Transaction txn) async{
                            lawyerCollection.doc(_lawyerID).collection('reviews').add({'id': _rid});
                            Navigator.of(context).pop();
                          });
                        }
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