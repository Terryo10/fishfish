import 'package:flutter/material.dart';

import '../../models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${character.image}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${character.name}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Status: ${character.status}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Species: ${character.species}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
