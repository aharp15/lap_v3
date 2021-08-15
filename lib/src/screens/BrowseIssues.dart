import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lap_v3/src/screens/AddLawyer.dart';
import 'package:lap_v3/src/screens/LawyerList.dart';

class BrowseIssues extends StatefulWidget{

  final String uid;
  BrowseIssues({Key key, this.uid}) :  super(key: key);

  _BrowseIssuesState createState() =>  _BrowseIssuesState();
}

class _BrowseIssuesState extends State<BrowseIssues>{

  String _category;


  Widget LawyerButton(String _pCategory, String _pUid){

    return Container(
      height: 100,
      width: 300,
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.blueAccent
        ),
        image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.yellowAccent[200].withOpacity(0.5), BlendMode.srcOver),
            image: AssetImage('lib/src/assets/books.jpg'), //Make relative path parameter
            fit: BoxFit.cover),
      ),
      child: FlatButton(
        child: Text(_pCategory),

        onPressed: () async{
          setState(() {
            _category  =  _pCategory;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: _pUid)));
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: _pUid)));
        },
      ),
    );
}


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("What Kind of Lawyer Do You Need?"),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                image: AssetImage('lib/src/assets/books.jpg'),
                fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueAccent
                        ),
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(Colors.yellow[300].withOpacity(0.2), BlendMode.srcOver),
                            image: AssetImage('lib/src/assets/way more books.jpeg'), //Make relative path parameter
                            fit: BoxFit.cover),
                      ),
                      child: TextButton(
                        child: Text("CIVIL",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                        ),

                        onPressed: () async{
                          setState(() {
                            _category  = 'Civil';
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: widget.uid)));
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: _pUid)));
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueAccent
                        ),
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(Colors.yellow[600].withOpacity(0.4), BlendMode.srcOver),
                            image: AssetImage('lib/src/assets/scales.jpeg'), //Make relative path parameter
                            fit: BoxFit.cover),
                      ),
                      child: TextButton(
                        child: Text("CRIMINAL DEFENSE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                        ),

                        onPressed: () async{
                          setState(() {
                            _category  = 'Criminal Defense';
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: widget.uid)));
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: _pUid)));
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueAccent
                        ),
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(Colors.yellow[300].withOpacity(0.4), BlendMode.srcOver),
                            image: AssetImage('lib/src/assets/gavel.webp'), //Make relative path parameter
                            fit: BoxFit.cover),
                      ),
                      child: TextButton(
                        child: Text("IMMIGRATION",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                        ),

                        onPressed: () async{
                          print(widget.uid);
                          setState(() {
                            _category  = 'Immigration';
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: widget.uid)));
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: _pUid)));
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueAccent
                        ),
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(Colors.yellow[300].withOpacity(0.25), BlendMode.srcOver),
                            image: AssetImage('lib/src/assets/more books.jpeg'), //Make relative path parameter
                            fit: BoxFit.cover),
                      ),
                      child: TextButton(
                        child: Text("FAMILY",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                        ),

                        onPressed: () async{
                          setState(() {
                            _category  = 'Family';
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: widget.uid)));
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: _pUid)));
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueAccent
                        ),
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(Colors.yellow[300].withOpacity(0.25), BlendMode.srcOver),
                            image: AssetImage('lib/src/assets/law books.jpeg'), //Make relative path parameter
                            fit: BoxFit.cover),
                      ),
                      child: TextButton(
                        child: Text("PERSONAL INJURY",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                          ),
                        ),

                        onPressed: () async{
                          setState(() {
                            _category  = 'Personal Injury';
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: widget.uid)));
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: _pUid)));
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueAccent
                        ),
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(Colors.yellow[600].withOpacity(0.75), BlendMode.srcOver),
                            image: AssetImage('lib/src/assets/workers comp.jpg'), //Make relative path parameter
                            fit: BoxFit.cover),
                      ),
                      child: TextButton(
                        child: Text("WORKER'S COMP.",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                        ),

                        onPressed: () async{
                          setState(() {
                            _category  = "Worker's Compensation";
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: widget.uid)));
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LawyerList(category: _category, uid: _pUid)));
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

        ),
      
    );
  }
}