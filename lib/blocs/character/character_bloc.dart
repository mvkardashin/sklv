import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sklv/models/character.dart';
import 'package:sklv/utils/api.dart';
import 'package:sklv/utils/api_exception.dart';

import '/blocs/character/character.dart';
import 'character.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterState.init()) {
    on<FetchOneCharacter>(_onFetchOneCharacter);
  }

  FutureOr<void> _onFetchOneCharacter(
      FetchOneCharacter event, Emitter<CharacterState> emit) async {
    try {
      Character? character = await Api.fetchOne(event.id);
      if (character != null) {
        emit(state.copyWith(selectedCharacter: character));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
