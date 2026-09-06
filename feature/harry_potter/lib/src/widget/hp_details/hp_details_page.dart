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
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Semantics(
                label: 'Biography of ${character.name}',
                child: Text(character.biography),
              ),
            )),
          ),
        ),
      );
}
