import 'dart:convert';

import 'package:http/http.dart' as http;
class ContactManager{
  static Future<void> postMessage ({
  required String name,
    required String email,
    required String phone,
    required String message,
    }) async{
      Uri uri=Uri.parse("http://admin.ecohotindustries.com/api/contact/save");
      final response=await http.post(
          uri,
          headers: {
            "Content-Type":"application/json"
          },
        body: json.encode(
          {
            "name":name,
            "email":email,
            "number":phone,
            "message":message,
          }
        )
      );
      if(response.statusCode>299) throw "Error";

    }
}