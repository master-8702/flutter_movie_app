import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/widgets/movie_tile.dart';
import 'package:flutter_movie_app/constants/movie_category.dart';
import 'package:flutter_movie_app/models/home_screen_state.dart';
import 'package:flutter_movie_app/controllers/home_screen_state_controller.dart';

class HomeScreen extends ConsumerWidget {
  late double _width;
  late double _height;
  late TextEditingController _searchTextFieldController;
  late HomeScreenStateController _homeScreenStateController;
  late HomeScreenState _homeScreenState;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _searchTextFieldController = TextEditingController();

    _homeScreenStateController =
        ref.watch(homeScreenStateControllerProvider.notifier);
    _homeScreenState = ref.watch(homeScreenStateControllerProvider);

    // to display the searched term on the search field after the UI is updated
    _searchTextFieldController.text = _homeScreenState.searchQuery!;

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundImage(),
            _foregroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundImage() {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSKiAdLbAUFESx_QtMnn77aRd6TeezDMvfutBbG547FA&s'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _foregroundWidget() {
    return Container(
      padding: EdgeInsets.only(top: _height * 0.02),
      width: _width * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBar(),
          Container(
            height: _height * 0.83,
            padding: EdgeInsets.symmetric(vertical: _height * 0.01),
            child: _moviesListView(),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Container(
      height: _height * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchField(),
          _categoryDropdown(),
        ],
      ),
    );
  }

  Widget _searchField() {
    const _border = InputBorder.none;
    return SizedBox(
      width: _width * 0.50,
      height: _height * 0.05,
      child: TextField(
        controller: _searchTextFieldController,
        onSubmitted: (_input) {
          _homeScreenStateController.updateMovieSearchText(_input);
        },
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            focusedBorder: _border,
            border: _border,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white24,
            ),
            hintStyle: TextStyle(color: Colors.white54),
            filled: false,
            fillColor: Colors.white24,
            hintText: 'Search ...'),
      ),
    );
  }

  Widget _categoryDropdown() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: _homeScreenState.searchCategory,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      items: const [
        DropdownMenuItem(
          value: MovieCategory.inTheatre,
          child: Text(
            MovieCategory.inTheatre,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: MovieCategory.popular,
          child: Text(
            MovieCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: MovieCategory.topRated,
          child: Text(
            MovieCategory.topRated,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: MovieCategory.upcoming,
          child: Text(
            MovieCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: MovieCategory.none,
          child: Text(
            MovieCategory.none,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      onChanged: (_value) {
        if (_value.toString().isNotEmpty) {
          _homeScreenStateController.updateMovieCategory(_value.toString());
        } else {
          _homeScreenStateController.updateMovieCategory(_value.toString());
        }
      },
    );
  }

  Widget _moviesListView() {
    List<Movie> movies = _homeScreenState.movies ?? [];

    if (movies.isNotEmpty) {
      // here the NotificationListener will help us to fetch more movies when
      // we reach the end of the current fetched movie list (the ListView).
      return NotificationListener(
        onNotification: (_onScrollnotification) {
          if (_onScrollnotification is ScrollEndNotification) {
            final before = _onScrollnotification.metrics.extentBefore;
            final max = _onScrollnotification.metrics.maxScrollExtent;

            // if before == max that means we reach the end of our list, so we
            // can call getMovies() and since the currentPage value of our state
            // is already incremented by one,when movies are fetched last (first)
            // time, we will fetch the next page.
            if (before == max) {
              _homeScreenStateController.getMovies();
              return true;
            }
            return false;
          }
          return false;
        },
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: GestureDetector(
                onTap: () {},
                child: MovieTile(
                    movie: movies[index],
                    height: _height * 0.22,
                    width: _width * 0.85),
              ),
            );
          },
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
