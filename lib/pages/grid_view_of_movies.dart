import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';
import '../data/api_call.dart';
import '../styles/colors.dart';
import 'movie_detalis.dart';

class GridLayout extends StatefulWidget {
  String whichMovies;
  GridLayout({required this.whichMovies});

  @override
  State<GridLayout> createState() => _GridLayoutState();
}

class _GridLayoutState extends State<GridLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.sizeOf(context).height,
        child: FutureBuilder(
            future: ApiCall().getMovieData(url: widget.whichMovies),
            builder: (context, snapshot) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (MediaQuery.of(context).size.height) /
                      MediaQuery.of(context).size.width /
                      4.3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data?.results?.length ?? 0,
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetails(
                                title: preMovie.title,
                                overview: preMovie.overview,
                                poster: preMovie.posterPath,
                                voteAverage: preMovie.voteAverage,
                                whichMovies: widget.whichMovies,
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            // margin: EdgeInsets.only(right: 15),
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height * .32,
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
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
