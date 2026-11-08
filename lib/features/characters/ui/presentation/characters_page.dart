import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/characters/ui/presentation/widgets/character_card.dart';

import '../../../../core/di/injection.dart';
import '../bloc/characters_bloc.dart';
import '../bloc/characters_event.dart';
import '../bloc/characters_state.dart';
import 'character_details_page.dart';
import 'house_style.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CharactersBloc>()..add(const GetCharactersEvent()),
      child: const _CharactersView(),
    );
  }
}

class _CharactersView extends StatefulWidget {
  const _CharactersView();

  @override
  State<_CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<_CharactersView> {
  static const _houses = ['All', 'Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff'];

  String _selected = 'All';

  Future<void> _refresh() async {
    final bloc = context.read<CharactersBloc>();
    bloc.add(const GetCharactersEvent(silent: true));
    await bloc.stream.firstWhere((s) => s is! CharactersLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text(
                'Wizarding World',
                style: TextStyle(
                  color: kGold,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Characters of Harry Potter',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _houses.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final house = _houses[i];
                  final selected = house == _selected;
                  final color = house == 'All' ? kGold : houseColor(house);
                  return ChoiceChip(
                    label: Text(house),
                    selected: selected,
                    showCheckmark: false,
                    onSelected: (_) => setState(() => _selected = house),
                    backgroundColor: kSurface,
                    selectedColor: color,
                    side: BorderSide(color: color.withValues(alpha: 0.6)),
                    labelStyle: TextStyle(
                      color: selected
                          ? (house == 'All' || house == 'Hufflepuff'
                          ? Colors.black
                          : Colors.white)
                          : Colors.white70,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CharactersBloc, CharactersState>(
                builder: (context, state) {
                  return switch (state) {
                    CharactersInitial() || CharactersLoading() => const Center(
                      child: CircularProgressIndicator(color: kGold),
                    ),
                    CharactersError(:final message) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline,
                                color: Colors.white54, size: 48),
                            const SizedBox(height: 12),
                            Text(
                              message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<CharactersBloc>()
                                  .add(const GetCharactersEvent()),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CharactersLoaded(:final characters) => _buildGrid(
                      _selected == 'All'
                          ? characters
                          : characters
                          .where((c) => c.house == _selected)
                          .toList(),
                    ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(List characters) {
    if (characters.isEmpty) {
      return const Center(
        child: Text('Nobody here', style: TextStyle(color: Colors.white54)),
      );
    }

    return RefreshIndicator(
      color: kGold,
      backgroundColor: kSurface,
      onRefresh: _refresh,
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        itemCount: characters.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final character = characters[index];
          return CharacterCard(
            character: character,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CharacterDetailsPage(character: character),
              ),
            ),
          );
        },
      ),
    );
  }
}