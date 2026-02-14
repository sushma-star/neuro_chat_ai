import 'package:equatable/equatable.dart';

abstract class TranslatorEvent extends Equatable {
  const TranslatorEvent();

  @override
  List<Object?> get props => [];
}

class TranslateTextEvent extends TranslatorEvent {
  final String text;
  final String targetLanguage;

  const TranslateTextEvent({required this.text, required this.targetLanguage});

  @override
  List<Object?> get props => [text, targetLanguage];
}
