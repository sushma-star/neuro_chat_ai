import 'package:flutter/material.dart';
import '../../../core/storage/local_storage.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await LocalStorage.getHistory();
    setState(() {
      history = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await LocalStorage.clearHistory();
              loadHistory();
            },
          ),
        ],
      ),
      body: history.isEmpty
          ? const Center(child: Text("No history found"))
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.history),
              title: Text(item['feature']),
              subtitle: Text(item['text']),
              trailing: Text(
                DateTime.parse(item['time']).toLocal().toString().split('.')[0],
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
