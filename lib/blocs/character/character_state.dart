import 'package:sklv/models/character.dart';
import 'package:sklv/utils/api_exception.dart';

class CharacterState {
  final Character? selectedCharacter;
  final ApiException? error;
  CharacterState({
    this.selectedCharacter,
    this.error,
  });
  CharacterState.init({this.selectedCharacter, this.error});
  CharacterState.fetched({this.selectedCharacter, this.error});

  CharacterState copyWith({Character? selectedCharacter, ApiException? error}) {
    return CharacterState(
        selectedCharacter: selectedCharacter ?? this.selectedCharacter,
        error: error ?? this.error);
  }

  CharacterState copyWithoutError() {
    return CharacterState(
        selectedCharacter: this.selectedCharacter, error: null);
  }

  // List<Object> get props => [this.status, this.orders,];
}
