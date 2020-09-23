// import 'package:movie_app/modals/moview_response.dart';
// import 'package:movie_app/repository/repository.dart';
// import 'package:rxdart/subjects.dart';

// class NowPlayingBloc {
//   final MovieRepository _movieRepository = MovieRepository();
//   final BehaviorSubject<MovieResponse> _subject =
//       BehaviorSubject<MovieResponse>();
//   getPlaying() async {
//     MovieResponse response = await _movieRepository.getPlaying();
//     _subject.sink.add(response);
//   }

//   dispose() {
//     _subject.close();
//   }

//   BehaviorSubject<MovieResponse> get subject => _subject;
// }

// final genreBloc = NowPlayingBloc();
