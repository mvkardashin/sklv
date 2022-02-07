abstract class CharactersEvent {}

class FetchCharacters extends CharactersEvent {}

class SetCharactersFilter extends CharactersEvent {
  final String? filter;
  SetCharactersFilter({
    this.filter,
  });
}
