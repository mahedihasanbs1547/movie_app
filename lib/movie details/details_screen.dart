import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/widget/elevated_button.dart';
import 'package:movie_app/feature/common/app_module.dart';
import 'package:movie_app/feature/favourite/favourite_viewmodel.dart';
import 'package:movie_app/feature/favourite/model/favourite_movie_model.dart';
import 'package:movie_app/feature/home/home_viewmodel_two.dart';
import 'package:movie_app/movie%20details/details_viewmodel.dart';

class MovieDetails extends StatelessWidget {
  int movieId;

  MovieDetails({
    super.key,
    required this.movieId,
  });

  DetailsViewmodel detailsViewmodel = DetailsViewmodel();

  @override
  Widget build(BuildContext context) {
    FavouriteViewmodel favouriteViewmodel =
        FavouriteViewModelSingleton.getInstance();

    detailsViewmodel.getMovieDetails(movieId);

    print("Detail Screen; $movieId");

    return ValueListenableBuilder(
        valueListenable: detailsViewmodel.movieDetailsData,
        builder: (context, movieList, _) {
          return Scaffold(
            backgroundColor: Colors.black87,
            body: detailsViewmodel.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16.sp,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 25.sp,
                                ),
                              ),
                              SizedBox(
                                width: 8.sp,
                              ),
                              Text(
                                "Movie Details",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24.sp,
                          ),
                          Container(
                            height: 200.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                image: NetworkImage(
                                  movieList?.largeCoverImage.toString() ?? "",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                            "History \u2022 Thriller \u2022 Drama \u2022 Mystery",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 8.sp,
                            ),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "${movieList?.title}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.sp,
                                    ),
                                    borderRadius: BorderRadius.circular(10).r),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.sp, vertical: 1.sp),
                                child: Text(
                                  "17+",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.sp,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.sp,
                                    ),
                                    borderRadius: BorderRadius.circular(10).r),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.sp, vertical: 1.sp),
                                child: Text(
                                  "${movieList?.year}",
                                  //"specialMovies[pagePosition].releaseYear ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.sp,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.sp,
                                    ),
                                    borderRadius: BorderRadius.circular(10).r),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.sp, vertical: 1.sp),
                                child: Text(
                                  "${movieList?.runtime} min",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          SizedBox(
                            width: 300.sp,
                            child: Text(
                              "${movieList?.descriptionIntro.toString()}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          MyElevatedButton(
                            buttonText: "Add To Watchlist",
                            backgroundColor: Colors.indigoAccent.shade400,
                            buttonTextColor: Colors.white,
                            onPressed: () {
                              favouriteViewmodel.onClickAddToFavourite(
                                FavouriteMovieModel(
                                  name: movieList?.title ?? "",
                                  image: movieList?.largeCoverImage ?? "",
                                  releaseYear: movieList?.year.toString() ?? "",
                                  runtime: movieList?.runtime
                                          .toString() ??
                                      "",
                                  rating: movieList?.rating
                                          .toString() ??
                                      " ",
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 12.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Overall Rating",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "${movieList?.rating.toDouble()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  RatingBar.builder(
                                    initialRating:
                                        movieList?.rating.toDouble() / 2.0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 16.sp,
                                    unratedColor: Colors.white,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star_rounded,
                                      color: Colors.amber,
                                      size: 10.sp,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                height: 80.sp,
                                width: 2.sp,
                                color: Colors.white,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Your Rating",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "0.0",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 0.0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 16.sp,
                                    unratedColor: Colors.white,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star_rounded,
                                      color: Colors.amber,
                                      size: 10.sp,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}