import 'package:movie_app/modals/movie.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class MoviesListBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<Movies> _subject = BehaviorSubject<Movies>();
  getMovies() async {
    Movies response = await _movieRepository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Movies> get subject => _subject;
}

final moviesBloc = MoviesListBloc();
