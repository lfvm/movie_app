import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';


class MovieProvier extends ChangeNotifier {

  final _BaseUrl = "api.themoviedb.org";
  final _apiKey = "1b86582b080dbcf568e46b7464ab5c3d";
  final _language = "es-ES";

  List<Movie> NowPlayingMovies = [];
  List<Movie> PopularMovies = [];

  Map<int,List<Cast>> movieCast = {};


  int popularPage = 0;

  MovieProvier(){
    print("Provider initialized");
    this.getCinemaMovies();
    this.getPopularMovies();
  }

  getCinemaMovies() async {

    final response = await _GetJsonData("3/movie/now_playing");


    final NowPlayingResponse = NowPlaying.fromJson(response);
    this.NowPlayingMovies = NowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {

    popularPage ++;
    final response = await _GetJsonData("3/movie/popular",popularPage);

    final popularResponse = Popular.fromJson(response);
    this.PopularMovies = popularResponse.movies;
    notifyListeners();

  }


  Future<List<Cast>> getCastMembers(int id ) async{

    final response = await _GetJsonData("3/movie/$id/credits");

    final data  = CreditResponse.fromJson(response);

    movieCast[id] = data.cast;

    return data.cast;
  }


  Future<List<Movie>> searchMovie(String query) async {
    
    var url = Uri.https(this._BaseUrl, '3/search/movie',{
      "api_key" : this._apiKey, 
      "language": this._language,
      "query" : query 
    });

    final response   = await http.get(url);

    final searchresult = SearchedResponse.fromJson(response.body);

    return searchresult.results;
  }

  Future<String> _GetJsonData(String endpoint, [int page = 1] )async {

    var url = Uri.https(this._BaseUrl, endpoint,{
    "api_key" : this._apiKey, 
    "language": this._language,
    "page" : "$page"
    });

    final response = await http.get(url);

    return response.body;
  }


}