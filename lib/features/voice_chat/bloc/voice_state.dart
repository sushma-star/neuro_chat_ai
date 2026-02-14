import 'package:equatable/equatable.dart';

class VoiceState extends Equatable {
  final String recognizedText;
  final String aiResponse;
  final bool isListening;
  final bool isLoading;
  final String error;

  const VoiceState({
    this.recognizedText = '',
    this.aiResponse = '',
    this.isListening = false,
    this.isLoading = false,
    this.error = '',
  });

  VoiceState copyWith({
    String? recognizedText,
    String? aiResponse,
    bool? isListening,
    bool? isLoading,
    String? error,
  }) {
    return VoiceState(
      recognizedText: recognizedText ?? this.recognizedText,
      aiResponse: aiResponse ?? this.aiResponse,
      isListening: isListening ?? this.isListening,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [recognizedText, aiResponse, isListening, isLoading, error];
}
