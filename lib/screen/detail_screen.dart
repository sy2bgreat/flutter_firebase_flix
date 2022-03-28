import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_firebase_movies/model/model_movie.dart';

class DetailScreen extends StatefulWidget {
  final Movies movies;

  DetailScreen({Key? key, required this.movies}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    like = widget.movies.likes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.movies.posters),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.1),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 45, 0, 10),
                              child: Image.network(widget.movies.posters),
                              height: 300,
                            ),
                            Container(
                              padding: const EdgeInsets.all(7),
                              child: const Text(
                                "98% matched, 2019 season 1 ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(7),
                              child: Text(
                                widget.movies.titles,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.play_arrow),
                                    Text("Play"),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                widget.movies.toString(),
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "cast : Hyunbin, Yejin Son, Jihye Seo \n Director : Soyoon Lee",
                                style: TextStyle(
                                    color: Colors.white60, fontSize: 12),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              Positioned(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
            ],
          ),
          Container(
            color: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        like ? Icon(Icons.check) : Icon(Icons.add),
                        const Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        const Text(
                          "My Saved",
                          style: TextStyle(fontSize: 11, color: Colors.white60),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: const [
                      Icon(Icons.thumb_up),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        "Like?",
                        style: TextStyle(fontSize: 11, color: Colors.white60),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: const [
                      Icon(Icons.send),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        "Share",
                        style: TextStyle(fontSize: 11, color: Colors.white60),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
