import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/movie_category.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  late double _width;
  late double _height;
  late TextEditingController _searchTextFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _searchTextFieldController = TextEditingController();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _topBar(),
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
    return Container(
      width: _width * 0.50,
      height: _height * 0.05,
      child: TextField(
        controller: _searchTextFieldController,
        onSubmitted: (_input) {},
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
      value: MovieCategory.latest,
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
          value: MovieCategory.latest,
          child: Text(
            MovieCategory.latest,
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
          value: MovieCategory.upcoming,
          child: Text(
            MovieCategory.none,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      onChanged: (_value) {},
    );
  }
}
