import 'dart:ui';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_mind/pages/grid_view_of_movies.dart';
import 'package:good_mind/styles/colors.dart';
import 'package:good_mind/widget/for_you_card_layout.dart';
import 'package:good_mind/widget/list_of_movies.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String upcomingUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=";
  String legendarUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=";
  String popularUrl = "https://api.themoviedb.org/3/movie/popular?api_key=";

  int currentPageIndex = 0;
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: .9);

  List tabbarItems = [
    FluentSystemIcons.ic_fluent_home_filled,
    CupertinoIcons.compass,
    CupertinoIcons.videocam_fill,
    FluentSystemIcons.ic_fluent_person_filled
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        //using stack for floating nav bar###############################################
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hi,Melina!",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Serach bar#####################################################################
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kSearchBarColor,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FluentSystemIcons.ic_fluent_search_filled,
                              color: Colors.white30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white30),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "For you",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.white54),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // foryoulayout#######################################################3
                  CardLayout.foryoucardLayout(context: context, pageController: pageController),
                  SizedBox(
                    height: 20,
                  ),
                  // dot indicator #######################################################
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: SmoothPageIndicator(
                          controller: pageController, // PageController
                          count: 10,
                          effect: ScrollingDotsEffect(
                            dotWidth: 6,
                            dotHeight: 6,
                            activeDotColor: Colors.white,
                          ), // your preferred effect
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        height: MediaQuery.sizeOf(context).height * .025,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upcoming",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.white54),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GridLayout(whichMovies: upcomingUrl,),));
                            },
                            child: Text(
                              "See all",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: kButtonColor),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MoviesList.moviesList(context: context,myUrl: upcomingUrl),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Legendary Movies",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white54),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GridLayout(whichMovies: legendarUrl,),));
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: kButtonColor),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  MoviesList.moviesList(context: context,myUrl: legendarUrl),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white54),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GridLayout(whichMovies: popularUrl,),));
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: kButtonColor),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  MoviesList.moviesList(context: context,myUrl: popularUrl),
                ],
              ),
            ),
          ),
          // Navbar-----------------------------------------------------------------------
          Positioned(
            bottom: 10,
            left: 25,
            right: 25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25.0,sigmaY: 25.0),
                child: Container(
                  color: kSearchBarColor.withOpacity(.6),
                  width: MediaQuery.sizeOf(context).width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...tabbarItems.map((e) => Icon(
                            e,
                            color: e == FluentSystemIcons.ic_fluent_home_filled
                                ? Colors.white
                                : Colors.white54,
                            size: 30,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
