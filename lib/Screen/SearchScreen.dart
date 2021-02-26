import 'package:calculater_app/Screen/DescriptionScreen.dart';
import 'package:flutter/material.dart';
import '../Bloc/GenerBloc.dart';
import '../Models/GenerResponse.dart';
import '../Models/MovieResponse.dart';
import '../Bloc/MoviesBloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  static const routeNamed = '/SearchScreen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    generBloc.getGeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: StreamBuilder(
                stream: generBloc.generSubject.stream,
                builder: (ctx, AsyncSnapshot<GenerResponse> snapShot) {
                  if (snapShot.hasData) {
                    return Wrap(
                      children: snapShot.data.genersList
                          .map((e) => FlatButton(
                              onPressed: () {
                                showSearch(
                                  context: context,
                                  delegate: Search(),
                                  query: e.name,
                                );
                              },
                              child: Text(e.name)))
                          .toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              child: IconButton(
                splashColor: Colors.black,
                iconSize: 120,
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('^'),
            Text('TAP TO SEARCH')
          ],
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  final moviesBloc = MoviesBloc();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.navigate_before),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Color(0xFF010101).withBlue(40),
      child: StreamBuilder(
        stream: moviesBloc.searchSubject.stream,
        builder: (ctx, AsyncSnapshot<MovieResponse> snapShot) {
          if (snapShot.hasData) {
            return Container(
              child: Column(
                children: [
                  Container(
                    height: 65,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Chip(
                            label: Text('Current Page ' +
                                moviesBloc.repository.searchModel.page
                                    .toString()),
                          ),
                          Chip(
                            label: Text('Total Page ' +
                                moviesBloc.repository.searchModel.total_pages
                                    .toString()),
                          ),
                          Chip(
                            label: Text('total Item ' +
                                moviesBloc.repository.searchModel.total_result
                                    .toString()),
                          )
                        ]),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        ListView.builder(
                            itemCount: snapShot.data.moviesList.take(20).length,
                            itemBuilder: (ctx, i) {
                              if (snapShot.data.moviesList.isNotEmpty) {
                                return InkWell(
                                  radius: 0,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DescriptionsScreen.routeNamed,
                                        arguments: snapShot.data.moviesList[i]);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    width: MediaQuery.of(context).size.width,
                                    height: 170,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 110,
                                          height: 160,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: snapShot.data.moviesList[i]
                                                        .poster_path ==
                                                    null
                                                ? Image.asset(
                                                    'lib/noimage.gif',
                                                    fit: BoxFit.cover,
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        "https://image.tmdb.org/t/p/original/" +
                                                            snapShot
                                                                .data
                                                                .moviesList[i]
                                                                .poster_path,
                                                    fit: BoxFit.cover,
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        Center(
                                                            child: CircularProgressIndicator(
                                                                value: downloadProgress
                                                                    .progress)),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                snapShot
                                                    .data.moviesList[i].title,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              RatingBar.builder(
                                                onRatingUpdate: null,
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                initialRating: snapShot
                                                        .data
                                                        .moviesList[i]
                                                        .vote_count /
                                                    2,
                                                itemSize: 15.0,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                              ),
                                              snapShot.data.moviesList[i]
                                                          .vote_count ==
                                                      null
                                                  ? Text(
                                                      'No Vote Found',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  : Text(
                                                      '${snapShot.data.moviesList[i].popularity}',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                              snapShot.data.moviesList[i]
                                                          .release_date ==
                                                      null
                                                  ? Text(
                                                      'No Release Date Found',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  : Text(
                                                      snapShot
                                                          .data
                                                          .moviesList[i]
                                                          .release_date,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        Positioned(
                          bottom: 15,
                          left: 15,
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {
                              moviesBloc.getMoviesSearched(query,
                                  moviesBloc.repository.searchModel.page + 1);
                            },
                            child: Icon(Icons.next_plan, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xFF010101).withBlue(50),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'PLEASE PRESS SEARCH',
            style: TextStyle(color: Colors.white),
          ),
          IconButton(
              color: Colors.white,
              iconSize: 150,
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                moviesBloc.getMoviesSearched(query, 1);
                transitionAnimation;
                showResults(context);
              })
        ],
      ),
    );
  }
}
