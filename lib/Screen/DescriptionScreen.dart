import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculater_app/Models/MoviesModel.dart';
import 'package:calculater_app/Providers/DBProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DescriptionsScreen extends StatefulWidget {
  static const routeNamed = '/DescriptionScreen';
  @override
  _DescriptionsScreenState createState() => _DescriptionsScreenState();
}

class _DescriptionsScreenState extends State<DescriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    final mqw = MediaQuery.of(context).size.width;
    final mqh = MediaQuery.of(context).size.height;

    final foundedMovie =
        ModalRoute.of(context).settings.arguments as MoviesModel;

    return Scaffold(
      body: Container(
        width: mqw,
        height: mqh,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/original/" +
                    foundedMovie.poster_path,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.1),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: mqh - 500,
                    ),
                    FittedBox(
                      child: Text(
                        foundedMovie.original_title,
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Wrap(
                      children: [
                        Card(
                          color: Colors.red[400],
                          elevation: 10.0,
                          shadowColor: Colors.white54,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(foundedMovie.original_language),
                          ),
                        ),
                        Card(
                          elevation: 10.0,
                          shadowColor: Colors.white54,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(foundedMovie.release_date),
                          ),
                        ),
                        Card(
                            elevation: 10.0,
                            shadowColor: Colors.white54,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: RatingBar.builder(
                                    onRatingUpdate: null,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    initialRating: foundedMovie.vote_count / 2,
                                    itemSize: 15.0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                  ),
                                ),
                                Text('${foundedMovie.popularity}')
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        foundedMovie.overview,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Consumer<DBProvider>(
                      builder: (ctx, provider, ch) => FlatButton.icon(
                        label: Text('Save'),
                        height: 47,
                        minWidth: 120,
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          provider.addtoSaves(foundedMovie);
                        },
                        icon: Icon(Icons.save_alt),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
