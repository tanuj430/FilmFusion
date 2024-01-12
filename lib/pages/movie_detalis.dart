import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:good_mind/data/api_call.dart';
import 'package:good_mind/styles/colors.dart';
import 'package:good_mind/widget/similar_movies.dart';
import 'package:readmore/readmore.dart';

class MovieDetails extends StatefulWidget {
  String? poster;
  String? title;
  String? overview;
  num? voteAverage;
  String whichMovies;

  MovieDetails({
    required this.whichMovies,required this.title,required this.overview,required this.poster,required this.voteAverage
});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // movie picture########################################
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * .5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${ApiCall.poster_baseuri}${widget.poster}"),
                      fit: BoxFit.cover,
                    )
                  ),
                  // foregroundDecoration#####################
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kBackgroundColor.withOpacity(.8),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),


                  // after the image################################################
                  Container(
                    margin:const EdgeInsets.symmetric(horizontal: 20),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       // a row for basic detail about movie########################################
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.title!}",style:const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),),
                            ),
                            // Row for rating################################
                            Row(
                              children: [
                                Text("${widget.voteAverage?.toStringAsFixed(1)}",
                                  style: const TextStyle(
                                    color: Colors.white,

                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                ),),
                                const SizedBox(width: 10,),
                                SizedBox(
                                  child: const Icon(FluentSystemIcons.ic_fluent_star_filled,color: Colors.yellowAccent, size: 25,),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTag("Epic"),
                            const SizedBox(width: 10),
                            buildTag("Motivation"),
                            const SizedBox(width: 10),
                            buildTag("Drama"),
                            const SizedBox(width: 10),
                          ],
                        ),

                        const SizedBox(height: 10,),

                        ReadMoreText(
                          "${widget.overview}",
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          moreStyle: TextStyle(color: kButtonColor),
                          lessStyle: TextStyle(color: kButtonColor),
                          style: TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),

                        SizedBox(height: 20,),

                        Text("Similar Movies",style: (TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        )),),

                        SizedBox(height: 20,),

                        SimilarMovies(whichMovies:widget.whichMovies),



                      ],
                    ),


                  ),
              ],
            ),
          ),

        ],
      )
    );
  }

  // it is a function for tags #############################################
  Widget buildTag(String title){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: kSearchBarColor,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white30,
          fontSize: 16,
        ),
      ),
    );
  }
}
