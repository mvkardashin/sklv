abstract class CharacterEvent {}

class FetchOneCharacter extends CharacterEvent {
  final int id;
  FetchOneCharacter({
    required this.id,
  });
}
