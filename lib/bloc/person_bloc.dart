import 'package:movie_app/modals/person.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class PersonBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<Person> _subject =
      BehaviorSubject<Person>();
  getPerson() async {
    Person response = await _movieRepository.getPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Person> get subject => _subject;
}

final perosnBloc = PersonBloc();
