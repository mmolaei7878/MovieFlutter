import 'package:calculater_app/Bloc/MoviesBloc.dart';
import 'package:flutter/material.dart';
import '../Models/MovieResponse.dart';
import 'dart:math';
import 'DescriptionScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DisCoverScreen extends StatefulWidget {
  static const routeNamed = '/DisCoverScreen';
  @override
  _DisCoverScreenState createState() => _DisCoverScreenState();
}

class _DisCoverScreenState extends State<DisCoverScreen> {
  Random random = new Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF010101).withBlue(80),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Discover Movies'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: moviesBloc.subjectSlider.stream,
          builder: (context, AsyncSnapshot<MovieResponse> snapShot) {
            if (snapShot.hasData) {
              return GridView.builder(
                key: ObjectKey(snapShot.data.moviesList),
                itemCount: snapShot.data.moviesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
                itemBuilder: (ctx, i) => Container(
                  child: Column(
                    children: [
                      InkWell(
                        radius: 0,
                        onTap: () {
                          Navigator.pushNamed(
                              context, DescriptionsScreen.routeNamed,
                              arguments: snapShot.data.moviesList[i]);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            width: 150,
                            height: 150,
                            imageUrl: "https://image.tmdb.org/t/p/original/" +
                                snapShot.data.moviesList[i].poster_path,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      Text(
                        snapShot.data.moviesList[i].original_title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        (snapShot.data.moviesList[i].release_date).toString(),
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.refresh,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            moviesBloc.getDiscoverMovies(page: random.nextInt(100));
          }),
    );
  }
}
