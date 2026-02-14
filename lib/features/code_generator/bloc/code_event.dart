import 'package:equatable/equatable.dart';

abstract class CodeEvent extends Equatable {
  const CodeEvent();

  @override
  List<Object?> get props => [];
}

class GenerateCodeEvent extends CodeEvent {
  final String prompt;
  final String language;

  const GenerateCodeEvent({required this.prompt, required this.language});

  @override
  List<Object?> get props => [prompt, language];
}
