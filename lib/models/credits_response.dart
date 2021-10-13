// To parse this JSON data, do
//
//     final creditResponse = creditResponseFromMap(jsonString);

import 'dart:convert';

class CreditResponse {
    CreditResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    int id;
    List<Cast> cast;
    List<Cast> crew;

    factory CreditResponse.fromJson(String str) => CreditResponse.fromMap(json.decode(str));

    factory CreditResponse.fromMap(Map<String, dynamic> json) => CreditResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
    );

}

class Cast {
    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String? department;
    String? job;

    factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

    factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        castId: json["cast_id"] == null ? null : json["cast_id"],
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"],
        order: json["order"] == null ? null : json["order"],
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
    );

    get fullprofilepath{
      if(this.profilePath != null){
        return "https://image.tmdb.org/t/p/w500${this.profilePath}";
      }else{
        return "data:image/png;base64,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";
      }
    }
}



