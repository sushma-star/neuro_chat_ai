import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'voice_event.dart';
import 'voice_state.dart';
import '../../../core/network/api_service.dart';

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  final ApiService apiService;
  final stt.SpeechToText _speech = stt.SpeechToText();

  VoiceBloc(this.apiService) : super(const VoiceState()) {
    on<StartListeningEvent>((event, emit) async {
      bool available = await _speech.initialize();
      if (available) {
        emit(state.copyWith(isListening: true, recognizedText: ''));
        _speech.listen(onResult: (result) {
          emit(state.copyWith(recognizedText: result.recognizedWords));
        });
      } else {
        emit(state.copyWith(error: "Speech not available"));
      }
    });

    on<StopListeningEvent>((event, emit) async {
      await _speech.stop();
      emit(state.copyWith(isListening: false));
    });

    on<SendVoiceTextEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: '', aiResponse: ''));
      try {
        final prompt = "Respond to this input: ${event.text}";
        final response = await apiService.sendPrompt(prompt);
        emit(state.copyWith(aiResponse: response, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: "Failed to get AI response", isLoading: false));
      }
    });
  }
}
