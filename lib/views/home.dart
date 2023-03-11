import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children:   [
          Container(
            color: Colors.green, height: 500, width: 500,

          ),
          Container(color: Colors.blue, height: 500, width: 500,),
          Container(color: Colors.yellow, height: 500, width: 500,),
        ],
      ),
    );
  }
}


