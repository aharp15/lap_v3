import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

import 'LeaveReview.dart';
import 'LawyerReviews.dart';

class LawyerProfile extends StatefulWidget{

  final DocumentReference lawyer;
  final String uid;

  LawyerProfile({Key key, this.lawyer, this.uid});

  _LawyerProfileState createState() => _LawyerProfileState();
}

class _LawyerProfileState extends State<LawyerProfile>{


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
        await FirebaseFirestore.instance.collection('lawyers').doc(widget.lawyer.id).update({'picUrl': url});

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
        title: Text("Lawyer Profile"),
      ),
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage('lib/src/assets/books.jpg'),
                  fit: BoxFit.cover),
            ),
        child: Center(
                child: Column(
                    children: [
                      Container(
                        height: 150.0,
                        margin: EdgeInsets.only(bottom: 100.0),
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blueAccent, width: 2.0),
                                        image: DecorationImage(
                                            colorFilter: new ColorFilter.mode(Colors.yellow[300].withOpacity(0.5), BlendMode.srcOver),
                                            image: AssetImage('lib/src/assets/more books.jpeg'),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                ),
                            Positioned(
                              top: 50.0,
                              left: .0,
                              right: .0,
                              child: Center(
                                child: StreamBuilder(
                                  stream: widget.lawyer.snapshots(),
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
                            ),
                          ],
                        ),
                      ),

                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Card(
                                  child: Container(
                                    width: 300.0,
                                    height: 300.0,
                                    child: StreamBuilder(
                                      stream: widget.lawyer.snapshots(),
                                      builder: (context, AsyncSnapshot<DocumentSnapshot> doc){

                                        CollectionReference reviews = widget.lawyer.collection('reviews');

                                        if(doc.hasData){
                                          print(widget.lawyer.id);

                                          return SizedBox(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    doc.data.get('fName') + " " + doc.data.get('lName'),
                                                    style: TextStyle(
                                                        fontSize: 25.0
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text(doc.data.get('firmName'),
                                                    style: TextStyle(
                                                        fontSize: 20.0
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text(doc.data.get('category'),
                                                    style: TextStyle(
                                                        fontSize: 20.0
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text(doc.data.get('phone'),
                                                    style: TextStyle(
                                                        fontSize: 20.0
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text(doc.data.get('email'),
                                                    style: TextStyle(
                                                        fontSize: 20.0
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text(doc.data.get('websiteUrl'),
                                                    style: TextStyle(
                                                        fontSize: 20.0
                                                    ),
                                                  ),
                                                ),
                                                StreamBuilder(
                                                    stream: FirebaseFirestore.instance.collection('reviews').where('lawyerId', isEqualTo: widget.lawyer.id).snapshots(),
                                                    builder: (context, AsyncSnapshot<QuerySnapshot> docs){
                                                      if(!docs.hasData){return Container();}
                                                      else {
                                                        var stars = [];

                                                        double ratingsToAvg = 0.0;
                                                        double overallRating = 0.0;
                                                        for(int i = 0; i < docs.data.docs.length; i++){
                                                          ratingsToAvg += double.parse(docs.data.docs[i].get('rating'));
                                                        }


                                                        overallRating = ratingsToAvg/docs.data.docs.length;

                                                        FirebaseFirestore.instance.collection('lawyers').doc(widget.lawyer.id).update({'rating': overallRating});
                                                        for(int i = 0; i < overallRating.ceil(); i++){
                                                          stars.add(Icon(Icons.star, color: Colors.yellow, size: 40.0,));
                                                        }
                                                        return Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            ...stars,
                                                          ],
                                                        );

                                                      }

                                                    }
                                                )
                                                /*MAKE FIELDS FOR:
                            * address
                            * phone number
                            * website
                            * firm title
                            * Get rating code*/
                                              ],
                                            ),
                                          );
                                        }
                                        return CircularProgressIndicator();
                                      },
                                    ),
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child:
                                  Container(
                                    margin: EdgeInsets.only(top: 50.0),
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent
                                    ),
                                    child: TextButton(
                                      child: Text("Ask a Past Client"),
                                      style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          textStyle: TextStyle(
                                              fontSize: 20
                                          )
                                      ),

                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerReviews(lawyer: widget.lawyer, uid: widget.uid)));

                                      },
                                    ),
                                  ),

                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
      ),

    );
  }
}