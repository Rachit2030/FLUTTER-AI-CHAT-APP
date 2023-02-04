// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../models/Response.dart';

// void createImage() async {
//   final response = await http.post(
//     Uri.parse('https://api.openai.com/v1/images/generations'),
//     headers: <String, String>{
//       "Content-Type": "application/json",
//       "Authorization":
//           "Bearer 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"
//     },
//     body: {"prompt": " A white tiger in jungle", "n": 1, "size": "256x256"},
//   );
//   print(response);
// }
// class API{

//   static void createImage(String prompt) async {
//     final response = await http.post(
//       Uri.parse('https://api.openai.com/v1/images/generations'),
//       headers: <String, String>{
//         "Content-Type": "application/json",
//         "Authorization":
//             "Bearer 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"
//       },
//       body: jsonEncode({"prompt": prompt, "n": 1, "size": "256x256"}),
//     );
//     final temp = jsonDecode(response.body);
//     print(temp);
//   }
// }

  