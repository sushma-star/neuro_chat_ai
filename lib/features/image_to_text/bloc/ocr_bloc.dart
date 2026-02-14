import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'ocr_event.dart';
import 'ocr_state.dart';
import '../../../core/network/api_service.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  final ApiService apiService;
  final ImagePicker picker = ImagePicker();

  OcrBloc(this.apiService) : super(const OcrState()) {
    on<PickImageEvent>((event, emit) async {
      final XFile? pickedFile =
      await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit(state.copyWith(imageFile: File(pickedFile.path)));
        add(ExtractTextEvent(File(pickedFile.path)));
      }
    });

    on<ExtractTextEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: '', extractedText: ''));

      try {
        final prompt = "Extract text from the following image (describe it): ${event.imageFile.path}";
        final response = await apiService.sendPrompt(prompt);

        emit(state.copyWith(extractedText: response, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: "Failed to extract text", isLoading: false));
      }
    });
  }
}
