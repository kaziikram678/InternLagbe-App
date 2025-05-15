import 'dart:convert';

import 'package:chakrilinkbd/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {


  Future<List<dynamic>> joblist () async{

    var response = await http.get(Uri.parse(AppUrl.baseUrl),headers: AppUrl.headers);

    if(response.statusCode==200)
    {
      var data = jsonDecode(response.body);

      return data;
    }
    else {
      throw Exception("Error");
    }
  }
}