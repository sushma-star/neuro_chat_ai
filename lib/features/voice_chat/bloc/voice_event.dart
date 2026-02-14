import 'package:equatable/equatable.dart';

abstract class VoiceEvent extends Equatable {
  const VoiceEvent();

  @override
  List<Object?> get props => [];
}

class StartListeningEvent extends VoiceEvent {}

class StopListeningEvent extends VoiceEvent {}

class SendVoiceTextEvent extends VoiceEvent {
  final String text;

  const SendVoiceTextEvent(this.text);

  @override
  List<Object?> get props => [text];
}
