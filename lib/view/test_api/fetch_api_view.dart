import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobitech/apis/api_endpoints.dart';
import 'dart:io';
import 'package:mobitech/business_logic/model/account_m.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';

class dataViewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _dataViewerState();
}

class _dataViewerState extends State<dataViewer> {
  var _searchControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data viewer'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
              child: TextField(
                controller: _searchControlller,
                decoration: InputDecoration(
                  hintText: 'search here',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Container(
              child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(

                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
