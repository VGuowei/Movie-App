import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_maniac/main.dart';
import 'package:movie_maniac/views/favourite.dart';
import 'package:movie_maniac/views/home.dart';
import 'package:movie_maniac/views/movie.dart';
import 'package:movie_maniac/views/tv.dart';

void main() {
  /// TEST is under development, not working and no enough time. tried calling firebase initiate in init state but it can't find anything in general,
  testWidgets('Switches views on bottom navigation bar tap', (tester) async {
     await tester.pumpWidget(const MyApp());

     // Verify that the default View is HomeView
     expect(find.byType(HomeView), findsOneWidget);
     expect(find.byType(MovieView), findsNothing);
     expect(find.byType(TVShows), findsNothing);
     expect(find.byType(FavoriteView), findsNothing);

     // When Movie is selected
     await tester.tap(find.byKey(const Key('MovieDestination')));
     await tester.pump();
     // Verify that the current view is MovieView
     expect(find.byType(MovieView), findsOneWidget);

     // When Tv is selected
     await tester.tap(find.byKey(const Key('TVDestination')));
     await tester.pump();
     // Verify that the current view is TVShows
     expect(find.byType(TVShows), findsOneWidget);

     // When Favourite is selected
     await tester.tap(find.byKey(const Key('FavoriteDestination')));
     await tester.pump();
     // Verify that the current view is FavouriteView
     expect(find.byType(FavoriteView), findsOneWidget);

  });
}
