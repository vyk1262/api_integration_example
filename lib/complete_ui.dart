import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:api_integration_example/multi_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_ffi/web_ffi.dart';

class CompleteUi extends StatefulWidget {
  @override
  State<CompleteUi> createState() => _CompleteUiState();
}

String stringResponse;
Map mapResponse;
List listResponse;

class _CompleteUiState extends State<CompleteUi> {
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(listResponse[index]['avatar']),
                ),
                Text(listResponse[index]['id'].toString()),
                Text(listResponse[index]['email'].toString()),
                Text(listResponse[index]['first_name'].toString()),
                Text(listResponse[index]['last_name'].toString()),
                Text(listResponse[index]['id'].toString()),
                Text(mapResponse['page'].toString()),
                Text(mapResponse['total'].toString()),
                Text(mapResponse['per_page'].toString()),
              ],
            ),
          );
        },
        itemCount: listResponse ==null ? 0: listResponse.length,
      ),
    );
  }
}
