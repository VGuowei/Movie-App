import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/movie.dart';
import 'views/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          fontFamily: GoogleFonts.robotoFlex().fontFamily,
      ),
      home: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {


  int currentView=0;
  List<Widget> views= const [
       HomeView(),
       MovieView(),
       HomeView(),
       HomeView(),
  ];


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
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    icon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                  ),
                ),
              ),
              // leading: IconButton(
              //   icon: Icon(
              //     Icons.menu,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {},
              // ),
              // actions: [
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
      ),
    );
  }
}
