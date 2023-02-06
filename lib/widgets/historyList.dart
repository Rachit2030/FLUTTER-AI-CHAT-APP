import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transparent_image/transparent_image.dart';

class HistoryList extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  HistoryList({required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  data[index]['prompt'].toString().toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 150,
                  child: FadeInImage.memoryNetwork(
                    image: data[index]['url'],
                    fit: BoxFit.fitWidth,
                    placeholder: kTransparentImage,
                    imageErrorBuilder: (context, exception, stackTrace) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.error,
                            size: 30,
                            color: Colors.red,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Error Loading Image",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ]),
        );
      },
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );

    //   child: ListView.builder(
    //     itemBuilder: (context, index) {
    //       return Card(
    //           child: Column(
    //         children: [
    //           Text("${data[index]['prompt']}"),
    //           FadeInImage.memoryNetwork(
    //             fit: BoxFit.cover,
    //             image: data[index]['url'],
    //             placeholder: kTransparentImage,
    //           ),
    //         ],
    //       ));
    //     },
    //     itemCount: data.length,
    //   ),
    // );
  }
}
