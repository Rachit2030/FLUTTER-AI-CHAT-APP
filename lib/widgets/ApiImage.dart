import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageFromApi extends StatelessWidget {
  final String dataImage;
  final String dataPrompt;
  ImageFromApi({required this.dataPrompt, required this.dataImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          dataPrompt.toUpperCase(),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          child: Card(
            elevation: 5,
            child: FadeInImage.memoryNetwork(
              fit: BoxFit.cover,
              image: dataImage,
              placeholder: kTransparentImage,
            ),
          ),
        ),
      ],
    );
  }
}
