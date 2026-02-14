import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_service.dart';
import '../bloc/voice_bloc.dart';
import '../bloc/voice_event.dart';
import '../bloc/voice_state.dart';

class VoiceScreen extends StatelessWidget {
  const VoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VoiceBloc(ApiService()),
      child: const VoiceView(),
    );
  }
}

class VoiceView extends StatelessWidget {
  const VoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Chat")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<VoiceBloc, VoiceState>(
              builder: (context, state) {
                return Column(
                  children: [
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Recognized Text",
                        border: const OutlineInputBorder(),
                        hintText: state.recognizedText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<VoiceBloc>().add(StartListeningEvent());
                          },
                          child: const Text("Start Listening"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<VoiceBloc>().add(StopListeningEvent());
                          },
                          child: const Text("Stop Listening"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (state.recognizedText.isNotEmpty) {
                              context
                                  .read<VoiceBloc>()
                                  .add(SendVoiceTextEvent(state.recognizedText));
                            }
                          },
                          child: const Text("Send to AI"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (state.isLoading)
                      const CircularProgressIndicator(),
                    if (state.error.isNotEmpty)
                      Text(state.error, style: const TextStyle(color: Colors.red)),
                    if (state.aiResponse.isNotEmpty)
                      Text(
                        state.aiResponse,
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
