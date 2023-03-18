import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_maniac/views/details_movie&tv.dart';
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
    logConfig: const ConfigLogger.showNone(),
  );
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  // default filter genre is none
  String genre='';
  // Get a DatabaseReference
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Map? result;
  int onPage = 1;
  late List listOfMovies;

  getMovies(int page,String selectedGenre) async {
    listOfMovies = []; // make it empty first to auto shrink back to top
    result = await tmdb.v3.discover.getMovies(page: onPage,sortBy: SortMoviesBy.popularityDesc,withGenres: selectedGenre);
    setState(() {
      listOfMovies = result!['results'];
    });
  }

  @override
  void initState() {
    getMovies(onPage,genre);
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
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text(
                    'Popular Movies',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) =>  AlertDialog(
                          title: const Text('Select one Filter',style: TextStyle(fontWeight: FontWeight.bold)),
                          content:Wrap(
                            children: [
                              TextButton(
                              onPressed: (){
                               setState(() {
                                 onPage=1; // reset the page regardless
                                 genre='28'; // Action id is 28
                                 getMovies(onPage, genre);
                               });
                               Navigator.pop(context);
                              },
                              child: Container(
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent),
                               padding: const EdgeInsets.all(8),
                               height: 36,
                               child: Text('Action',style: GoogleFonts.robotoMono(fontSize: 12,color: Colors.white)),),
                            ),
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    onPage=1; // reset the page regardless
                                    genre='12'; // Adventure id is 12
                                    getMovies(onPage, genre);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent),
                                  padding: const EdgeInsets.all(8),
                                  height: 36,
                                  child: Text('Adventure',style: GoogleFonts.robotoMono(fontSize: 12,color: Colors.white)),),
                              ),
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    onPage=1; // reset the page regardless
                                    genre='16'; // Animation id is 16
                                    getMovies(onPage, genre);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent),
                                  padding: const EdgeInsets.all(8),
                                  height: 36,
                                  child: Text('Animation',style: GoogleFonts.robotoMono(fontSize: 12,color: Colors.white)),),
                              ),
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    onPage=1; // reset the page regardless
                                    genre='35'; // Comedy id is 35
                                    getMovies(onPage, genre);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent),
                                  padding: const EdgeInsets.all(8),
                                  height: 36,
                                  child: Text('Comedy',style: GoogleFonts.robotoMono(fontSize: 12,color: Colors.white)),),
                              ),
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    onPage=1; // reset the page regardless
                                    genre='18'; // Drama id is 18
                                    getMovies(onPage, genre);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent),
                                  padding: const EdgeInsets.all(8),
                                  height: 36,
                                  child: Text('Drama',style: GoogleFonts.robotoMono(fontSize: 12,color: Colors.white)),),
                              ),
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    onPage=1; // reset the page regardless
                                    genre='14'; // Fantasy id is 14
                                    getMovies(onPage, genre);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent),
                                  padding: const EdgeInsets.all(8),
                                  height: 36,
                                  child: Text('Fantasy',style: GoogleFonts.robotoMono(fontSize: 12,color: Colors.white)),),
                              ),
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    onPage=1; // reset the page regardless
                                    genre='27'; // Horror id is 27
                                    getMovies(onPage, genre);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent),
                                  padding: const EdgeInsets.all(8),
                                  height: 36,
                                  child: Text('Horror',style: GoogleFonts.robotoMono(fontSize: 12,color: Colors.white)),),
                              ),
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    onPage=1; // reset the page regardless
                                    genre='9648'; // Mystery id is 9648
                                    getMovies(onPage, genre);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent),
                                  padding: const EdgeInsets.all(8),
                                  height: 36,
                                  child: Text('Mystery',style: GoogleFonts.robotoMono(fontSize: 12,color: Colors.white)),),
                              ),
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    onPage=1; // reset the page regardless
                                    genre='10749'; // Romance id is 10749
                                    getMovies(onPage, genre);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent),
                                  padding: const EdgeInsets.all(8),
                                  height: 36,
                                  child: Text('Romance',style: GoogleFonts.robotoMono(fontSize: 12,color: Colors.white)),),
                              ),
                            ],
                          ),
                        actions: [
                          TextButton(
                              onPressed: (){
                                setState(() {
                                  //set to default
                                  onPage=1;
                                  genre='';
                                  getMovies(onPage, genre);
                                });
                                Navigator.pop(context);
                              },
                            child: const Text('Set to default',style: TextStyle(color: Colors.white))),
                        ],
                        ),
                      );
                    }
                    ,icon: const Icon(Icons.filter_alt,size: 28,))
                ],
              ),
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
                                          releaseOn: listOfMovies[index]['release_date'],
                                          id: listOfMovies[index]['id'],
                                          popularity: listOfMovies[index]['popularity'],
                                          type: 'movie',
                                        ),),);
                              },
                             onDoubleTap: () {
                                ref.child('favorite/${listOfMovies[index]['id']}').update({
                                  'title':listOfMovies[index]['title'],
                                  'imageURL':'$tmdbImageUrl${listOfMovies[index]['poster_path']}'
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
                                      child: (listOfMovies[index]['poster_path']!=null)?
                                      Image.network(tmdbImageUrl + listOfMovies[index]['poster_path'],
                                        loadingBuilder: (context, child,
                                            loadingProgress) {
                                          if (loadingProgress != null) {
                                            return const Center(child: CircularProgressIndicator());
                                          }
                                          return child;
                                        },
                                      ):const Image(image: AssetImage('assets/no_image_poster.png'),),
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
                                          Text(listOfMovies[index]['vote_average'].toStringAsFixed(1),style: const TextStyle(fontSize: 11),)
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
                                    getMovies(onPage,genre);
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
                                  // checks first if current page is less than the total_pages of the API call
                                  if(onPage<result!['total_pages']){
                                    setState(() {
                                      onPage=onPage+1;
                                    });
                                    getMovies(onPage,genre);
                                  }
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
