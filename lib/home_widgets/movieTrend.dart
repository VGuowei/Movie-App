import 'package:flutter/material.dart';

import '../views/details_movie&tv.dart';

class MovieTrend extends StatelessWidget {
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  final List movieTrendList;

  const MovieTrend({Key? key, required this.movieTrendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(11, 0, 11, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending movies of the week',maxLines: 2,softWrap: true,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 280,
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieTrendList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.fromLTRB(0,4, 10, 0),
                    child: InkWell(
                      onTap: () {
                        // Show details
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              Details(
                                poster: movieTrendList[index]['poster_path'],
                                backdrop: movieTrendList[index]['backdrop_path'],
                                overview: movieTrendList[index]['overview'],
                                title: movieTrendList[index]['title'],
                                rate: movieTrendList[index]['vote_average'].toStringAsFixed(2),
                                releaseOn: movieTrendList[index]['release_date'],
                                id: movieTrendList[index]['id'],
                                popularity: movieTrendList[index]['popularity'],
                                type: 'movie',
                              ),),);
                      },
                      child: SizedBox(
                        width: 344,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                (movieTrendList[index]['backdrop_path']!=null)?
                                Image.network(tmdbImageUrl + movieTrendList[index]['backdrop_path'],
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress != null) {
                                      return Center(
                                        child: SizedBox(
                                          width: 344,
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
                                ):  const Image(image: AssetImage('assets/no_image_backdrop.jpg')),
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
                                const EdgeInsets.fromLTRB(10,14,10,10),
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
