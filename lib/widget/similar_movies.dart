
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:good_mind/pages/movie_detalis.dart';

import '../data/api_call.dart';

class SimilarMovies extends StatefulWidget {
  String whichMovies;
  SimilarMovies({required this.whichMovies});

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: SizedBox(
        height: 250,
        child: FutureBuilder(
          future: ApiCall().getMovieData(url: widget.whichMovies),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.results == null) {
              return Text('No data available');
            } else {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.results!.length - 1,
                  itemBuilder: (context, index) {
                    var preMovie = snapshot.data!.results![index];
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MovieDetails(whichMovies: widget.whichMovies, title: preMovie.title, overview:preMovie.overview, poster:preMovie.posterPath, voteAverage: preMovie.voteAverage)));
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: 150,
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${ApiCall.poster_baseuri}${snapshot.data!.results![index].posterPath!}"),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            // this is text title of the movie#######################################
                            Container(
                              width: MediaQuery.sizeOf(context).width * .37,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      "${preMovie.title}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${preMovie.voteAverage!.toStringAsFixed(1)}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Icon(
                                        FluentSystemIcons.ic_fluent_star_filled,
                                        color: Colors.yellowAccent,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
