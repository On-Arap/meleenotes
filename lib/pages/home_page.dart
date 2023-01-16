import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'char_page.dart';
import 'package:localstorage/localstorage.dart';
import 'package:badges/badges.dart' as badge;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final LocalStorage storage = LocalStorage('melee_notes');

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  List<int> cntNotes = [];
  final chars = [
    'smash',
    'fox',
    'marth',
    'jigglypuff',
    'falco',
    'sheik',
    'falcon',
    'peach',
    'ice_climbers',
    'pikachu',
    'yoshi',
    'samus',
    'luigi',
    'dr_mario',
    'ganon',
    'mario',
    'donkey_kong',
    'young_link',
    'link',
    'game_and_watch',
    'mewtwo',
    'roy',
    'pichu',
    'ness',
    'zelda',
    'kirby',
    'bowser',
  ];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void loadNumberofNotes() async {
    cntNotes = [];
    setState(() {
      isLoading = true;
    });

    for (var i = 0; i < chars.length; i++) {
      QuerySnapshot querySnapshot = await firestore.collection('notes').where("char", isEqualTo: chars[i]).get();
      cntNotes.add(querySnapshot.docs.length);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNumberofNotes();
    super.initState();
  }

  Widget homePage() {
    return Column(
      children: [
        isLoading
            ? LinearProgressIndicator(
                backgroundColor: Colors.grey[600],
                color: Colors.grey[800],
                minHeight: 3,
              )
            : const SizedBox(height: 3),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1,
                        physics: const AlwaysScrollableScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        children: List.generate(
                          chars.length,
                          (index) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return CharPage(char: chars[index], local: storage);
                                  })).whenComplete(() => loadNumberofNotes());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: badge.Badge(
                                      position: badge.BadgePosition.bottomEnd(bottom: -10, end: -7),
                                      borderSide: const BorderSide(color: Colors.grey, width: 2),
                                      padding: const EdgeInsets.all(7),
                                      elevation: 1,
                                      alignment: AlignmentDirectional.bottomEnd,
                                      showBadge: cntNotes.length > index && cntNotes[index] > 0,
                                      badgeColor: Colors.grey.shade800,
                                      badgeContent: Text(
                                        (cntNotes.length > index && cntNotes[index] > 0) ? cntNotes[index].toString() : "0",
                                        style: const TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'lib/images/charsAnimelee/${chars[index]}.png',
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a character !'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: Colors.grey[500],
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1100) {
            return Center(
                child: SizedBox(
              width: constraints.maxWidth / 2,
              child: homePage(),
            ));
          } else {
            return homePage();
          }
        },
      ),
    );
  }
}
