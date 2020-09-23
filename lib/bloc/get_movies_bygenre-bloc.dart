import 'package:movie_app/modals/movie.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class MovieListByGenreBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<Movies> _subject = BehaviorSubject<Movies>();
  getGenre(int id) async {
    Movies response = await _movieRepository.getMoviesByGenre();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Movies> get subject => _subject;
}

final moviegenreBloc = MovieListByGenreBloc();
