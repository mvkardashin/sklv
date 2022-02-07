import 'package:sklv/models/character.dart';
import 'package:sklv/utils/api_exception.dart';

enum CharactersStatus {
  initState,
  fetchedState,
  fetchingState,
}

class CharactersState {
  final CharactersStatus status;
  final String? nextPage;
  final List<Character>? characters;
  final Character? selectedCharacter;
  final ApiException? error;
  CharactersState({
    required this.status,
    this.nextPage,
    this.characters,
    this.selectedCharacter,
    this.error,
  });
  CharactersState.init(
      {this.status = CharactersStatus.initState,
      this.characters = const [],
      this.selectedCharacter,
      this.nextPage = 'https://rickandmortyapi.com/api/character/?page=',
      this.error});
  CharactersState.fetched(
      {this.status = CharactersStatus.fetchedState,
      required this.characters,
      this.nextPage,
      this.selectedCharacter,
      this.error});

  CharactersState copyWith(
      {CharactersStatus? status,
      List<Character>? characters,
      String? nextPage,
      Character? selectedCharacter,
      ApiException? error}) {
    return CharactersState(
        characters: characters ?? this.characters,
        nextPage: nextPage ?? this.nextPage,
        status: status ?? this.status,
        selectedCharacter: selectedCharacter ?? this.selectedCharacter,
        error: error ?? this.error);
  }

  CharactersState copyWithoutError() {
    return CharactersState(
        characters: this.characters,
        status: this.status,
        nextPage: this.nextPage,
        selectedCharacter: this.selectedCharacter,
        error: null);
  }
}
