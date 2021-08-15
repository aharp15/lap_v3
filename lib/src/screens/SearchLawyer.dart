import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';

class SearchLawyers extends StatefulWidget{

  final String category;
  SearchLawyers({Key key, this.category});

  _SearchLawyers createState() => _SearchLawyers();
}

class _SearchLawyers extends State<SearchLawyers>{

List<String> list;



Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SearchWidget(
                dataList: null,
                popupListItemBuilder: null,
                selectedItemBuilder: null,
                queryBuilder: null
            )
          ],
      ),
      ),
    );
  }
}