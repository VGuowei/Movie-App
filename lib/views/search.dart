import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SearchView extends StatefulWidget {
  // search keyword
  final String keyword;
  const SearchView({Key? key, required this.keyword}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  // Setting up for the TMDB API with my keys
  final tmdb = TMDB(
    ApiKeys('b5885260c7ceb67abd3e466068f303dc',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNTg4NTI2MGM3Y2ViNjdhYmQzZTQ2NjA2OGYzMDNkYyIsInN1YiI6IjYzOTlkNjJjNzdjMDFmMDBjYTVjOWViZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.'
            'Vi-Q2jc723p4jv2EStCaNIl4YxbyUCNtQvP8_WTn00A'),
  );
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';

  Map? result;
  List searchResult=[];

  multiSearch(String keyword) async{
    result= await tmdb.v3.search.queryMulti(keyword);
    setState(() {
      searchResult = result!['results'];
    });
    //print(result);
  }

  mediaType(String type, int i){

    switch(type){
      case 'movie':
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            Container(
              height: 150,
              width: 100,
              /// the if condition does not work in this case when the url poster_path is null, but it works for other created views
              child: ((tmdbImageUrl+searchResult[i]['poster_path'])!=null)?Image.network(tmdbImageUrl+searchResult[i]['poster_path'],):const Image(image:AssetImage('assets/no_image.jpg')),
            ),
            const SizedBox(width: 20,),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(searchResult[i]['title'],softWrap: true,maxLines: 2,style: const TextStyle(fontSize: 20),),
                  const SizedBox(height: 6,),
                  Text('Type: ${searchResult[i]['media_type']}',style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 16,),
                  Text('Release date: ${searchResult[i]['release_date']}',style: const TextStyle(fontSize: 16),),
                  const SizedBox(height: 12,),
                  Text('Rating: ${searchResult[i]['vote_average'].toStringAsFixed(2)} /10',style: const TextStyle(fontSize: 16),),
                  const SizedBox(height: 8,),
                ],),),
          ],),
        );

      //case 'tv':
        // return Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Row(children: [
        //     Container(
        //       height: 150,
        //       width: 100,
        //       child: (tmdbImageUrl+searchResult[i]['poster_path']!=null)?Image.network(tmdbImageUrl+searchResult[i]['poster_path']):const Image(image:AssetImage('assets/no_image.jpg')),
        //     ),
        //     const SizedBox(width: 20,),
        //     Flexible(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(searchResult[i]['name'],softWrap: true,maxLines: 2,style: const TextStyle(fontSize: 20),),
        //           const SizedBox(height: 6,),
        //           Text('Type: ${searchResult[i]['media_type']}',style: const TextStyle(fontSize: 14)),
        //           const SizedBox(height: 16,),
        //           Text('Release date: ${searchResult[i]['first_air_date']}',style: const TextStyle(fontSize: 16),),
        //           const SizedBox(height: 12,),
        //           Text('Rating: ${searchResult[i]['vote_average'].toStringAsFixed(2)} /10',style: const TextStyle(fontSize: 16),),
        //           const SizedBox(height: 8,),
        //         ],),),
        //   ],),
        // );
      default:
        // go to next index
        return Container();
    }
    //print(type);
  }

  @override
  void initState() {
    multiSearch(widget.keyword);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('" ${widget.keyword} "',style: GoogleFonts.actor(fontSize: 16),maxLines: 2),
      ),
      body: Padding(padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(child: Text('${searchResult.length} results'),),
          const SizedBox(height: 8,),
          Expanded(child: (searchResult.isNotEmpty)?ListView.builder(
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              return mediaType(searchResult[index]['media_type'],index);
            },
          ):
            Container(),),
        ],
      ),),
    );
  }
}