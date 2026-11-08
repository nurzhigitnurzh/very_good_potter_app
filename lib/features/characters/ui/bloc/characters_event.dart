import 'package:equatable/equatable.dart';

sealed class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object?> get props => [];
}

class GetCharactersEvent extends CharactersEvent {
  /// silent = true — не показывать полноэкранный лоадер (для pull-to-refresh)
  const GetCharactersEvent({this.silent = false});

  final bool silent;

  @override
  List<Object?> get props => [silent];
}