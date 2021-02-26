import 'package:calculater_app/Models/MovieResponse.dart';
import 'package:calculater_app/Screen/DescriptionScreen.dart';
import 'package:flutter/material.dart';
import '../Bloc/MoviesBloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'DisCoverScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ManageScreen extends StatefulWidget {
  static const routeNamed = 'ManageScreen';

  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  @override
  void initState() {
    super.initState();

    moviesBloc.getBlocMovies();
    moviesBloc.getDiscoverMovies();
    moviesBloc.getGridViewMovies(urlSegment: 'popular');
  }

  var isLoding = false;
  @override
  Widget build(BuildContext context) {
    final mqw = MediaQuery.of(context).size.width;
    final mqh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF010101).withBlue(30),
      body: StreamBuilder(
          stream: moviesBloc.subject.stream,
          builder: (ctx, AsyncSnapshot<MovieResponse> snapShot) {
            if (snapShot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, bottom: 10),
                      width: mqw,
                      child: Text(
                        'NOW PLAYING',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayCurve: Curves.linear,
                          height: mqh - 420,
                          scrollDirection: Axis.horizontal),
                      items: [
                        ...snapShot.data.moviesList
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DescriptionsScreen.routeNamed,
                                      arguments: e);
                                },
                                radius: 0,
                                child: Container(
                                  width: 300,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original/" +
                                                  e.poster_path,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList()
                      ],
                    ),
                    Container(
                      width: mqw,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20, top: 20),
                            child: Text(
                              'Discover Movies',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, DisCoverScreen.routeNamed);
                            },
                            child: Text(
                              'View All',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 160,
                      child: StreamBuilder(
                          stream: moviesBloc.subjectSlider.stream,
                          builder:
                              (ctx, AsyncSnapshot<MovieResponse> snapShot) {
                            if (snapShot.hasData) {
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (ctx, i) => SizedBox(
                                  width: 15,
                                ),
                                itemCount:
                                    snapShot.data.moviesList.take(10).length,
                                itemBuilder: (ctx, i) => Container(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original/" +
                                                  snapShot.data.moviesList[i]
                                                      .poster_path,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: mqw,
                        height: 60,
                        child: DefaultTabController(
                          initialIndex: 0,
                          length: 3,
                          child: TabBar(
                            onTap: (index) async {
                              switch (index) {
                                case 0:
                                  setState(() {
                                    isLoding = true;
                                  });
                                  await moviesBloc.getGridViewMovies(
                                      urlSegment: 'popular');
                                  setState(() {
                                    isLoding = false;
                                  });

                                  break;
                                case 1:
                                  setState(() {
                                    isLoding = true;
                                  });
                                  await moviesBloc.getGridViewMovies(
                                      urlSegment: 'top_rated');
                                  setState(() {
                                    isLoding = false;
                                  });

                                  break;
                                case 2:
                                  setState(() {
                                    isLoding = true;
                                  });
                                  await moviesBloc.getGridViewMovies(
                                      urlSegment: 'upcoming');
                                  setState(() {
                                    isLoding = false;
                                  });

                                  break;

                                default:
                                  moviesBloc.getGridViewMovies(
                                      urlSegment: 'upcoming');
                              }
                            },
                            tabs: [
                              Tab(
                                text: 'Popular',
                                icon: Icon(Icons.favorite),
                              ),
                              Tab(
                                text: 'Top Rated',
                                icon: Icon(Icons.star),
                              ),
                              Tab(
                                text: 'Up Coming',
                                icon: Icon(Icons.update),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: mqw,
                      height: 450,
                      child: StreamBuilder(
                        stream: moviesBloc.gridViewMovies.stream,
                        builder: (ctx, AsyncSnapshot<MovieResponse> snapShot) {
                          if (!snapShot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapShot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return isLoding
                              ? Center(
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                )
                              : GridView.builder(
                                  key: ObjectKey(snapShot.data.moviesList),
                                  itemCount: snapShot.data.moviesList.length,
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemBuilder: (ctx, i) => InkWell(
                                    radius: 0,
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          DescriptionsScreen.routeNamed,
                                          arguments:
                                              snapShot.data.moviesList[i]);
                                    },
                                    child: GridTile(
                                      footer: GridTileBar(
                                        backgroundColor: Colors.black54,
                                        title: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            child: Text(snapShot
                                                .data.moviesList[i].title)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original/" +
                                                  snapShot.data.moviesList[i]
                                                      .poster_path,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
