import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Details extends StatelessWidget {
  final String? poster, backdrop, releaseOn; // nullables
  final String  overview, title, rate, type;
  final int id;
  final double popularity; // actor's popularity
  const Details(
      {super.key,
      required this.poster,
      required this.backdrop,
      required this.overview,
      required this.title,
      required this.rate,
      required this.releaseOn,
      required this.id,
      required this.popularity,
      required this.type,
      });
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 230,
            child: Stack(
              children: [
                Positioned(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      // check the backdrop is null or not
                       child: (backdrop!=null)?
                       Image.network(tmdbImageUrl + backdrop!,
                         fit: BoxFit.cover,
                         loadingBuilder: (context, child, loadingProgress) {
                           // show load indicator on loading
                           if (loadingProgress != null) {
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
                         // when backdrop is null
                      ): const Padding(
                        padding: EdgeInsets.all(12),
                        child: Image(image: AssetImage('assets/no_image_backdrop.jpg')),
                    ),
                )),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(24),
                          topRight: Radius.circular(24),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0))),
                  //color: Colors.black54,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
              ],
            ),
          ),
          Row(
            children: [
            Padding(padding: const EdgeInsets.fromLTRB(8, 8, 12, 12)
            ,child: SizedBox(
                  height: 160,
                  width: 120,
                // check the poster is null or not
                  child: (poster!=null)?
                  Image.network(tmdbImageUrl + poster!,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return Center(
                          child: SizedBox(
                            width: 120,
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 60,
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        );
                      }
                      return child;
                  },
                  ):const Image(image: AssetImage('assets/no_image_poster.png')),
                ),),
              Flexible(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,softWrap: true,maxLines: 2,style: const TextStyle(fontSize: 22),),
                  const SizedBox(height: 14,),
                  (releaseOn!='')?Text('Release date:  ${releaseOn??'-'}',style: const TextStyle(fontSize: 16),):const Text('No release date'),
                  const SizedBox(height: 10,),
                  (popularity!=-1)?Text('Popularity:  $popularity',style: const TextStyle(fontSize: 16),maxLines: 1):Container(),
                  const SizedBox(height: 10,),
                  Text('Rating:  $rate / 10',style: const TextStyle(fontSize: 16),),
                  const SizedBox(height: 10,),
                ],),),
          ],),
           GetGenres(id: id,type: type),
           Container(padding:  const EdgeInsets.fromLTRB(20, 10, 12, 0),child:  Text('Overview: ',style: GoogleFonts.robotoMono(fontSize: 20)),),
           Padding(padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),child: Text(overview,style: GoogleFonts.robotoMono(height: 1.5,fontSize: 17)),),
           const SizedBox(height: 20,),
        ],
      ),
    );
  }
}

// have to make another API call for details
class GetGenres extends StatefulWidget {
  final int id;
  final  String type;
  const GetGenres({Key? key, required this.id, required this.type}) : super(key: key);

  @override
  State<GetGenres> createState() => _GetGenresState();
}

class _GetGenresState extends State<GetGenres> {
  // Setting up for the TMDB API with my keys
  final tmdb = TMDB(
    ApiKeys('b5885260c7ceb67abd3e466068f303dc',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNTg4NTI2MGM3Y2ViNjdhYmQzZTQ2NjA2OGYzMDNkYyIsInN1YiI6IjYzOTlkNjJjNzdjMDFmMDBjYTVjOWViZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Vi-Q2jc723p4jv2EStCaNIl4YxbyUCNtQvP8_WTn00A'),
    logConfig: const ConfigLogger.showNone(),
  );

  Map? result;
  List listOfGenres =[];

  getGenres(int id, String type) async {
    if(type=='movie'){
      result = await tmdb.v3.movies.getDetails(id);
    }
    else if(type=='tv'){
      result = await tmdb.v3.tv.getDetails(id);
    }

    setState(() {
      listOfGenres = result!['genres'];
    });
  }

  @override
  void initState() {
    getGenres(widget.id,widget.type);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (listOfGenres.isNotEmpty)?
    Container(
      padding: const EdgeInsets.fromLTRB(8,0,8,0),
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listOfGenres.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5,8,5,8),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.indigoAccent,),
                padding: const EdgeInsets.all(12),
                height: 34,
                child: Text(listOfGenres[index]['name'],style: GoogleFonts.robotoMono(fontSize: 14)),),
            );
          },
      ),
    ):const Padding(
      padding: EdgeInsets.all(20.0),
      child: Text('Loading ...',style: TextStyle(fontSize: 17)),
    );
  }
}