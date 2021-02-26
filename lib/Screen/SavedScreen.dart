import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Providers/DBProvider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'DescriptionScreen.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF010101).withBlue(30),
      body: Consumer<DBProvider>(
        builder: (ctx, provider, ch) => FutureBuilder(
          future: provider.fetchDataBase(),
          builder: (ctx, snapShot) {
            return ListView.builder(
              itemCount: provider.saveMovies.length,
              itemBuilder: (ctx, i) => InkWell(
                radius: 0,
                onTap: () {
                  Navigator.pushNamed(context, DescriptionsScreen.routeNamed,
                      arguments: provider.saveMovies[i]);
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
                          borderRadius: BorderRadius.circular(15),
                          child: provider.saveMovies[i].poster_path == null
                              ? Image.asset(
                                  'lib/noimage.gif',
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/original/" +
                                          provider.saveMovies[i].poster_path,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Center(
                                          child: CircularProgressIndicator(
                                              value:
                                                  downloadProgress.progress)),
                                  errorWidget: (context, url, error) =>
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              provider.saveMovies[i].title,
                              style: TextStyle(color: Colors.white),
                            ),
                            RatingBar.builder(
                              onRatingUpdate: null,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              initialRating:
                                  provider.saveMovies[i].vote_count / 2,
                              itemSize: 15.0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                            ),
                            provider.saveMovies[i].vote_count == null
                                ? Text(
                                    'No Vote Found',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    '${provider.saveMovies[i].popularity}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                            provider.saveMovies[i].release_date == null
                                ? Text(
                                    'No Release Date Found',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    provider.saveMovies[i].release_date,
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            provider.delete(provider.saveMovies[i].id);
                          })
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
