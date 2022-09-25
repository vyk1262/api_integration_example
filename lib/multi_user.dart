import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:api_integration_example/multi_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_ffi/web_ffi.dart';

class MultiUser extends StatefulWidget {
  @override
  State<MultiUser> createState() => _MultiUserState();
}

String stringResponse;
Map mapResponse;
List listResponse;

class _MultiUserState extends State<MultiUser> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Integration Example'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: listResponse == null
                    ? Container()
                    : Text(listResponse[0]['email'].toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
