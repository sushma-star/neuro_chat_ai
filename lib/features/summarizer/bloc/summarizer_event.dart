import 'package:equatable/equatable.dart';

abstract class SummarizerEvent extends Equatable {
  const SummarizerEvent();

  @override
  List<Object?> get props => [];
}

class SummarizeTextEvent extends SummarizerEvent {
  final String text;

  const SummarizeTextEvent(this.text);

  @override
  List<Object?> get props => [text];
}
