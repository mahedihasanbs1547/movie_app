import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie_list_response_model.dart';
import 'package:movie_app/data/repository/search_movie_repository.dart';
import 'package:movie_app/feature/search/model/debouncer.dart';
import 'package:movie_app/feature/search/model/genres_data_model.dart';

class SearchViewmodel {
  static SearchViewmodel? searchViewmodel;

  static SearchViewmodel getInstance() {
    searchViewmodel = searchViewmodel ?? SearchViewmodel();
    return searchViewmodel!;
  }

  TextEditingController searchTextEditingController = TextEditingController();

  final ValueNotifier<List?> _suggestionList = ValueNotifier<List>([]);

  ValueListenable<List?> get suggestionList => _suggestionList;

  final List<Movies> _tempSuggestionList = [];

  SearchMovieRepository searchMovieRepository = SearchMovieRepository();

  final Debouncer _debouncer = Debouncer(milliseconds: 100);

  void onSearchChanged() {
    _debouncer.run(
      () async {
        MovieListResponseModel movieListResponse = await searchMovieRepository
            .getSearchMovieList(searchTextEditingController.text);
        _suggestionList.value = [];
        _suggestionList.value = movieListResponse.data?.movies ?? [];

        if (_suggestionList.value != null) {
          _tempSuggestionList.clear();
          for (var item in _suggestionList.value!) {
            bool isGenreContain =
                selectedGenreList.any((genre) => item.genres.contains(genre));
            //print(item.genres);
            if (isGenreContain) {
              _tempSuggestionList.add(item);
            }
            //print(isGenreContain);
          }
        }
        _suggestionList.value = [];
        _suggestionList.value = _tempSuggestionList;
      },
    );
  }

  ValueNotifier<List> genresDataList = ValueNotifier(
    [
      GenresDataModel(
        labelText: "Action",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Comedy",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Romance",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Sci-Fi",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Adventure",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Thriller",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "History",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Drama",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Documentary",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Crime",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "War",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Musical",
        isSelected: false,
      ),
      GenresDataModel(
        labelText: "Mystery",
        isSelected: false,
      ),
    ],
  );
  List<String> sortBy = ["title", "year", "rating", "peers", "seeds"];
  ValueNotifier<bool> isSelectedSortBy = ValueNotifier(false);
  ValueNotifier<String> selectedItemSortBy = ValueNotifier('');


  List<String> selectedGenreList = [];

  void onSelectedGenresItem(
      GenresDataModel model, bool isSelected, String selectedGenreType) {
    if (isSelected) {
      selectedGenreList.add(selectedGenreType);
    } else {
      selectedGenreList.remove(selectedGenreType);
    }

    print("Selected Genres : ");
    for (var item in selectedGenreList) {
      if (kDebugMode) {
        print(item);
      }
    }

    model.isSelected = isSelected;
    genresDataList.value = [...genresDataList.value];
  }

  void onSelectedSortByItem(bool isSelected, String selectedItem){
    selectedItemSortBy.value = selectedItem;
    isSelectedSortBy.value = isSelected;
  }

  void dispose() {}
}
