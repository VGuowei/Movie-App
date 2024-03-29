import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'details_movie&tv.dart';


class DetailsPerson extends StatelessWidget {
  final String? profile;
  final String name,popularity;
  final List played; // the actor's known_for list https://developers.themoviedb.org/3/people/get-popular-people
  const DetailsPerson({Key? key, required this.name, required this.profile, required this.popularity, required this.played}) : super(key: key);
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/original';

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,18,0,16),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children:<Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // check the backdrop is null or not
                  (profile!=null)?
                  SizedBox(height: 280,width: 180,child: Image.network(tmdbImageUrl+profile!,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return Center(
                          child: SizedBox(
                            width: 369,
                            child: Column(
                              children: const [
                                SizedBox(height: 90,),
                                CircularProgressIndicator(),
                                SizedBox(height: 80,)
                              ],
                            ),
                          ),
                        );
                      }
                      return child;
                  },
                  ),):
                  const SizedBox(
                    height: 280,
                    child: Image(image: AssetImage('assets/no_image_poster.png')),),
                  Column(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(name,style: GoogleFonts.openSans(fontSize: 20,fontWeight: FontWeight.w500),maxLines: 3,),),
                      const SizedBox(height: 50,),
                      Container(
                        height: 80,
                        width: 146,
                        decoration: BoxDecoration(border: Border.all(color: Colors.deepPurple,width: 1)),
                        child: Column(children: [
                          Container(height: 33,width: 146,color: Colors.deepPurple,child:  Center(child: Text('Popularity',style: GoogleFonts.robotoMono(fontSize: 14,fontWeight: FontWeight.w400),),),),
                          const SizedBox(height: 6,),
                          SizedBox(height: 33,width: 146,child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.star,color: Colors.yellow,),
                              Text(popularity,style: GoogleFonts.robotoMono(fontSize: 14,fontWeight: FontWeight.w400))
                            ]
                            ,),),
                        ],),
                      )
                    ],)
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24,10,18,24),
                child: Text('Appears in:',style: GoogleFonts.robotoMono(fontSize: 26),),),
              GridView.builder(
                addAutomaticKeepAlives: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 0.73,
                ),
                itemCount: played.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //Show details
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                        (played[index]['media_type']=='movie')
                            ?Details( // media type is movie
                          poster: played[index]['poster_path'],
                          backdrop: played[index]['backdrop_path'],
                          title: played[index]['title'],
                          overview: played[index]['overview'],
                          rate: played[index]['vote_average'].toStringAsFixed(2),
                          releaseOn: played[index]['release_date'],
                          id: played[index]['id'],
                          popularity: -1.0, // in the known_for array the popularity doesn't exist
                          type: 'movie',
                        )
                            :Details( // media type is tv show
                          poster: played[index]['poster_path'],
                          backdrop: played[index]['backdrop_path'],
                          title: played[index]['name'],
                          overview: played[index]['overview'],
                          rate: played[index]['vote_average'].toStringAsFixed(2),
                          releaseOn: played[index]['first_air_date'],
                          id: played[index]['id'],
                          popularity: -1.0, // in the known_for array the popularity doesn't exist
                          type: 'tv',
                        )
                        ,),);
                    },
                    child: Center(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          SizedBox(
                            height: 210,
                            width: 117,
                            child: Image.network(tmdbImageUrl + played[index]['poster_path'],
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
                            width: 48,
                            color: Colors.black54,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.yellow,
                                ),
                                Text(played[index]['vote_average'].toStringAsFixed(1))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


