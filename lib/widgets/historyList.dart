import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transparent_image/transparent_image.dart';

class HistoryList extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  HistoryList({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: [
              Text("${data[index]['prompt']}"),
              FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                image: data[index]['url'],
                placeholder: kTransparentImage,
              ),
            ],
          ));
        },
        itemCount: data.length,
      ),
    );
  }
}
