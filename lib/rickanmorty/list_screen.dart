import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sklv/blocs/characters/characters.dart';
import 'package:sklv/components/character_card.dart';
import 'package:sklv/rickanmorty/character_screen.dart';
import 'package:sklv/blocs/character/character.dart';

class RickAndMortyScreen extends StatefulWidget {
  const RickAndMortyScreen({Key? key}) : super(key: key);

  @override
  _RickAndMortyScreenState createState() => _RickAndMortyScreenState();
}

class _RickAndMortyScreenState extends State<RickAndMortyScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.grey[100],
        navigationBar: CupertinoNavigationBar(
          middle: const Text(
            'RM',
            style: const TextStyle(fontFamily: 'Montserrat'),
          ),
          trailing: CupertinoButton(
              padding: const EdgeInsets.only(bottom: 2),
              onPressed: () async {
                showCupertinoModalPopup<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                        title: Text('Выбери фильтр'),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                              child: Text('Жив'),
                              onPressed: () {
                                Navigator.pop(context, 'alive');
                              }),
                          CupertinoActionSheetAction(
                            child: Text('Мёртв'),
                            onPressed: () {
                              Navigator.pop(context, 'dead');
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Text('Статус неизвестен'),
                            onPressed: () {
                              Navigator.pop(context, 'unknown');
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          isDefaultAction: true,
                          child: Text('Назад'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ));
                  },
                ).then((value) => context
                    .read<CharactersBloc>()
                    .add(SetCharactersFilter(filter: value)));
                // print('1');
              },
              child: const Icon(Icons.more_horiz)),
        ),
        child: SafeArea(child: BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
          return state.status == CharactersStatus.fetchingState &&
                  state.characters!.isEmpty
              ? const Center(child: CupertinoActivityIndicator())
              : ListView.builder(
                  itemCount: state.characters!.length + 1,
                  itemBuilder: (context, count) {
                    if (count < state.characters!.length) {
                      return CharacterCard(state.characters![count], () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BlocProvider<CharacterBloc>(
                              create: (context) => CharacterBloc()
                                ..add(FetchOneCharacter(
                                    id: state.characters![count].id)),
                              child:
                                  CharacterScreen(state.characters![count].id));
                        }));
                      });
                    } else {
                      if (state.status != CharactersStatus.fetchingState) {
                        context.read<CharactersBloc>().add(FetchCharacters());
                      }

                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  });
        })));
  }
}
