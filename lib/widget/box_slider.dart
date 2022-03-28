import 'package:flutter/material.dart';
import 'package:flutter_firebase_movies/model/model_movie.dart';
import 'package:flutter_firebase_movies/screen/detail_screen.dart';

class BoxSlider extends StatelessWidget {
  final List<Movies> movies;
  const BoxSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("What's New"),
          Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: makeBoxImg(context, movies),
              ))
        ],
      ),
    );
  }
}

List<Widget> makeBoxImg(BuildContext context, List<Movies> movies) {
  List<Widget> result = [];

  for (var i = 0; i < movies.length; i++) {
    result.add(
      InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return DetailScreen(
                  movies: movies[i],
                );
              }));
        },
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.network(movies[i].posters),
          ),
        ),
      ),
    );
  }
  return result;
}
