import 'package:flutter/material.dart';
import 'package:movie_app/bloc/person_bloc.dart';
import 'package:movie_app/modals/person.dart';
import 'package:movie_app/style/theme.dart' as Style;

class PersonList extends StatefulWidget {
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    perosnBloc..getPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            'TRENDING PERSONS IN THIS WEEK',
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(height: 5.0),
        StreamBuilder<Person>(
          stream: perosnBloc.subject.stream,
          builder: (context, AsyncSnapshot<Person> snapshot) {
            if (snapshot.hasData) {
              return _buildPersonWidget(snapshot.data);
            } else {
              return _buildLoadWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildPersonWidget(Person data) {
    if (data.results == 0) {
      return Container(child: Text('No Persons'));
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        height: 140.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.results.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(right: 8.0, top: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      data.results[index].profilePath == null
                          ? Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Style.Colors.secondColor,
                                  //  borderRadius:
                                  // BorderRadius.all(Radius.circular(2.0)
                                  // ),
                                  shape: BoxShape.circle),
                              child: Column(children: [
                                Icon(
                                  Icons.outlined_flag,
                                  color: Colors.white,
                                  size: 50.0,
                                )
                              ]),
                            )
                          : Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Style.Colors.secondColor,
                                  // borderRadius:
                                  //     BorderRadius.all(Radius.circular(2.0)),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w200' +
                                              data.results[index].profilePath),
                                      fit: BoxFit.cover)),
                            ),
                      SizedBox(height: 3.0),
                      Text(
                        data.results[index].name,
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        data.results[index].popularity.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )
                    ]),
              );
            }),
      );
    }
  }

  Widget _buildLoadWidget() {
    return Center(child: CircularProgressIndicator());
  }
}
