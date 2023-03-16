import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_maniac/views/search.dart';
import 'package:movie_maniac/views/tv.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shake/shake.dart';
import 'views/movie.dart';
import 'views/home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent,systemNavigationBarColor: kDefaultIconDarkColor ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.grey,
            primaryColor: Colors.blue,
            fontFamily: GoogleFonts.robotoFlex().fontFamily,
          ),
          home: const MainView(),
    ));
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // variable that store the internet connection status
  bool hasInternet=false;
  // search keyword
  final searchController=TextEditingController();
  // widgets to swap in the body of Scaffold
  int currentView=0;
  List<Widget> views= const [
       HomeView(),
       MovieView(),
       TVShows(),
       HomeView(),
  ];
  // declare sensor detector
  late ShakeDetector detector;
  // this function it's for android platform
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
    InternetConnectionChecker().onStatusChange.listen((status){
      final hasInternet=status==InternetConnectionStatus.connected;
      setState(()=>this.hasInternet=hasInternet);
    });
    detector=ShakeDetector.autoStart(
    onPhoneShake: () {
    // Do stuff on phone shake
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
              // actions:  [
              //   IconButton(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              //     icon: const Icon(
              //       Icons.menu,
              //     ),
              //     onPressed: () {
              //     //TODO add setting menu
              //
              //     },
              //   ),
              // ],
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
            NavigationDestination(icon: Icon(Icons.favorite), label: "Favorite"),
          ],
          onDestinationSelected: (int index){
            setState(() {
              currentView = index;
            });
          },
          selectedIndex: currentView,
        ),
        endDrawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24,48,24,24),
            child: Column(
              children: [
                Text('Movie Maniac',style: GoogleFonts.aBeeZee(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.redAccent)),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Status: ',style: GoogleFonts.robotoMono(fontSize: 16)),
                  hasInternet?Text('Online',style: GoogleFonts.robotoMono(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.green))
                      :Text('Offline',style: GoogleFonts.robotoMono(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey)),
                ],),
                const Divider(color: Colors.yellow,thickness: 1,height: 40,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
