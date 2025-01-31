import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:question_3/static/app_strings.dart';

import '../models/character_model.dart';
import '../state/blocs/character_bloc/character_bloc.dart';
import '../state/cubits/theme_cubit.dart';
import 'widgets/character_card.dart';
import 'widgets/character_details_modal.dart';

@RoutePage()
class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  CharacterListPageState createState() => CharacterListPageState();
}

class CharacterListPageState extends State<CharacterListPage> {
  final PagingController<int, CharacterModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey == 1) {
        context.read<CharacterBloc>().add(LoadCharacters());
      } else {
        context.read<CharacterBloc>().add(LoadMoreCharacters());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.rickAndMortyCharacters),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeCubit>().state == AppThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: BlocConsumer<CharacterBloc, CharacterState>(
        listener: (context, state) {
          if (state is CharactersLoaded) {
            final isLastPage = state.hasReachedMax;
            if (isLastPage) {
              _pagingController.appendLastPage(state.characters);
            } else {
              _pagingController.appendPage(
                state.characters,
                state.currentPage + 1,
              );
            }
          }
          if (state is CharacterError) {
            _pagingController.error = state.message;
          }
        },
        builder: (context, state) {
          return PagedListView<int, CharacterModel>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<CharacterModel>(
              itemBuilder: (context, character, index) => CharacterCard(
                character: character,
                onTap: () {
                  _showCharacterDetails(context, character);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCharacterDetails(BuildContext context, CharacterModel character) {
    CharacterDetailsModal.show(context, character);
  }
}
