import 'package:flutter/material.dart';
import '../views/details_person.dart';



class PopularActors extends StatelessWidget {
  const PopularActors({Key? key, required this.actors}) : super(key: key);
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  final List actors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Text(
                  'Popular Actors',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Container(
            height: 220,
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: actors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.fromLTRB(0, 4, 12, 0),
                    child: InkWell(
                      onTap: () {
                        //Show details
                        FocusManager.instance.primaryFocus?.unfocus();

                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            DetailsPerson(
                              name:actors[index]['name'],
                              profile:actors[index]['profile_path'],
                              popularity: actors[index]['popularity'].toString(),
                              played: actors[index]['known_for'],
                            ),),);
                      },
                      child: SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            Container(
                              child:  ClipRRect(borderRadius: BorderRadius.circular(30.0),
                              child: Image.network(
                                tmdbImageUrl +
                                    actors[index]
                                    ['profile_path'], fit: BoxFit.cover,
                                loadingBuilder: (context,
                                    child, loadingProgress) {
                                  if (loadingProgress !=
                                      null) {
                                    return Center(
                                      child: Column(
                                        children: const [
                                          SizedBox(
                                            height: 60,
                                          ),
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 50,
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  return child;
                                },
                              ),
                              ),
                            ),
                            Padding(
                                padding:
                                const EdgeInsets.all(10),
                                child: Text(
                                  actors[index]
                                  ['name'],
                                  softWrap: true,
                                  maxLines: 2,
                                style: const TextStyle(fontSize: 12),)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

