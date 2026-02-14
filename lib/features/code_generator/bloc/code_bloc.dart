import 'package:flutter_bloc/flutter_bloc.dart';
import 'code_event.dart';
import 'code_state.dart';
import '../../../core/network/api_service.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {
  final ApiService apiService;

  CodeBloc(this.apiService) : super(const CodeState()) {
    on<GenerateCodeEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: ''));

      try {
        final prompt =
            "Write code in ${event.language} for the following requirement:\n${event.prompt}";
        final response = await apiService.sendPrompt(prompt);

        emit(state.copyWith(generatedCode: response, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: "Failed to generate code", isLoading: false));
      }
    });
  }
}
