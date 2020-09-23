import 'package:dio/dio.dart';
import 'package:movie_app/modals/genre.dart';
import 'package:movie_app/modals/movie.dart';
import 'package:movie_app/modals/person.dart';

class MovieRepository {
  final String apiKey = "94c2be33fbae704e9353ee045fe7c501";
  static String mainurl = 'https://api.themoviedb.org/3';
  final Dio dio = Dio();
  var getPopularUrl = '$mainurl/movie/top_rated';
  var getMoviesUrl = '$mainurl/discover/movie';
  var getPlaying = '$mainurl/movie/now_playing';
  var getGenersUrl = '$mainurl/genre/movie/list';
  var getPersonUrl = '$mainurl/person/popular';

//https://api.themoviedb.org/3/movie/top_rated?api_key=94c2be33fbae704e9353ee045fe7c501&language=en-US

  Future<Movies> getMovies() async {
    try {
      final response =
          await dio.get('$getPopularUrl?api_key=$apiKey&language=en-US');

      return moviesFromJson(response.data);
    } catch (error) {
      print('Error $error');
    }
    return null;
  }

  Future<Genres> getGenre() async {
    try {
      final response =
          await dio.get('$getGenersUrl?api_key=$apiKey&language=en-US');
      return genresFromJson(response.data);
    } catch (error, stackTrack) {
      print('Error $error StackTrack $stackTrack');
    }
  }

  Future<Person> getPersons() async {
    try {
      Response response =
          await dio.get('$getPersonUrl?api_key=$apiKey&language=en-US&page=1');
      return Person.fromJson(response.data);
    } catch (error, stackTrack) {
      print('Error $error StackTrack $stackTrack');
    }
  }

  Future<Movies> getMoviesByGenre() async {
    try {
      Response response = await dio.get(
          '$getMoviesUrl?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1');
      return Movies.fromJson(response.data);
    } catch (error, stackTrack) {
      print('Error $error StackTrack $stackTrack');
    }
    return null;
  }
}
