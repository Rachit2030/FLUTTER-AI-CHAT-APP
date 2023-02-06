import 'package:ai_chat_app/network/ApiData.dart';
import 'package:ai_chat_app/widgets/ApiImage.dart';
import 'package:ai_chat_app/widgets/historyList.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Response.dart';
import './network/apikey.dart';
import 'models/DBData.dart';
import 'network/databaseHelper.dart';

final dbHelper = DatabaseHelper();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final textInputController = TextEditingController();
  Response dataFromApi = Response(created: 40411, data: []);
  var dataImageUrl = "";
  var dataImagePrompt = "";
  var isLoading = true;
  var isShowingHistory = true;
  List<Map<String, dynamic>> data = [];

  void createImage(String prompt) async {
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
        dataImageUrl = dataFromApi.data.first.url;
      });
    }
    // print(temp)
    print(dataFromApi.created);
    print(dataFromApi.data.first.url);

    var data = DBData(
        created: dataFromApi.created!.toInt(),
        prompt: prompt,
        url: dataFromApi.data.first.url);
    // return dataFromApi;

    insert();
    query();
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  Future<void> getData() async {
    final allRows = await dbHelper.queryAllRows();
    // debugPrint('query all rows:');
    // for (final row in allRows) {
    //   debugPrint(row.toString());
    // }
    setState(() {
      data = allRows;
    });
  }

  void insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnCreated: dataFromApi.created,
      DatabaseHelper.columnPrompt: dataImagePrompt,
      DatabaseHelper.columnUrl: dataFromApi.data.first.url
    };
    final id = await dbHelper.insert(row);
    debugPrint('inserted row id: $id');
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
          title: isShowingHistory ? Text("AI CHAT APP") : Text("HISTORY"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  isShowingHistory = !isShowingHistory;
                  getData();
                });
              },
              icon: isShowingHistory ? Icon(Icons.history) : Icon(Icons.home),
            ),
          ],
        ),
        body: (isShowingHistory)
            ? Column(
                // mainAxisAlignment: MainAxisAlignment.,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (dataImageUrl != "") {
                        return ImageFromApi(
                            dataPrompt: dataImagePrompt,
                            dataImage: dataImageUrl);
                      } else {
                        if (isLoading) {
                          return Container();
                        } else
                          return CircularProgressIndicator();
                      }
                      // if (snapshot.hasData) {
                      //   return Container(
                      //     child: Image.network("${dataFromApi.data!.first.url}"),
                      //   );
                      //   // Text("${dataFromApi.data}");
                      // } else {
                      //   return Text(dataFromApi.created.toString());
                      // }
                    },
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Spacer(),
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
                          onPressed: () {
                            setState(() {
                              dataImageUrl = "";
                              dataImagePrompt = textInputController.text;
                              isLoading = false;
                            });
                            createImage(textInputController.text);
                            textInputController.text = "";
                          },
                          child: const Text("Search"),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              )
            : HistoryList(data: data),
      ),
    );
  }
}
