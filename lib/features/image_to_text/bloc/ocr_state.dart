import 'package:equatable/equatable.dart';
import 'dart:io';

class OcrState extends Equatable {
  final File? imageFile;
  final String extractedText;
  final bool isLoading;
  final String error;

  const OcrState({
    this.imageFile,
    this.extractedText = '',
    this.isLoading = false,
    this.error = '',
  });

  OcrState copyWith({
    File? imageFile,
    String? extractedText,
    bool? isLoading,
    String? error,
  }) {
    return OcrState(
      imageFile: imageFile ?? this.imageFile,
      extractedText: extractedText ?? this.extractedText,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [imageFile ?? '', extractedText, isLoading, error];
}
