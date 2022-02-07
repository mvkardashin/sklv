import 'package:flutter/material.dart';
import 'package:sklv/models/character.dart';
import 'package:transparent_image/transparent_image.dart';

class CharacterCard extends StatelessWidget {
  final VoidCallback onPress;
  final Character character;
  const CharacterCard(this.character, this.onPress, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: character.imageUrl,
                  )),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(character.imageUrl),
                            Text(
                              'Имя: ' + character.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5),
                            ),
                            Text(
                              'Вид: ' + character.species,
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            Text('Статус: ' + character.status,
                                style: TextStyle(fontSize: 16, height: 1.5))
                          ],
                        ),
                      ))
                ],
              ))),
    );
  }
}
