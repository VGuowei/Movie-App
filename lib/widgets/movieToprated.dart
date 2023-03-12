import 'package:flutter/material.dart';

class MovieUpcoming extends StatelessWidget {
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  final List movieTopRatedList;

  const MovieUpcoming({Key? key, required this.movieTopRatedList}) : super(key: key);

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
                  'Top Rated Movies',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Container(
            height: 250,
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieTopRatedList.length,
                itemBuilder: (context, index) {

                    return Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.network(
                                    tmdbImageUrl +
                                        movieTopRatedList[index]
                                        ['poster_path'],
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context,
                                        child, loadingProgress) {
                                      if (loadingProgress !=
                                          null) {
                                        return Center(
                                          child: Column(
                                            children: const [
                                              SizedBox(
                                                height: 90,
                                              ),
                                              CircularProgressIndicator(),
                                              SizedBox(
                                                height: 50,
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                      return child;
                                    },
                                  ),
                                  Container(
                                    height: 20,
                                    width: 48,
                                    color: Colors.black54,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 20,
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          movieTopRatedList[index]
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
                                    movieTopRatedList[index]
                                    ['title'],
                                    softWrap: true,
                                    maxLines: 2,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
