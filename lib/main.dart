import 'package:ai_chat_app/network/ApiData.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:ai_chat_app/models/UserRequest.dart';
import 'package:http/http.dart' as http;

import '../models/Response.dart';
import './network/apikey.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final textInputController = TextEditingController();
  Response dataFromApi = Response(created: 404, data: []);

  Future<Response> createImage(String prompt) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/images/generations'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": key,
      },
      body: jsonEncode({"prompt": prompt, "n": 1, "size": "256x256"}),
    );
    final temp = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // for (Map<String, dynamic> index in temp) {
      //   dataFromApi = Response.fromJson(index);
      // }
      setState(() {
        dataFromApi = Response.fromJson(temp);
      });
    }
    return dataFromApi;
    print(temp);
  }

  // FutureBuilder<Response> showImage() {
  //   return FutureBuilder<Response>(builder: (context, snapshot) {
  //     if (snapshot.hasData) {
  //       return Text(snapshot.data!.created as String);
  //     }
  //     return const CircularProgressIndicator();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("AI CHAT APP"),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(dataFromApi.created as String);
                }
                return Text("Error");
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    width: 300,
                    child: TextField(
                      controller: textInputController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "Enter the word to search",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => createImage(textInputController.text),
                    child: const Text("Search"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
