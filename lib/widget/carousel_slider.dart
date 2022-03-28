import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_movies/model/model_movie.dart';
import 'package:flutter_firebase_movies/screen/detail_screen.dart';

class CarouselImg extends StatefulWidget {
  final List<Movies> movies;
  CarouselImg({Key? key, required this.movies})
      : super(key: key); //through the constructor

  @override
  State<CarouselImg> createState() => _CarouselImgState();
}

class _CarouselImgState extends State<CarouselImg> {
  late List<Movies> movies;
  late List<Widget> images;
  late List<String> keyword;
  late List<bool> like;
  int _currentPage = 0;
  late String _currentKeyword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movies = widget.movies;
    images = movies.map((e) => Image.network(e.posters)).toList();
    keyword = movies.map((e) => e.keywords).toList();
    like = movies.map((e) => e.likes).toList();
    _currentKeyword = keyword[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
          ),
          CarouselSlider(
            items: images,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                  _currentKeyword = keyword[_currentPage];
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      like[_currentPage]
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  like[_currentPage] = !like[_currentPage];
                                  movies[_currentPage]
                                      .reference!
                                      .update({'likes': like[_currentPage]});
                                });
                              },
                              icon: const Icon(Icons.check),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  like[_currentPage] = !like[_currentPage];
                                  movies[_currentPage]
                                      .reference!
                                      .update({'likes': like[_currentPage]});
                                });
                              },
                              icon: const Icon(Icons.favorite),
                            ),
                      Text(
                        "My Saved",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text("Play", style: TextStyle(color: Colors.black))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) {
                                return DetailScreen(
                                  movies: movies[_currentPage],
                                );
                              }));
                        },
                        icon: const Icon(Icons.info),
                      ),
                      const Text(
                        "Information",
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: makeIndicator(like, _currentPage),
          )
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {
  late List<Widget> results = [];

  for (var i = 0; i < list.length; i++) {
    results.add(
      Container(
        width: 8,
        height: 8,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4),
        ),
      ),
    );
  }
  return results;
}
