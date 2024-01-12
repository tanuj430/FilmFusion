
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:good_mind/data/api_call.dart';
import 'package:good_mind/data/movie_model.dart';
import 'package:good_mind/pages/movie_detalis.dart';

class MoviesList {
  // this function will give list of popular movies######################################
  static Widget moviesList({required BuildContext context,required String myUrl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .31,
        child: FutureBuilder(
            future: ApiCall().getMovieData(url: myUrl),
            builder: (context, snapshot) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                // physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (context, index) {
                  var preMovie = snapshot.data!.results![index];
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
                  } else if (!snapshot.hasData ||
                      snapshot.data!.results == null) {
                    return Text('No data available');
                  } else {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(title:preMovie.title, overview: preMovie.overview, poster: preMovie.posterPath, voteAverage: preMovie.voteAverage,whichMovies: myUrl,),));
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: MediaQuery.sizeOf(context).width * .4,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white30,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "${ApiCall.poster_baseuri}${snapshot.data!.results![index].posterPath!}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          // this is text title of the movie#######################################
                          Container(
                            width: MediaQuery.sizeOf(context).width * .4,
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
                    );
                  }
                },
              );
            }),
      ),
    );
  }
}
