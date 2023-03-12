import 'package:flutter/material.dart';

class OnTv extends StatelessWidget {
  // Base URL for retrieving image
  final tmdbImageUrl = 'https://image.tmdb.org/t/p/w500';
  final List onTv;

  const OnTv({Key? key,required this.onTv}) : super(key: key);

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
                  'On Tv',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Container(
            height: 310,
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: onTv.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.fromLTRB(0, 4, 12, 0),
                    child: InkWell(
                      onTap: () {

                      },
                      child: SizedBox(
                        width: 165,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.network(
                                  tmdbImageUrl +
                                      onTv[index]
                                      ['poster_path'],
                                  loadingBuilder: (context,
                                      child, loadingProgress) {
                                    if (loadingProgress !=
                                        null) {
                                      return Center(
                                        child: Column(
                                          children: const [
                                            SizedBox(
                                              height: 90,
                                            ),
                                            CircularProgressIndicator(),
                                            SizedBox(
                                              height: 110,
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    return child;
                                  },
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
                                      Text(
                                        onTv[index]
                                        ['vote_average']
                                            .toStringAsFixed(1),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                                padding:
                                const EdgeInsets.all(10),
                                child: Text(
                                  onTv[index]
                                  ['name'],
                                  softWrap: true,
                                  maxLines: 2,
                                  )),
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
