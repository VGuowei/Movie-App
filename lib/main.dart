import 'dart:io';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shake/shake.dart';
import 'views/favourite.dart';
import 'views/search.dart';
import 'views/tv.dart';
import 'views/movie.dart';
import 'views/home.dart';

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Set persistence data
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  // Set colors for the system UI overlay
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent,systemNavigationBarColor: kDefaultIconDarkColor ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      disconnectedText: 'No Internet Connection',
      hasIndicationIcon: false,
        height: 50,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.grey,
            fontFamily: GoogleFonts.robotoFlex().fontFamily,
          ),
          home: const MainView(),
      ),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // search keyword variable
  final searchController=TextEditingController();
  // widgets to swap in the body of Scaffold
  int currentView=0;
  List<Widget> views= const [
       HomeView(), // 0
       MovieView(), // 1
       TVShows(), // 2
       FavoriteView(), //3
  ];
  // declare sensor detector
  late ShakeDetector detector;
  // this function it's for android platform only
  exitOnShake(){
    setState(() {
      if(Platform.isAndroid){
        SystemNavigator.pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Start shake detector
    detector=ShakeDetector.autoStart(
    onPhoneShake: () {
    // Close app on phone shake
      exitOnShake();
    },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.0,
    );
  }

  @override
  void dispose() {
    // End shake detector
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              toolbarHeight: 55,
              title: SizedBox(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Search for Movie, TV show or Actor",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search)
                  ),
                  onSubmitted: (value){
                    // when search value is not empty, navigate to search view
                    if (value.isNotEmpty){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView(keyword: value,) ,),);
                      searchController.clear();
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
            ),
          ],
          body: views[currentView],
        ),
        bottomNavigationBar: NavigationBar(
          height: 64,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.movie), label: "Movie"),
            NavigationDestination(icon: Icon(Icons.live_tv), label: "Tv"),
            NavigationDestination(icon: Icon(Icons.favorite), label: "Favourite"),
          ],
          onDestinationSelected: (int index){
            setState(() {
              // Update the UI
              currentView = index;
            });
          },
          // Highlight the current view
          selectedIndex: currentView,
        ),
      ),
    );
  }
}
