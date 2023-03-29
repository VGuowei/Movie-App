import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_maniac/views/details_movie&tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TVShows extends StatefulWidget {
  const TVShows({Key? key}) : super(key: key);

  @override
  State<TVShows> createState() => _TVShowsState();
}

class _TVShowsState extends State<TVShows> {
  // Setting up for the TMDB API with my keys
  final tmdb = TMDB(
    ApiKeys('b5885260c7ceb67abd3e466068f303dc',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNTg4NTI2MGM3Y2ViNjdhYmQzZTQ2NjA2OGYzMDNkYyIsInN1YiI6IjYzOTlkNjJjNzdjMDFmMDBjYTVjOWViZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Vi-Q2jc723p4jv2EStCaNIl4YxbyUCNtQvP8_WTn00A'),
    logConfig: const ConfigLogger.showNone(),
  );
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  // Get a DatabaseReference
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Map? result;
  int onPage = 1;
  List listOfTVShows = [];

  getTVShows() async {
    result = await tmdb.v3.tv.getPopular(page: onPage);
    setState(() {
      listOfTVShows = result!['results'];
    });
  }
  browseTVShows(int page) async {
    listOfTVShows = []; // make it empty first to auto scroll back to top
    result = await tmdb.v3.tv.getPopular(page: page);
    setState(() {
      listOfTVShows = result!['results'];
    });
  }

  @override
  void initState() {
    getTVShows();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 18),
                  child: Text(
                    'TV Series',
                    style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: (result == null)
                  ? Column(
                children: const [
                  SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
                  : Column(
                children: [
                  GridView.builder(
                    addAutomaticKeepAlives: false,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: listOfTVShows.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Show details
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                Details(
                                  title: listOfTVShows[index]['name'],
                                  backdrop: listOfTVShows[index]['backdrop_path'],
                                  overview: listOfTVShows[index]['overview'],
                                  poster: listOfTVShows[index]['poster_path'],
                                  rate: listOfTVShows[index]['vote_average'].toStringAsFixed(2),
                                  releaseOn: listOfTVShows[index]['first_air_date'],
                                  id: listOfTVShows[index]['id'],
                                  popularity: listOfTVShows[index]['popularity'],
                                  type: 'tv',
                                ),),);
                        },
                        // Add to favourite
                        onDoubleTap: () {
                          ref.child('favorite/${listOfTVShows[index]['id']}').update({
                            'title':listOfTVShows[index]['name'],
                            'imageURL':'$tmdbImageUrl${listOfTVShows[index]['poster_path']}'
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
                        child: Center(
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 117,
                                // check in the response list if the poster_path is null or not
                                child: (listOfTVShows[index]['poster_path']!=null)?
                                Image.network(tmdbImageUrl + listOfTVShows[index]['poster_path'],
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress != null) {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    return child;
                                  },
                                ):const Image(image: AssetImage('assets/no_image_poster.png'),),
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
                                    Text(listOfTVShows[index]['vote_average'].toStringAsFixed(1))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        // previous page
                          onPressed: () {
                            // page cannot be less or equals to 0
                            if(onPage>1){
                              setState(() {
                                onPage=onPage-1;
                              });
                              browseTVShows(onPage);
                            }
                          },
                          child: const Icon(
                            Icons.navigate_before,
                            size: 30,
                          )),
                      Text(
                        onPage.toString(),
                        style: const TextStyle(fontSize: 26),
                      ),
                      ElevatedButton(
                        // next page
                          onPressed: () {
                            setState(() {
                              onPage = onPage + 1;
                            });
                            browseTVShows(onPage);
                          },
                          child: const Icon(
                            Icons.navigate_next,
                            size: 30,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
