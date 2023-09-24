import 'dart:convert';

import 'package:api_integration_example/complete_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TypicodeApi extends StatefulWidget {
  const TypicodeApi({Key key}) : super(key: key);

  @override
  State<TypicodeApi> createState() => _TypicodeApiState();
}

class _TypicodeApiState extends State<TypicodeApi> {
  String stringResp;
  Map mapResp;

  Future apiCall() async {
    http.Response response;
    response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      setState(() {
        stringResp = response.body;
        listResponse = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("typicode api"),
      ),
      body: ListView.builder(
        itemCount: listResponse == null ? 0 : listResponse.length,
        itemBuilder: (context, index) {
          final userData = listResponse[index];
          return ListTile(
            title: Text(userData['name'] ?? "N/A"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData['email'] ?? "N/A"),
                Text(userData['address']['city']),
                Text(userData['address']['geo']['lat'])
              ],
            ),
          );
        },
      ),
    );
  }
}
