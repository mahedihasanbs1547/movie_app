/*
import 'package:http/http.dart' as http;

import 'package:movie_app/data/model/movie_list_response_model.dart';

const String movieUrl =
    "https://yts.mx/api/v2/list_movies.json?sort_by=popular&order_by=desc";

class GetAllMovie {
  Future<MovieListResponseModel> getAllMovie() async {
    print("############## Before api call ##############");

    final url = Uri.parse(movieUrl);
    final response = await http.get(url);

    print("############## after api call ################");
    print(response.statusCode);

    return movieModelFromJson(response.body);


  }
}
*/