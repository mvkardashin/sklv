import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sklv/models/character.dart';
import 'package:sklv/utils/api.dart';
import 'package:sklv/utils/api_exception.dart';

import '/blocs/characters/characters.dart';
import 'characters.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(CharactersState.init()) {
    on<FetchCharacters>(_onFetchCharacters);
    on<SetCharactersFilter>(_onSetCharactersFilter);
  }

  FutureOr<void> _onFetchCharacters(
      FetchCharacters event, Emitter<CharactersState> emit) async {
    if (state.nextPage != null) {
      try {
        emit(state.copyWith(status: CharactersStatus.fetchingState));
        String? responseBody = await Api.fetch(state.nextPage!);
        if (responseBody != null) {
          Map decodedJson = jsonDecode(responseBody);
          List results = decodedJson['results'];
          String? nextPage = decodedJson['info']['next'];
          List<Character> characters =
              results.map((e) => Character.fromMap(e)).toList();
          List<Character> newState = List.from(state.characters!);
          newState.addAll(characters);
          emit(state.copyWith(
              status: CharactersStatus.fetchedState,
              characters: newState,
              nextPage: nextPage));
        }
      } on ApiException catch (e) {
        emit(state.copyWith(error: e));
      }
    }
  }

  FutureOr<void> _onSetCharactersFilter(
      SetCharactersFilter event, Emitter<CharactersState> emit) {
    emit(state.copyWith(
        characters: [],
        nextPage:
            'https://rickandmortyapi.com/api/character/?page=1&status=${event.filter}'));
  }
}
