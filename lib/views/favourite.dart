import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  // Get a DatabaseReference
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Query query = FirebaseDatabase.instance.ref().child('favorite');
  // profile name
  String? username;
  final usernameController = TextEditingController();
  // get username from data base
  getUsername() {
    ref.child('username').onValue.listen((DatabaseEvent event) {
      final String data = event.snapshot.value.toString();
      updateUsername(data);
    });
  }
  // change user name
  updateUsername(String newName){
    setState(() {
      username=newName;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(
                  (username==null)?'Welcome':'Hello $username !',
                  style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) =>  AlertDialog(
                          title: const Text('Change user name',style: TextStyle(fontWeight: FontWeight.bold)),
                          content: TextField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                labelText: "Your name",
                              )
                          ),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  usernameController.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text('CANCEL',style: TextStyle(color: Colors.white))),
                            const SizedBox(width: 20),
                            TextButton(
                                onPressed: (){
                                  ref.update({'username':usernameController.text});
                                  usernameController.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text('APPLY',style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      );
                    }
                    ,icon: const Icon(Icons.person,size: 28,))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: FirebaseAnimatedList(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                query: query,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  Map favouriteMap = snapshot.value as Map;
                  favouriteMap['key'] = snapshot.key;
                  return SizedBox(
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,16),
                      child: Row(
                        children: [
                          Image.network(favouriteMap["imageURL"],errorBuilder: (context, error, stackTrace) => const SizedBox(width: 68,child: Icon(Icons.no_photography)),),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.56,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(26.0),
                                child: Text(favouriteMap["title"],style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.yellow,fontSize: 16),maxLines: 2),
                              ),
                            ],
                          ),),
                          IconButton(onPressed: (){
                              ref.child('favorite/${favouriteMap['key']}').remove();
                            },
                            icon: const Icon(Icons.remove_circle_outline,color: Colors.red,)),
                        ],

                        // horizontalTitleGap: 30,
                        // leading: Container(width: 60,color: Colors.red,),
                        // title: Text('${favouriteMap["title"]}',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.yellow),maxLines: 3,),
                        // trailing:  const Icon(Icons.favorite,color: Colors.red,),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
