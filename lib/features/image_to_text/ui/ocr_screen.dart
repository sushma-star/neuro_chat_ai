import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_service.dart';
import '../bloc/ocr_bloc.dart';
import '../bloc/ocr_event.dart';
import '../bloc/ocr_state.dart';

class OcrScreen extends StatelessWidget {
  const OcrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OcrBloc(ApiService()),
      child: const OcrView(),
    );
  }
}

class OcrView extends StatelessWidget {
  const OcrView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image to Text")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<OcrBloc, OcrState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if (state.imageFile != null)
                      Image.file(state.imageFile!, height: 200),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<OcrBloc>().add(PickImageEvent());
                      },
                      child: const Text("Pick Image"),
                    ),
                    const SizedBox(height: 12),
                    if (state.isLoading)
                      const CircularProgressIndicator(),
                    if (state.error.isNotEmpty)
                      Text(state.error, style: const TextStyle(color: Colors.red)),
                    if (state.extractedText.isNotEmpty)
                      Text(
                        state!.extractedText,
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
