import 'dart:convert';

import 'package:http/http.dart' as http;
import 'movie_model.dart';


class ApiCall{

  String apiKey = "69e4ff4f5af7d9989dcb4f087688425c";
  static const poster_baseuri = "https://image.tmdb.org/t/p/original";
  Future<MovieModel> getMovieData({required String url}) async{
    final response = await http.get(Uri.parse("$url$apiKey"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      return MovieModel.fromJson(data);
    }else{
      throw Exception("error");
    }
  }
}