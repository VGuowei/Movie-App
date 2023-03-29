import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../views/details_movie&tv.dart';

class MovieUpcoming extends StatelessWidget {
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  final List movieTopRatedList;
  // Get a DatabaseReference
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  MovieUpcoming({Key? key, required this.movieTopRatedList}) : super(key: key);

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
          SizedBox(
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
                        onTap: () {
                          // Show details
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                Details(
                                  backdrop: movieTopRatedList[index]['backdrop_path'],
                                  poster: movieTopRatedList[index]['poster_path'],
                                  title: movieTopRatedList[index]['title'],
                                  overview: movieTopRatedList[index]['overview'],
                                  rate: movieTopRatedList[index]['vote_average'].toStringAsFixed(2),
                                  releaseOn: movieTopRatedList[index]['release_date'],
                                  id: movieTopRatedList[index]['id'],
                                  popularity: movieTopRatedList[index]['popularity'],
                                  type: 'movie',
                                ),),);
                        },
                        // Add to favourite
                        onDoubleTap: () {
                          ref.child('favorite/${movieTopRatedList[index]['id']}').update({
                            'title':movieTopRatedList[index]['title'],
                            'imageURL':'$tmdbImageUrl${movieTopRatedList[index]['poster_path']}'
                          });
                          AnimatedSnackBar.material(
                            'Added to Favorites',
                            snackBarStrategy: RemoveSnackBarStrategy(),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            duration: const Duration(seconds: 2),
                            type: AnimatedSnackBarType.success,
                            mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                          ).show(context);
                        },
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                     height: 180,
                                    child: (movieTopRatedList[index]['poster_path']!=null)?
                                    Image.network(tmdbImageUrl + movieTopRatedList[index]['poster_path'],
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                      // show load indicator on loading
                                        if (loadingProgress != null) {
                                          return Center(
                                            child: Column(
                                              children: const [
                                                SizedBox(height: 90,),
                                                CircularProgressIndicator(),
                                              ],
                                            ),
                                          );
                                        }
                                        return child;
                                      },
                                      // if api returns null show a local picture
                                    ):const Image(image: AssetImage('assets/no_image_poster.png')),
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
