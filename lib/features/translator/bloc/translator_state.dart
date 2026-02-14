import 'package:equatable/equatable.dart';

class TranslatorState extends Equatable {
  final String translatedText;
  final bool isLoading;
  final String error;

  const TranslatorState({
    this.translatedText = '',
    this.isLoading = false,
    this.error = '',
  });

  TranslatorState copyWith({
    String? translatedText,
    bool? isLoading,
    String? error,
  }) {
    return TranslatorState(
      translatedText: translatedText ?? this.translatedText,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [translatedText, isLoading, error];
}
