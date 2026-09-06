import 'package:flutter/material.dart';
import 'package:harry_potter/src/domain/model/character.dart';

class HpDetailsPage extends StatelessWidget {
  const HpDetailsPage({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Semantics(
            header: true,
            child: Text(character.name),
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF1E1E1E)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white24,
                      child: Text(
                        character.name[0],
                        style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Semantics(
                    label: 'Biography of ${character.name}',
                    child: Text(
                      character.biography,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        letterSpacing: 0.5,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      );
}
