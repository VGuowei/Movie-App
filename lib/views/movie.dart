import 'package:flutter/material.dart';
import 'package:movie_maniac/views/details.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieView extends StatefulWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  // Setting up for the TMDB API with my keys
  final tmdb = TMDB(
    ApiKeys('b5885260c7ceb67abd3e466068f303dc',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNTg4NTI2MGM3Y2ViNjdhYmQzZTQ2NjA2OGYzMDNkYyIsInN1YiI6IjYzOTlkNjJjNzdjMDFmMDBjYTVjOWViZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Vi-Q2jc723p4jv2EStCaNIl4YxbyUCNtQvP8_WTn00A'),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';

  Map? result;
  int onPage = 1;
  List listOfMovies = [];

  getMovies() async {
    result = await tmdb.v3.movies.getPopular(page: onPage);
    setState(() {
      listOfMovies = result!['results'];
    });
  }

  nextPage(int page) async {
    listOfMovies =[];
    result = await tmdb.v3.movies.getPopular(page: page);
    setState(() {
      listOfMovies = result!['results'];
    });
  }

  previousPage(int page) async {
    listOfMovies =[];
    result = await tmdb.v3.movies.getPopular(page: page);
    setState(() {
      listOfMovies = result!['results'];
    });
  }

  getGenres(int id) async{

  }

  @override
  void initState() {
    getMovies();
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
                    'Popular Movies',
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
                          itemCount: listOfMovies.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // Show details
                                FocusManager.instance.primaryFocus?.unfocus();

                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Details(
                                          title: listOfMovies[index]['title'],
                                          backdrop: listOfMovies[index]['backdrop_path'],
                                          overview: listOfMovies[index]['overview'],
                                          poster: listOfMovies[index]['poster_path'],
                                          rate: listOfMovies[index]['vote_average'].toStringAsFixed(2),
                                          releaseOn: listOfMovies[index]['release_date'],),),);
                              },
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      width: 117,
                                      child: Image.network(tmdbImageUrl + listOfMovies[index]['poster_path'],
                                        loadingBuilder: (context, child,
                                            loadingProgress) {
                                          if (loadingProgress != null) {
                                            return const Center(child: CircularProgressIndicator());
                                          }
                                          return child;
                                        },
                                      ),
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
                                          Text(listOfMovies[index]['vote_average'].toStringAsFixed(1),style: TextStyle(fontSize: 11),)
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
                                onPressed: () {
                                  if(onPage>1){
                                    setState(() {
                                      onPage=onPage-1;
                                      previousPage(onPage);
                                    });
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
                                onPressed: () {
                                  setState(() {
                                    onPage = onPage + 1;
                                    nextPage(onPage);
                                  });
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
