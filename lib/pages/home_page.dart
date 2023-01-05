import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'char_page.dart';
import 'package:localstorage/localstorage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  final LocalStorage storage = LocalStorage('melee_notes');
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
      body: Padding(
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return CharPage(char: chars[index], local: storage);
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                'lib/images/charsAnimelee/${chars[index]}.png',
                                fit: BoxFit.fitWidth,
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
    );
  }
}
