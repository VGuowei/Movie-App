import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatelessWidget {
  final String poster, backdrop, overview, title, rate, releaseOn;
  const Details(
      {super.key,
      required this.poster,
      required this.backdrop,
      required this.overview,
      required this.title,
      required this.rate,
      required this.releaseOn});

  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 230,
            child: Stack(
              children: [
                Positioned(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                       child: (backdrop!=null)?Image.network(
                    tmdbImageUrl + backdrop,
                    fit: BoxFit.cover,
                         loadingBuilder: (context, child, loadingProgress) {
                           if (loadingProgress !=
                               null) {
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
                  ): const Padding(
                    padding: EdgeInsets.all(12),
                    child: Image(image: AssetImage('assets/no_image.jpg')),
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
            ,child: Container(
                  height: 150,
                  width: 120,
                  child: (poster!=null)?Image.network(tmdbImageUrl + poster
                  ,loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress !=
                          null) {
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
                  ):const Image(image: AssetImage('assets/no_image.jpg')),
                ),),
              Flexible(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,softWrap: true,maxLines: 2,style: const TextStyle(fontSize: 24),),
                  const SizedBox(height: 16,),
                  (releaseOn!='null')?Text('Release date:  $releaseOn',style: const TextStyle(fontSize: 16),):const Text('No release date'),
                  const SizedBox(height: 12,),
                  Text('Rating:  $rate / 10',style: const TextStyle(fontSize: 16),),
                ],),),
          ],),
           Container(padding:  const EdgeInsets.fromLTRB(20, 10, 12, 0),child:  Text('Overview: ',style: GoogleFonts.robotoMono(fontSize: 20)),),
           Padding(padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),child: Text(overview,style: GoogleFonts.robotoMono(height: 1.5,fontSize: 17)),),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
