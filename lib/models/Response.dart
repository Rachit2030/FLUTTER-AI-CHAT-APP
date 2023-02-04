import './Data.dart';

class Response {
  int created = 0;
  List<Data> data = List.empty();

  Response({required this.created, required this.data});

  factory Response.fromJSON(Map<String, dynamic> json) {
    return Response(
      created: json['created'],
      data: json['data'],
    );
  }
}
