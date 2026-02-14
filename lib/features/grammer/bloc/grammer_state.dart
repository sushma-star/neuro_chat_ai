import 'package:equatable/equatable.dart';

class GrammarState extends Equatable {
  final String correctedText;
  final bool isLoading;
  final String error;

  const GrammarState({
    this.correctedText = '',
    this.isLoading = false,
    this.error = '',
  });

  GrammarState copyWith({
    String? correctedText,
    bool? isLoading,
    String? error,
  }) {
    return GrammarState(
      correctedText: correctedText ?? this.correctedText,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [correctedText, isLoading, error];
}
