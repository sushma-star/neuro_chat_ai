import 'package:equatable/equatable.dart';

class SummarizerState extends Equatable {
  final String summary;
  final bool isLoading;
  final String error;

  const SummarizerState({
    this.summary = '',
    this.isLoading = false,
    this.error = '',
  });

  SummarizerState copyWith({
    String? summary,
    bool? isLoading,
    String? error,
  }) {
    return SummarizerState(
      summary: summary ?? this.summary,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [summary, isLoading, error];
}
