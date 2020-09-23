import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movies_bloc.dart';
import 'package:movie_app/modals/movie.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:movie_app/style/theme.dart' as Style;

class MovieScreen extends StatefulWidget {
  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<MovieScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Movies>(
      stream: moviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<Movies> snapshot) {
        if (snapshot.hasData) {
          return _buildMovieWidget(snapshot.data);
        } else {
          return _buildLoadWidget();
        }
      },
    );
  }

  Widget _buildMovieWidget(Movies data) {
    if (data.results.length == 0) {
      return Container(child: Text('No Movies'));
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: PageIndicatorContainer(
            align: IndicatorAlign.bottom,
            indicatorSpace: 8.0,
            padding: EdgeInsets.all(5.0),
            shape: IndicatorShape.circle(size: 8.0),
            indicatorColor: Style.Colors.titleColor,
            indicatorSelectorColor: Style.Colors.secondColor,
            child: PageView.builder(
                itemCount: data.results.take(5).length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/original' +
                                          data.results[index].posterPath),
                                  fit: BoxFit.cover))),
                      Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Style.Colors.mainColor.withOpacity(1.0),
                                    Style.Colors.mainColor.withOpacity(0.0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [0.0, 0.9]))),
                      Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.yellow,
                            size: 40.0,
                          )),
                      Positioned(
                          bottom: 30.0,
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            width: 250.0,
                            child: Column(children: [
                              Text(data.results[index].title,
                                  style: TextStyle(
                                      height: 1.2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0))
                            ]),
                          ))
                    ],
                  );
                }),
            length: data.results.take(5).length,
          ));
    }
  }

  Widget _buildLoadWidget() {
    return Center(child: CircularProgressIndicator());
  }
}
