import 'package:equatable/equatable.dart';

class CodeState extends Equatable {
  final String generatedCode;
  final bool isLoading;
  final String error;

  const CodeState({
    this.generatedCode = '',
    this.isLoading = false,
    this.error = '',
  });

  CodeState copyWith({
    String? generatedCode,
    bool? isLoading,
    String? error,
  }) {
    return CodeState(
      generatedCode: generatedCode ?? this.generatedCode,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [generatedCode, isLoading, error];
}
