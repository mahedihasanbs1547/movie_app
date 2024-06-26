import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/widget/add_watchlist_button.dart';
import 'package:movie_app/feature/search/widget/bottom_sheet.dart';
import 'package:movie_app/movie%20details/details_screen.dart';
import 'package:movie_app/feature/search/search_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});


  final searchViewmodel = SearchViewmodel.getInstance();

  @override
  Widget build(BuildContext context) {

    debugPrint("============================== SEARCH SCREEN BUILD ============================");

    return GestureDetector(
      onTap: () {
        print("Keyboard off Clicked");
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(top: 20.sp, left: 16.sp, right: 16.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.search,

                        ///'Search.',
                        style: TextStyle(
                            color:Theme.of(context).colorScheme.primary,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return SearchFilterBottomSheet(

                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.movie_filter_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  SizedBox(
                    child: TextFormField(
                      controller: searchViewmodel.searchTextEditingController,
                      onChanged: (String value) {
                        searchViewmodel.onSearchChanged();
                      },
                      style: const TextStyle(color: Colors.white54),
                      cursorColor: Theme.of(context).colorScheme.primary,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white24,
                        prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary,),
                        prefixIconColor: Colors.white54,
                        hintText: "${AppLocalizations.of(context)!.search}...",
                        hintStyle:  TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30).r,
                          borderSide: BorderSide(
                            width: 1.r,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30).r,
                          borderSide: BorderSide(
                            width: 1.r,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.sp,
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: searchViewmodel.suggestionList,
                      builder: (context, suggestionList, _) {
                        if (suggestionList!.isEmpty) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context)!.no_movie_found,
                              style: TextStyle(color: Theme.of(context).colorScheme.primary,
                            ),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: suggestionList.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 700.sp,
                              width: double.infinity,
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemCount: suggestionList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      print(
                                          "Search Page ${suggestionList[index].id}");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MovieDetails(
                                              movieId: suggestionList[index]
                                                  .id
                                                  .toInt()),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 150.sp,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius:
                                            BorderRadius.circular(10).r,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: suggestionList[index]
                                                        .largeCoverImage ==
                                                    null
                                                ? const SizedBox.shrink()
                                                : Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white24,
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          suggestionList[index]
                                                              .largeCoverImage
                                                              .toString(),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.r),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.r),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.sp,
                                                  horizontal: 16.sp),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 20.sp,
                                                    child: ListView.separated(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          suggestionList[index]
                                                              .genres
                                                              .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int genresIndex) {
                                                        return Text(
                                                          suggestionList[index]
                                                                      .genres?[
                                                                  genresIndex] ??
                                                              "null",
                                                          //"History \u2022 Thriller \u2022 Drama \u2022 Mystery",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                            fontSize: 8.sp,
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Text(
                                                          " \u2022 ",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                            fontSize: 8.sp,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4.sp,
                                                  ),
                                                  SizedBox(
                                                    height: 50.sp,
                                                    child: Text(
                                                      suggestionList[index].title,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4.sp,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: .5.sp,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                            .circular(10)
                                                                        .r),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    5.sp,
                                                                vertical: 1.sp),
                                                        child: Text(
                                                          "PG 13",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                            fontSize: 6.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8.sp,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: .5.sp,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                            .circular(10)
                                                                        .r),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    5.sp,
                                                                vertical: 1.sp),
                                                        child: Text(
                                                          suggestionList[index]
                                                              .year
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                            fontSize: 6.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8.sp,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: .5.sp,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                            .circular(10)
                                                                        .r),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    5.sp,
                                                                vertical: 1.sp),
                                                        child: Text(
                                                          suggestionList[index]
                                                              .runtime
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                            fontSize: 6.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star_rate_rounded,
                                                        color: Colors
                                                            .yellow.shade700,
                                                        size: 20.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 2.sp,
                                                      ),
                                                      Text(
                                                        suggestionList[index]
                                                            .rating
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SizedBox(
                                                        height: 25.sp,
                                                        width: 100,
                                                        child:
                                                            AddWatchlistButton(
                                                          buttonText:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .add_to_favorite,
                                                          onPressed: () {},
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
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 15.sp,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
