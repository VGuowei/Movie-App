import 'package:flutter/material.dart';

class MovieTrend extends StatelessWidget {
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  final List movieTrendList;

  const MovieTrend({Key? key, required this.movieTrendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Text(
                  'Trending movies of the week',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Container(
            height: 280,
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieTrendList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.fromLTRB(0, 4, 12, 0),
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 369,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.network(
                                  tmdbImageUrl +
                                      movieTrendList[index]
                                      ['backdrop_path'],
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context,
                                      child, loadingProgress) {
                                    if (loadingProgress !=
                                        null) {
                                      return Center(
                                        child: SizedBox(
                                          width: 369,
                                          child: Column(
                                            children: const [
                                              SizedBox(
                                                height: 90,
                                              ),
                                              CircularProgressIndicator(),
                                              SizedBox(
                                                height: 80,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return child;
                                  },
                                ),
                                Container(
                                  height: 20,
                                  width: 44,
                                  color: Colors.black54,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        movieTrendList[index]
                                        ['vote_average']
                                            .toStringAsFixed(1),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                                padding:
                                const EdgeInsets.all(10),
                                child: Text(
                                  movieTrendList[index]
                                  ['title'],
                                  softWrap: true,
                                  maxLines: 2,
                               style: const TextStyle(fontSize: 20), )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
