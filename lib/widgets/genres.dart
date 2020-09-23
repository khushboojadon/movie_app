import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_genre_bloc.dart';
import 'package:movie_app/modals/genre.dart';
import 'package:movie_app/widgets/genre_list.dart';

class GenresScreen extends StatefulWidget {
  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genreBloc..getGenre();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Genres>(
      stream: genreBloc.subject.stream,
      builder: (context, AsyncSnapshot<Genres> snapshot) {
        if (snapshot.hasData) {
          return _buildMovieWidget(snapshot.data);
        } else {
          return _buildLoadWidget();
        }
      },
    );
  }

  Widget _buildMovieWidget(Genres data) {
    if (data.genres.length == 0) {
      return Container(child: Text('No Movies'));
    } else {
      return GenreList(genre: data.genres);
    }
  }

  Widget _buildLoadWidget() {
    return Center(child: CircularProgressIndicator());
  }
}
