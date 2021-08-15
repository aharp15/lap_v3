import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lap_v3/src/classes/Lawyers.dart';
import 'package:lap_v3/src/screens/BrowseIssues.dart';
import 'package:lap_v3/src/screens/LawyerList.dart';

class AddLawyer extends StatefulWidget{

  final String category;

  AddLawyer({Key key, this.category});


  _AddLawyerState createState() => _AddLawyerState();
}

class _AddLawyerState extends State<AddLawyer> {

  String _id;
  String _fName;
  String _lName;
  String _city;
  String _address;
  String _phone;
  String _email;
  String _firmName;
  String _url;
  double _rating;
  final _formKey = new GlobalKey<FormState>();


  Future<void> CreateLawyer() async{

    FirebaseFirestore _firestore =  FirebaseFirestore.instance;
    Lawyers lawyer;

      _id = new DateTime.now().toString();

      lawyer = new Lawyers(
        id: _id,
        fName: _fName,
        lName: _lName,
        city: _city,
        address: _address,
        phone: _phone,
        email: _email,
        firmName: _firmName,
        url: _url,
      );
      CollectionReference lawyerCollection = _firestore.collection('lawyers');
      await _firestore.runTransaction((Transaction txn) async{
         lawyerCollection.doc(_id).set(lawyer.toJSON());
      });
  }

  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                image: AssetImage('lib/src/assets/books.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _fName = value;
                              });
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return  "First Name can not be left empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "First Name",
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _lName = value;
                              });
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return "Last Name can not be left empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Last Name",
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return   "Email can not be left empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Email",
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _city = value;
                              });
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return "City can not be left empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "City",
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _address = value;
                              });
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return "Address can not be left empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Address",
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _firmName = value;
                              });
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return "Firm Name can not be left empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Firm Name",
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _phone = value;
                              });
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return "Phone Number can not be left empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Phone Number",
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _url = value;
                              });
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return  "Website URL can not be left empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Website URL",
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[900]
                ),
                child: TextButton(
                  child: Text("Add Lawyer",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    var _formState;
                    setState(() {
                      _formState = _formKey.currentState;
                    });

                    if(_formState.validate()){
                      _formState.save();
                      print(_fName);
                      CreateLawyer().then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerList(category: widget.category,)));
                      });

                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}