import 'package:flutter/material.dart';
import 'package:movie_maniac/widgets/movieToprated.dart';
import 'package:movie_maniac/widgets/movieTrend.dart';
import 'package:movie_maniac/widgets/on_tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Setting up for the TMDB API with my keys
  final tmdb = TMDB(
    ApiKeys('b5885260c7ceb67abd3e466068f303dc',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNTg4NTI2MGM3Y2ViNjdhYmQzZTQ2NjA2OGYzMDNkYyIsInN1YiI6IjYzOTlkNjJjNzdjMDFmMDBjYTVjOWViZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.'
            'Vi-Q2jc723p4jv2EStCaNIl4YxbyUCNtQvP8_WTn00A'),
  );

  Map? movieTrendMap;
  List movieTrendList = [];
  getMovieTrend() async {
    movieTrendMap = await tmdb.v3.trending
        .getTrending(mediaType: MediaType.movie, timeWindow: TimeWindow.week);
    setState(() {
      movieTrendList = movieTrendMap!['results'];
    });
    //print(movieTrendMap);
  }
  Map? movieTopRatedMap;
  List movieTopRatedList = [];
  getMovieTopRated() async {
    movieTopRatedMap = await tmdb.v3.movies.getTopRated();
    setState(() {
      movieTopRatedList = movieTopRatedMap!['results'];
    });
  }

  Map? tvTrendMap;
  List tvTrendList = [];
  getTvTrend() async {
    tvTrendMap = await tmdb.v3.trending
        .getTrending(mediaType: MediaType.tv, timeWindow: TimeWindow.day);
    setState(() {
      tvTrendList = tvTrendMap!['results'];
    });
    //print(tvTrendMap);
  }
  @override
  void initState() {
    getMovieTrend();
    getMovieTopRated();
    getTvTrend();
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
            MovieTrend(movieTrendList: movieTrendList),
            MovieUpcoming(movieTopRatedList: movieTopRatedList),
            OnTv(onTv: tvTrendList),
          ],
        ),
      ),
    );
  }
}

