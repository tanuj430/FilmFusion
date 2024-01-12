import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:good_mind/data/api_call.dart';
import 'package:good_mind/data/movie_model.dart';
import 'package:good_mind/pages/movie_detalis.dart';

class CardLayout {
  static String nowPlayingMovies = "https://api.themoviedb.org/3/movie/now_playing?api_key=";

  static Widget foryoucardLayout(
      {required BuildContext context, required PageController pageController}) {
    return Container(
      height: MediaQuery
          .sizeOf(context)
          .height * .5,
      child: FutureBuilder<MovieModel>(
        future: ApiCall().getMovieData(url: nowPlayingMovies),
        builder: (contex, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                width: MediaQuery
                    .sizeOf(context)
                    .width,
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.results == null) {
            return Text('No data available');
          } else {
            return PageView.builder(
              controller: pageController,
              itemCount: snapshot.data!.results!.length,
              itemBuilder: (context, index) {
                var pre = snapshot.data!.results![index];
                if (pre.posterPath != null && pre.overview != null &&
                    pre.title != null && pre.voteAverage != null) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetails(poster: pre.posterPath,
                                    title: pre.title,
                                    overview: pre.overview,
                                    voteAverage: pre.voteAverage,
                                whichMovies: nowPlayingMovies,),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                                "${ApiCall.poster_baseuri}${snapshot.data!
                                    .results![index].posterPath!}"),
                            fit: BoxFit.cover,
                          )

                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                        width: MediaQuery
                            .sizeOf(context)
                            .width,
                        child: LinearProgressIndicator()),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
