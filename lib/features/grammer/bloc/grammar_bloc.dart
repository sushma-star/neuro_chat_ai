import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_service.dart';
import 'grammer_event.dart';
import 'grammer_state.dart';


class GrammarBloc extends Bloc<GrammarEvent, GrammarState> {
  final ApiService apiService;

  GrammarBloc(this.apiService) : super(const GrammarState()) {
    on<FixGrammarEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: ''));

      try {
        final prompt =
            "Correct the grammar and spelling of the following text:\n${event.text}";
        final response = await apiService.sendPrompt(prompt);

        emit(state.copyWith(correctedText: response, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: "Failed to fix grammar", isLoading: false));
      }
    });
  }
}
