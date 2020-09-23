import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
    Person({
        this.page,
        this.totalResults,
        this.totalPages,
        this.results,
    });

    int page;
    int totalResults;
    int totalPages;
    List<Result> results;

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "total_results": totalResults,
        "total_pages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.popularity,
        this.knownForDepartment,
        this.name,
        this.id,
        this.profilePath,
        this.adult,
        this.knownFor,
        this.gender,
    });

    double popularity;
    KnownForDepartment knownForDepartment;
    String name;
    int id;
    String profilePath;
    bool adult;
    List<KnownFor> knownFor;
    int gender;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        popularity: json["popularity"].toDouble(),
        knownForDepartment: knownForDepartmentValues.map[json["known_for_department"]],
        name: json["name"],
        id: json["id"],
        profilePath: json["profile_path"],
        adult: json["adult"],
        knownFor: List<KnownFor>.from(json["known_for"].map((x) => KnownFor.fromJson(x))),
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "popularity": popularity,
        "known_for_department": knownForDepartmentValues.reverse[knownForDepartment],
        "name": name,
        "id": id,
        "profile_path": profilePath,
        "adult": adult,
        "known_for": List<dynamic>.from(knownFor.map((x) => x.toJson())),
        "gender": gender,
    };
}

class KnownFor {
    KnownFor({
        this.posterPath,
        this.voteCount,
        this.video,
        this.mediaType,
        this.id,
        this.adult,
        this.backdropPath,
        this.originalLanguage,
        this.originalTitle,
        this.genreIds,
        this.title,
        this.voteAverage,
        this.overview,
        this.releaseDate,
        this.originalName,
        this.name,
        this.originCountry,
        this.firstAirDate,
    });

    String posterPath;
    int voteCount;
    bool video;
    MediaType mediaType;
    int id;
    bool adult;
    String backdropPath;
    OriginalLanguage originalLanguage;
    String originalTitle;
    List<int> genreIds;
    String title;
    double voteAverage;
    String overview;
    DateTime releaseDate;
    String originalName;
    String name;
    List<String> originCountry;
    DateTime firstAirDate;

    factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        posterPath: json["poster_path"],
        voteCount: json["vote_count"],
        video: json["video"] == null ? null : json["video"],
        mediaType: mediaTypeValues.map[json["media_type"]],
        id: json["id"],
        adult: json["adult"] == null ? null : json["adult"],
        backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"] == null ? null : json["original_title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        title: json["title"] == null ? null : json["title"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        originalName: json["original_name"] == null ? null : json["original_name"],
        name: json["name"] == null ? null : json["name"],
        originCountry: json["origin_country"] == null ? null : List<String>.from(json["origin_country"].map((x) => x)),
        firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    );

    Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "vote_count": voteCount,
        "video": video == null ? null : video,
        "media_type": mediaTypeValues.reverse[mediaType],
        "id": id,
        "adult": adult == null ? null : adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle == null ? null : originalTitle,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "title": title == null ? null : title,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": releaseDate == null ? null : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "original_name": originalName == null ? null : originalName,
        "name": name == null ? null : name,
        "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry.map((x) => x)),
        "first_air_date": firstAirDate == null ? null : "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    };
}

enum MediaType { MOVIE, TV }

final mediaTypeValues = EnumValues({
    "movie": MediaType.MOVIE,
    "tv": MediaType.TV
});

enum OriginalLanguage { EN, DA, TR }

final originalLanguageValues = EnumValues({
    "da": OriginalLanguage.DA,
    "en": OriginalLanguage.EN,
    "tr": OriginalLanguage.TR
});

enum KnownForDepartment { ACTING }

final knownForDepartmentValues = EnumValues({
    "Acting": KnownForDepartment.ACTING
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
