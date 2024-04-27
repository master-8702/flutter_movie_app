import 'package:flutter/material.dart';

import 'package:flutter_movie_app/models/movie.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final double height;
  final double width;

  const MovieTile({
    super.key,
    required this.movie,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePoster(movie.posterUrl()),
          _movieInfo(movie),
        ],
      ),
    );
  }

  Widget _moviePoster(String posterUrl) {
    return Container(
      width: width * 0.35,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(posterUrl)),
      ),
    );
  }

  Widget _movieInfo(Movie movie) {
    return SizedBox(
      width: width * 0.66,
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.56,
                child: Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              top: height * 0.02,
            ),
            child: Text(
              '${movie.language.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: height * 0.07),
            child: Text(
              movie.description,
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
