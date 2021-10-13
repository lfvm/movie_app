// To parse this JSON data, do
//
//     final searchedResponse = searchedResponseFromMap(jsonString);

import 'dart:convert';

import 'package:movie_app/models/movie.dart';

class SearchedResponse {
    SearchedResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SearchedResponse.fromJson(String str) => SearchedResponse.fromMap(json.decode(str));

    factory SearchedResponse.fromMap(Map<String, dynamic> json) => SearchedResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}
