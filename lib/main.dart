import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final textInputController = TextEditingController();

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
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
