import 'package:equatable/equatable.dart';

abstract class GrammarEvent extends Equatable {
  const GrammarEvent();

  @override
  List<Object?> get props => [];
}

class FixGrammarEvent extends GrammarEvent {
  final String text;

  const FixGrammarEvent(this.text);

  @override
  List<Object?> get props => [text];
}
