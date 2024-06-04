
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/feature/home/model/movie_list_category.dart';
import 'package:movie_app/feature/home/see_all_movies.dart';
import 'package:movie_app/feature/home/home_viewmodel_two.dart';
import 'package:movie_app/feature/home/widget/home_screen_shimmer.dart';
import 'package:movie_app/feature/home/widget/popup_menu.dart';
import 'package:movie_app/feature/home/widget/special_movies.dart';
import 'package:movie_app/feature/home/widget/top_movies.dart';
import 'package:movie_app/feature/home/widget/upcoming_movies.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  //HomeViewmodel homeViewmodel = HomeViewmodel();
  HomeViewmodelTwo homeViewmodelTwo = HomeViewmodelTwo.getInstance();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeViewmodelTwo.isLoading,
      builder: (context, isLoading, _) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: homeViewmodelTwo.isLoading.value
              ? buildShimmerEffect()
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                            top: 20, right: 20, bottom: 0, left: 20)
                        .r,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.welcome,

                                    ///"Welcome Back",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.movie_hub,

                                    ///'Movie Hub',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  showPopupMenu(context, );
                                },
                                child: Icon(
                                  Icons.square_outlined,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16.sp,
                          ),

                          // StreamBuilder(
                          //   stream: homeViewmodelTwo.movieDataStream,
                          //   builder: (context, allMovieData) {
                          //     return SizedBox(
                          //       width: double.infinity,
                          //       height: 220.sp,
                          //       child: SpecialMovies(
                          //         viewModelTow: homeViewmodelTwo,
                          //       ),
                          //     );
                          //   },
                          // ),
                          SizedBox(
                            height: 24.sp,
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.top_movie,

                                ///'Top Movie Picks',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SeeAllMovies(
                                        movieListCategory:
                                            MovieListCategory.topMovies,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.see_all,

                                  ///'See All',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          SizedBox(
                            height: 200.sp,
                            width: double.infinity,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  homeViewmodelTwo.allMovieData.value!.length,
                              itemBuilder: (context, index) {
                                return TopMovies(
                                  selectedIndex: index,
                                  homeViewmodelTwo: homeViewmodelTwo,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 15.sp,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.upcoming_movie,

                                ///'Upcoming Movies',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SeeAllMovies(
                                        movieListCategory:
                                            MovieListCategory.topMovies,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.see_all,

                                  ///'See All',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          SizedBox(
                            height: 200.sp,
                            width: double.infinity,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  homeViewmodelTwo.allMovieData.value!.length,
                              itemBuilder: (context, index) {
                                return UpcomingMovies(
                                  selectedIndex: index,
                                  homeViewmodelTwo: homeViewmodelTwo,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 15.sp,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

///filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust blur intensity as needed
