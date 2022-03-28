import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_movies/model/model_movie.dart';
import 'package:flutter_firebase_movies/screen/detail_screen.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchTxt = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filter.addListener(() {
      setState(() {
        _searchTxt = _filter.text;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Movies').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResult = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data().toString().contains(_searchTxt)) {
        searchResult.add(d);
      }
    }
    return Expanded(
      child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5,
          padding: EdgeInsets.all(3),
          children:
              searchResult.map((data) => _buildItem(context, data)).toList()),
    );
  }

  Widget _buildItem(BuildContext context, DocumentSnapshot data) {
    final movies = Movies.fromSnapShot(data);
    return InkWell(
      child: Image.network(movies.posters),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movies: movies);
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(30),
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: focusNode.hasFocus
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchTxt = "";
                                });
                              },
                            )
                          : Container(),
                      hintText: "Search",
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                focusNode.hasFocus
                    ? Expanded(
                        child: ElevatedButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchTxt = "";
                              focusNode.unfocus();
                            });
                          },
                        ),
                      )
                    : Expanded(
                        flex: 0,
                        child: Container(),
                      )
              ],
            ),
          ),
          _buildBody(context)
        ],
      ),
    );
  }
}
