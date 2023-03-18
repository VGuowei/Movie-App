import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../views/details_movie&tv.dart';

class OnTv extends StatelessWidget {
  OnTv({Key? key,required this.onTv}) : super(key: key);
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  final List onTv;
  // Get a DatabaseReference
  DatabaseReference ref = FirebaseDatabase.instance.ref();

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
                  'On TV',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 320,
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: onTv.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.fromLTRB(0, 4, 12, 0),
                    child: InkWell(
                      onTap: () {
                        // Show details
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              Details(
                                poster: onTv[index]['poster_path'],
                                backdrop: onTv[index]['backdrop_path'],
                                title: onTv[index]['name'],
                                overview: onTv[index]['overview'],
                                rate: onTv[index]['vote_average'].toStringAsFixed(2),
                                releaseOn: onTv[index]['first_air_date'],
                                id: onTv[index]['id'],
                                popularity: onTv[index]['popularity'],
                                type: 'tv',
                              ),),);
                      },
                      onDoubleTap: () {
                        ref.child('favorite/${onTv[index]['id']}').update({
                          'title':onTv[index]['name'],
                          'imageURL':'$tmdbImageUrl${onTv[index]['poster_path']}'
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
                        width: 165,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  height:248,
                                  child: (onTv[index]['poster_path']!=null)?
                                  Image.network(tmdbImageUrl + onTv[index]['poster_path'],
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress != null) {
                                        return Center(
                                          child: Column(
                                            children: const [
                                              SizedBox(height: 108,),
                                              CircularProgressIndicator(),
                                            ],
                                          ),
                                        );
                                      }
                                      return child;
                                    },
                                  ):
                                  const Image(image: AssetImage('assets/no_image_poster.png')),
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
                                        onTv[index]
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
                                  onTv[index]
                                  ['name'],
                                  softWrap: true,
                                  maxLines: 2,
                                  )),
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
