import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_service.dart';
import '../bloc/summarizer_bloc.dart';
import '../bloc/summarizer_event.dart';
import '../bloc/summarizer_state.dart';

class SummarizerScreen extends StatelessWidget {
  const SummarizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SummarizerBloc(ApiService()),
      child: const SummarizerView(),
    );
  }
}

class SummarizerView extends StatefulWidget {
  const SummarizerView({super.key});

  @override
  State<SummarizerView> createState() => _SummarizerViewState();
}

class _SummarizerViewState extends State<SummarizerView> {
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summarizer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              decoration: const InputDecoration(
                  labelText: "Enter text to summarize",
                  border: OutlineInputBorder()),
              maxLines: 5,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (inputController.text.isNotEmpty) {
                  context.read<SummarizerBloc>().add(
                    SummarizeTextEvent(inputController.text),
                  );
                }
              },
              child: const Text("Summarize"),
            ),
            const SizedBox(height: 20),
            BlocBuilder<SummarizerBloc, SummarizerState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                } else if (state.error.isNotEmpty) {
                  return Text(state.error, style: const TextStyle(color: Colors.red));
                } else if (state.summary.isNotEmpty) {
                  return Text(
                    state.summary,
                    style: const TextStyle(fontSize: 18),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
