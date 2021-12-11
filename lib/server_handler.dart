// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import './model/user.dart';

// class ServerHandler {
//   final String _baseUrl =
//       "http://b8f9-159-223-46-111.ngrok.io/flutter_user/api";

//   //get users
//   Future<List<User>> getUsers() async {
//     try {
//       List<User> users = [];

//       http.Response response =
//           await http.get(Uri.parse('$_baseUrl/general/users'));

//       List usersList = (json.decode(response.body))['users'];

//       for (Map m in usersList) {
//         users.add(User.fromMap(m));
//       }

//       return users;
//     } catch (e) {
//       print("Server handler: error: " + e.toString());
//       rethrow;
//     }
//   }
// }
