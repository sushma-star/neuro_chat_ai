import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/message_model.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import '../../../core/network/api_service.dart';
import '../../../core/storage/local_storage.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ApiService apiService;

  ChatBloc(this.apiService) : super(const ChatState()) {
    on<SendMessageEvent>((event, emit) async {
      // Add user message first
      final updatedMessages = List<ChatMessage>.from(state.messages)
        ..add(ChatMessage(text: event.message, isUser: true));

      emit(state.copyWith(messages: updatedMessages, isLoading: true));

      try {
        // Call GPT API
        final response = await apiService.sendPrompt(event.message);

        // Add AI response
        final updated = List<ChatMessage>.from(updatedMessages)
          ..add(ChatMessage(text: response, isUser: false));

        // Save messages locally
        await LocalStorage.saveMessage(event.message);
        await LocalStorage.saveMessage(response);

        emit(state.copyWith(messages: updated, isLoading: false));
      } catch (e) {
        print('Error in ChatBloc: $e');
        emit(state.copyWith(isLoading: false));
      }
    });
  }
}
