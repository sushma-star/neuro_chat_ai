import 'package:flutter_bloc/flutter_bloc.dart';
import 'translator_event.dart';
import 'translator_state.dart';
import '../../../core/network/api_service.dart';

class TranslatorBloc extends Bloc<TranslatorEvent, TranslatorState> {
  final ApiService apiService;

  TranslatorBloc(this.apiService) : super(const TranslatorState()) {
    on<TranslateTextEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: ''));

      try {
        final prompt =
            "Translate the following text to ${event.targetLanguage}: ${event.text}";
        final response = await apiService.sendPrompt(prompt);

        emit(state.copyWith(translatedText: response, isLoading: false));
      } catch (e) {
        emit(state.copyWith(
            error: 'Failed to translate', isLoading: false));
      }
    });
  }
}
