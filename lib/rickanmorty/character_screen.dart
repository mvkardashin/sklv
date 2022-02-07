import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sklv/blocs/character/character.dart';
import 'package:transparent_image/transparent_image.dart';

class CharacterScreen extends StatefulWidget {
  final int id;
  const CharacterScreen(this.id, {Key? key}) : super(key: key);

  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<CharacterBloc>().add(FetchOneCharacter(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.grey[100],
        navigationBar: const CupertinoNavigationBar(
          middle: Text(
            'RM',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state) {
              if (state.selectedCharacter == null) {
                return const Center(child: CupertinoActivityIndicator());
              } else {
                return Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: state.selectedCharacter!.imageUrl,
                      ),
                      Text(
                        'Имя: ' + state.selectedCharacter!.name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.5),
                      ),
                      Text(
                        'Вид: ' + state.selectedCharacter!.species,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      Text('Статус: ' + state.selectedCharacter!.status,
                          style: const TextStyle(fontSize: 16, height: 1.5))
                    ]));
              }
            },
          ),
        ));
  }
}
