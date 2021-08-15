import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lap_v3/src/classes/Review.dart';
import '../classes/Lawyers.dart';
class LeaveReview extends StatefulWidget{

  final String uid;
  final String lawyerId;

  LeaveReview({Key key, this.uid, this.lawyerId}) : super(key: key);

  _LeaveReviewState createState() => _LeaveReviewState();

}

class _LeaveReviewState extends State<LeaveReview>{
  String _chosenValue = ' ';
  Lawyers _lawyer;
  TextEditingController _contentController = new TextEditingController();
  double _rating;

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
                                  String _fName;
                                  String _lName;
                                  String _name;
                                  var arr = <String>[];
                                  for(int i = 0; i < docs.data.docs.length; i++){
                                    _fName = docs.data.docs[i].get('fName');
                                    _lName = docs.data.docs[i].get('lName');
                                    _name = _fName + " " + _lName;
                                    arr.add(_name);
                                  }
                                  print(arr[0]);
                                  //_chosenValue = arr[0];
                                  return Column(
                                    children: [
                                      DropdownButton<String>(
                                        items: arr.map<DropdownMenuItem<String>>((String value){
                                          return DropdownMenuItem(
                                              value: value,
                                              child: Text(value)
                                          );
                                        }).toList(),
                                        hint:  Text("Choose a Lawyer"),
                                        onChanged: (String value){
                                          setState(() {
                                            _chosenValue = value;


                                          });
                                        },
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection('lawyers').where('fName', isEqualTo: _chosenValue.split(" ").first).snapshots(),
                                        builder: (context, AsyncSnapshot<QuerySnapshot> doc){
                                          if(!doc.hasData){
                                            print('fuck');
                                            return Container();
                                          }
                                          else if(doc.hasData){
                                            //String _lawyerID = doc.data.docs[0].get('id');
                                            // print(_lawyerID);
                                            return Column(
                                              children: [
                                                Text(doc.data.docs[0].get('fName') + " " + doc.data.docs[0].get('lName')),
                                                Text(doc.data.docs[0].get('firmName')),
                                                Text(doc.data.docs[0].get('category')),
                                                Text(doc.data.docs[0].get('address')),
                                                Text(doc.data.docs[0].get('phone')),

                                              ],
                                            );
                                          }
                                          else{
                                            return CircularProgressIndicator();
                                          }
                                        },

                                      ),



                                    ],
                                  );
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
                      initialRating: 1.0,
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
                              lawyerId: widget.lawyerId,
                              content: _contentController.text,
                              rating: '$_rating'
                          );

                          await _firestore.runTransaction((Transaction txn) async{
                            reviewCollection.doc(_rid).set(review.toJSON());
                          });

                          await _firestore.runTransaction((Transaction txn) async{
                            lawyerCollection.doc(widget.lawyerId).collection('reviews').add({'id': _rid});
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