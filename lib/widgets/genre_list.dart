import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movies_bygenre-bloc.dart';
import 'package:movie_app/modals/genre.dart';
import 'package:movie_app/style/theme.dart' as Style;
import 'package:movie_app/widgets/genre_movie.dart';

class GenreList extends StatefulWidget {
  final List<Genre> genre;

  const GenreList({Key key, this.genre}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState(genre);
}

class _GenreListState extends State<GenreList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genre;
  _GenreListState(this.genre);
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: genre.length);
 
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    _tabController.addListener(() {
      if(_tabController.indexIsChanging)
      {
        moviegenreBloc..dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: DefaultTabController(
          length: genre.length,
          child: Scaffold(
              backgroundColor: Style.Colors.mainColor,
              appBar: PreferredSize(
                child: AppBar(
                  backgroundColor: Style.Colors.mainColor,
                  bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Style.Colors.secondColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3.0,
                      unselectedLabelColor: Style.Colors.titleColor,
                      labelColor: Colors.white,
                      isScrollable: true,
                      tabs: genre.map((Genre genre) {
                        return Container(
                          padding: EdgeInsets.only(
                            bottom: 15.0,
                            top: 10.0,
                          ),
                          child: Text(genre.name.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold)),
                        );
                      }).toList()),
                ),
                preferredSize: Size.fromHeight(50.0),
              ),
              body: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: genre.map(
                  (Genre genre) {
                    return GenreMovie(genreId: genre.id);
                  },
                ).toList(),
              ))),
    );
  }
}
