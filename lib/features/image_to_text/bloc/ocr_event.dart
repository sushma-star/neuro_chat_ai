import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class OcrEvent extends Equatable {
  const OcrEvent();

  @override
  List<Object?> get props => [];
}

class PickImageEvent extends OcrEvent {}

class ExtractTextEvent extends OcrEvent {
  final File imageFile;

  const ExtractTextEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}
