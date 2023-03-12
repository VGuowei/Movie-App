import 'dart:math';

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
                       child: Image.network(
                    tmdbImageUrl + backdrop,
                    fit: BoxFit.cover,
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
            Padding(padding: EdgeInsets.fromLTRB(8, 0, 12, 12)
            ,child: Container(
                  height: 150,
                  child: Image.network(tmdbImageUrl + poster),
                ),),
              // const SizedBox(width: 24,),
              Flexible(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,softWrap: true,maxLines: 2,style: TextStyle(fontSize: 24),),
                  SizedBox(height: 16,),
                  Text('Release date:  $releaseOn',style: TextStyle(fontSize: 16),),
                  SizedBox(height: 12,),
                  Text('Rating:  $rate / 10',style: TextStyle(fontSize: 16),),
                ],),),
          ],),
           Container(padding:  const EdgeInsets.fromLTRB(10, 0, 12, 4),child: const Text('Overview: ',style: TextStyle(fontSize: 20)),),
           Padding(padding: const EdgeInsets.all(10),child: Text(overview,style: GoogleFonts.amiko(height: 1.5,fontSize: 18,wordSpacing: 1.5)),),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
