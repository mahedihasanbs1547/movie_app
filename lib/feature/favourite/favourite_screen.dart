import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/widget/add_watchlist_button.dart';
import 'package:movie_app/feature/common/app_module.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'favourite_viewmodel.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavouriteViewmodel favouriteViewmodel =
        FavouriteViewModelSingleton.getInstance();

    favouriteViewmodel.fetchFavouriteMovies();

    /*void initState() {
      super.initState();
      favouriteViewmodel.fetchFavouriteMovies();


    }*/


    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(top: 20.sp, left: 16.sp, right: 16.sp, bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    /*  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                    ),*/
                    Text(
                      AppLocalizations.of(context)!.favourite_movie,

                      ///"Favourite Movie",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.sp,
                ),
                ValueListenableBuilder(
                  valueListenable: favouriteViewmodel.watchList,
                  builder: (context, movieList, _) {
                    return SizedBox(
                      ///height: 500.sp,
                      height: MediaQuery.of(context).size.height - 185.sp,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: movieList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 150.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(10).r,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: movieList[index] == ""
                                      ? const SizedBox.shrink()
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                movieList[index].image,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.r),
                                              bottomLeft: Radius.circular(10.r),
                                            ),
                                          ),
                                        ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.sp, horizontal: 16.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "History \u2022 Thriller \u2022 Drama \u2022 Mystery",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 8.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.sp,
                                        ),
                                        Text(
                                          movieList[index].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.sp,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: .5.sp,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10)
                                                          .r),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.sp,
                                                  vertical: 1.sp),
                                              child: Text(
                                                "PG 13",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 6.sp,
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
                                                    width: .5.sp,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10)
                                                          .r),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.sp,
                                                  vertical: 1.sp),
                                              child: Text(
                                                "${movieList[index].releaseYear}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 6.sp,
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
                                                    width: .5.sp,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10)
                                                          .r),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.sp,
                                                  vertical: 1.sp),
                                              child: Text(
                                                "${movieList[index].runtime}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 6.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star_rate_rounded,
                                              color: Colors.yellow.shade700,
                                              size: 20.sp,
                                            ),
                                            SizedBox(
                                              width: 2.sp,
                                            ),
                                            Text(
                                              "${movieList[index].rating}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              height: 25.sp,
                                              width: 100,
                                              child: AddWatchlistButton(
                                                buttonText:
                                                    "Remove From Watchlist",
                                                onPressed: () {
                                                  favouriteViewmodel
                                                      .onClickRemoveFromFavourite(
                                                          index);
                                                  favouriteViewmodel
                                                      .fetchFavouriteMovies();

                                                  ///favouriteViewmodel.fetchFavouriteMovies();
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 15.sp,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
