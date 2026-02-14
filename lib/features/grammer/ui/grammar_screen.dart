import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_service.dart';
import '../bloc/grammar_bloc.dart';
import '../bloc/grammer_event.dart';
import '../bloc/grammer_state.dart';

class GrammarScreen extends StatelessWidget {
  const GrammarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GrammarBloc(ApiService()),
      child: const GrammarView(),
    );
  }
}

class GrammarView extends StatefulWidget {
  const GrammarView({super.key});

  @override
  State<GrammarView> createState() => _GrammarViewState();
}

class _GrammarViewState extends State<GrammarView> {
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grammar Fix")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              decoration: const InputDecoration(
                  labelText: "Enter text to fix grammar",
                  border: OutlineInputBorder()),
              maxLines: 5,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (inputController.text.isNotEmpty) {
                  context
                      .read<GrammarBloc>()
                      .add(FixGrammarEvent(inputController.text));
                }
              },
              child: const Text("Fix Grammar"),
            ),
            const SizedBox(height: 20),
            BlocBuilder<GrammarBloc, GrammarState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                } else if (state.error.isNotEmpty) {
                  return Text(state.error, style: const TextStyle(color: Colors.red));
                } else if (state.correctedText.isNotEmpty) {
                  return Text(
                    state.correctedText,
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
