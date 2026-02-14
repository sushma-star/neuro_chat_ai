import 'package:flutter/material.dart';
import '../core/constants/api+constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const MessageBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? AppColors.userBubble : AppColors.aiBubble,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUser ? AppColors.textDark : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
