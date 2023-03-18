import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../views/details_person.dart';



class PopularActors extends StatelessWidget {
  PopularActors({Key? key, required this.actors}) : super(key: key);
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  final List actors;
  // Get a DatabaseReference
  DatabaseReference ref = FirebaseDatabase.instance.ref();

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
          SizedBox(
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
                      onDoubleTap: () {
                        ref.child('favorite/${actors[index]['id']}').update({
                          'title':actors[index]['name'],
                          'imageURL':'$tmdbImageUrl${actors[index]['profile_path']}'
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
                      child: SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child:
                              SizedBox(
                                height: 150,
                                  child: Image.network(tmdbImageUrl + actors[index]['profile_path'],
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress != null) {
                                    return Center(
                                      child: Column(
                                        children: const [
                                          SizedBox(
                                            height: 60,
                                          ),
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    );
                                  }
                                  return child;
                                },
                              ),),
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

