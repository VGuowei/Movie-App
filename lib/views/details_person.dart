import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'details.dart';


class DetailsPerson extends StatelessWidget {
  final String name,profile,popularity;
  final List played;
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
                  SizedBox(height: 280,width: 180,child: Image.network(tmdbImageUrl+profile),),
                  Column(
                    children: [
                      Text(name,style: GoogleFonts.robotoMono(fontSize: 20,fontWeight: FontWeight.w500),maxLines: 3,),
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
                  childAspectRatio: 0.7,
                ),
                itemCount: played.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print(played.length);
                      //Show details
                      FocusManager.instance.primaryFocus?.unfocus();

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            Details(
                              title: played[index]['title'],
                              backdrop: (played[index]['backdrop_path'])==null?'null':played[index]['backdrop_path'],
                              overview: played[index]['overview'],
                              poster: played[index]['poster_path'],
                              rate: played[index]['vote_average'].toStringAsFixed(2),
                              releaseOn: played[index]['release_date'],)
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


