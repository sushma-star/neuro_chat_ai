String buildPrompt(String feature, String text) {
  switch (feature) {
    case "Translator":
      return "Translate this text: $text";

    case "Summarizer":
      return "Summarize this text: $text";

    case "Code Generator":
      return "Generate code for: $text";

    case "Grammar Fix":
      return "Correct grammar: $text";

    case "Image to Text":
      return "Extract text from this image: $text";

    case "Voice Chat":
      return text;

    default:
      return text; // Chat with AI
  }
}
