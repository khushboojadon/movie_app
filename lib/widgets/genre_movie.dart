import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movies_bygenre-bloc.dart';
import 'package:movie_app/modals/movie.dart';
import 'package:movie_app/style/theme.dart' as Style;

class GenreMovie extends StatefulWidget {
  final int genreId;

  const GenreMovie({Key key, this.genreId}) : super(key: key);
  @override
  _GenreMovieState createState() => _GenreMovieState(genreId);
}

class _GenreMovieState extends State<GenreMovie> {
  final int genreId;

  _GenreMovieState(this.genreId);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviegenreBloc.getGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Movies>(
      stream: moviegenreBloc.subject.stream,
      builder: (context, AsyncSnapshot<Movies> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.error != null) {
            return _buildErrorWidget(snapshot.error);
          }
          return _buildMovieWidget(snapshot.data);
        } else {
          return _buildLoadWidget();
        }
      },
    );
  }

  Widget _buildLoadWidget() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildMovieWidget(Movies data) {
    if (data.results.length == 0) {
      return Center(child: Text('No Movies'));
    } else {
      return Container(
        height: 270,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.results.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                child: Column(children: [
                  data.results[index].posterPath == null
                      ? Container(
                          width: 120,
                          height: 180,
                          decoration: BoxDecoration(
                              color: Style.Colors.secondColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle),
                          child: Column(children: [
                            Icon(
                              Icons.outlined_flag,
                              color: Colors.white,
                              size: 50.0,
                            )
                          ]),
                        )
                      : Container(
                          width: 120,
                          height: 180,
                          decoration: BoxDecoration(
                              color: Style.Colors.secondColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w200' +
                                          data.results[index].posterPath),
                                  fit: BoxFit.cover)),
                        ),
                  SizedBox(height: 10.0),
                  Container(
                      child: Text(data.results[index].title,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0))),
                  SizedBox(height: 5.0),
                  Text(data.results[index].voteCount.toString(),
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0))
                ]),
              );
            }),
      );
    }
  }

  Widget _buildErrorWidget(String error) {
    return Center(child: Text('Error $error'));
  }
}
