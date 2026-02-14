
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_service.dart';
import 'summarizer_event.dart';
import 'summarizer_state.dart';

class SummarizerBloc extends Bloc<SummarizerEvent, SummarizerState> {
  final ApiService apiService;

  SummarizerBloc(this.apiService) : super(const SummarizerState()) {
    on<SummarizeTextEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: ''));

      try {
        final prompt = "Summarize the following text in simple words:\n${event.text}";
        final response = await apiService.sendPrompt(prompt);

        emit(state.copyWith(summary: response, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: "Failed to summarize", isLoading: false));
      }
    });
  }
}
