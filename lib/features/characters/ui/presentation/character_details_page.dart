import 'package:flutter/material.dart';
import 'package:untitled/features/characters/ui/presentation/widgets/character_image.dart';
import '../../domain/entity/character_entity.dart';
import 'house_style.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key, required this.character});

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    final color = houseColor(character.house);

    return Scaffold(
      backgroundColor: kBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 420,
            backgroundColor: color,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [color, kBackground],
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'character_${character.index}',
                    child: CharacterImage(url: character.image),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, kBackground],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.fullName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(houseIcon(character.house),
                            size: 16, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          character.house,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _InfoTile(
                    icon: Icons.badge_outlined,
                    label: 'Nickname',
                    value: character.nickname.isEmpty ? '—' : character.nickname,
                  ),
                  _InfoTile(
                    icon: Icons.cake_outlined,
                    label: 'Birthdate',
                    value: character.birthdate,
                  ),
                  _InfoTile(
                    icon: Icons.theaters_outlined,
                    label: 'Played by',
                    value: character.actor,
                  ),
                  if (character.children.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Children',
                      style: TextStyle(
                        color: kGold,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: character.children
                          .map(
                            (name) => Chip(
                          label: Text(name),
                          backgroundColor: kSurface,
                          side: BorderSide(
                            color: kGold.withValues(alpha: 0.4),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: kGold, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}