import 'package:dio/dio.dart';
import 'package:netflex/models/person.dart';

import '../models/movie.dart';
import 'api.dart';

class ApiService {
  final API api = API();
  final Dio _dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    //On construit l'url
    String url = "${api.baseURL}${path}";
    //On construit l'url
    Map<String, dynamic> query = {'api_key': api.apiKey, 'language': "fr-FR"};
    if (params != null) {
      query.addAll(params);
    }
    final response = await _dio.get(url, queryParameters: query);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response =
        await getData("/movie/popular", params: {'page': pageNumber});
    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (dynamic json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response =
        await getData("/movie/now_playing", params: {'page': pageNumber});
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic json) {
        return Movie.fromJson(json);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response =
        await getData("/movie/upcoming", params: {'page': pageNumber});
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic json) {
        return Movie.fromJson(json);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimationMovies({required int pageNumber}) async {
    Response response = await getData("/discover/movie",
        params: {'page': pageNumber, 'without_genres': '16'});
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic json) {
        return Movie.fromJson(json);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    Response response = await getData(
      "/movie/${movie.id}",
    );
    if (response.statusCode == 200) {
      Map data = response.data;
      var genres = data["genres"] as List;
      List<String> genreList =
          genres.map((genre) => genre['name'] as String).toList();
      Movie newMovie = movie.copyWith(
          genres: genreList,
          releaseDate: data["release_date"],
          vote: data['vote_average']);
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieVideos({required Movie movie}) async {
    Response response = await getData(
      "/movie/${movie.id}/videos",
    );
    if (response.statusCode == 200) {
      Map data = response.data;

      List<String> videoKeys = data["results"]
          .map<String>((dynamic videoJson) => videoJson['key'] as String)
          .toList();
      Movie newMovie = movie.copyWith(videos: videoKeys);
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieCast({required Movie movie}) async {
    Response response = await getData(
      "/movie/${movie.id}/credits",
    );
    if (response.statusCode == 200) {
      Map data = response.data;

      List<Person> casting = data["cast"]
          .map<Person>((dynamic personJson) => Person.fromJson(personJson))
          .toList();
      Movie newMovie = movie.copyWith(casting: casting);
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieImage({required Movie movie}) async {
    Response response = await getData("/movie/${movie.id}/images",
        params: {'include_image_language': "null"});
    if (response.statusCode == 200) {
      Map data = response.data;

      List<String> images = data["backdrops"]
          .map<String>((dynamic imageJson) =>
              "${api.baseImageURL}${imageJson['file_path']}")
          .toList();
      Movie newMovie = movie.copyWith(images: images);
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovie({required Movie movie}) async {
    Response response = await getData("/movie/${movie.id}", params: {
      'include_image_language': "null",
      'append_to_response': "videos,images,credits"
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      //On recupere les genre
      var genres = data["genres"] as List;
      List<String> genreList =
          genres.map((genre) => genre['name'] as String).toList();
      //On recupere les videos
      List<String> videoKeys = data["videos"]["results"]
          .map<String>((dynamic videoJson) => videoJson['key'] as String)
          .toList();
      //On recupere les Photos
      List<String> images = data["images"]["backdrops"]
          .map<String>((dynamic imageJson) =>
              "${api.baseImageURL}${imageJson['file_path']}")
          .toList();
      //On recupere le Casting
      List<Person> casting = data["credits"]["cast"]
          .map<Person>((dynamic personJson) => Person.fromJson(personJson))
          .toList();
      Movie newMovie = movie.copyWith(
          genres: genreList,
          releaseDate: data["release_date"],
          vote: data['vote_average'],
          videos: videoKeys,
          images: images,
          casting: casting);
      return newMovie;
    } else {
      throw response;
    }
  }
}
