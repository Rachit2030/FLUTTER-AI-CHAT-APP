// import './Data.dart';

// class Response {
//   int created = 0;
//   List<Data> data = List.empty();

//   Response({required this.created, required this.data});

//   factory Response.fromJSON(Map<String, dynamic> json) {
//     return Response(
//       created: json['created'],
//       data: json['data'],
//     );
//   }
// }

// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    required this.created,
    required this.data,
  });

  int created;
  List<Datum> data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        created: json["created"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.url,
  });

  String url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
