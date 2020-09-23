import 'package:movie_app/modals/genre.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GenreListBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<Genres> _subject =
      BehaviorSubject<Genres>();
  getGenre() async {
    Genres response = await _movieRepository.getGenre();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Genres> get subject => _subject;
}

final genreBloc = GenreListBloc();
