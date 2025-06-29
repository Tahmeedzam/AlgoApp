import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:markdown_widget/config/all.dart';
import 'dart:convert';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import flutter_dotenv

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  // Controller for the text input field where the user types their message.
  final TextEditingController _textController = TextEditingController();
  // List to store all chat messages, including user queries and AI responses.
  final List<ChatMessage> _messages = [];
  // Flag to indicate if an API call is currently in progress.
  bool _isLoading = false;
  // Load the API key from .env file
  final String _geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  // Base URL for the Gemini API.
  static const String _geminiApiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  @override
  void dispose() {
    _textController
        .dispose(); // Dispose of the controller when the widget is removed
    super.dispose();
  }

  /// Sends the user's message to the Gemini API and updates the chat UI.
  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    // Do not send empty messages
    if (text.isEmpty) {
      return;
    }

    // Add user message to the chat list immediately
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _textController.clear(); // Clear the input field
      _isLoading = true; // Show loading indicator
    });

    try {
      List<Map<String, dynamic>> chatHistory = [];
      chatHistory.add({
        "role": "user",
        "parts": [
          {
            "text":
                "You are an AI assistant specialized in computer algorithms (e.g., Quick Sort, Bubble Sort, Dijkstra's, etc.). Please answer questions strictly related to algorithms and data structures. If a question is outside this scope, kindly state that you can only assist with algorithm-related queries.",
          },
        ],
      });

      chatHistory.add({
        "role": "user",
        "parts": [
          {"text": text.trim()},
        ],
      });

      // Construct the payload for the API request.
      final Map<String, dynamic> payload = {"contents": chatHistory};

      // Make the POST request to the Gemini API.
      final response = await http.post(
        Uri.parse('$_geminiApiUrl?key=$_geminiApiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        // Decode the JSON response.
        final jsonResponse = json.decode(response.body);

        // Extract the generated text from the API response.
        String aiResponseText = 'No response from AI.';
        if (jsonResponse['candidates'] != null &&
            jsonResponse['candidates'].isNotEmpty &&
            jsonResponse['candidates'][0]['content'] != null &&
            jsonResponse['candidates'][0]['content']['parts'] != null &&
            jsonResponse['candidates'][0]['content']['parts'].isNotEmpty) {
          aiResponseText =
              jsonResponse['candidates'][0]['content']['parts'][0]['text'] ??
              aiResponseText;
        }

        // Add the AI's response to the chat list.
        setState(() {
          _messages.add(ChatMessage(text: aiResponseText, isUser: false));
          _isLoading = false; // Hide loading indicator
        });
      } else {
        // Handle non-200 HTTP responses.
        setState(() {
          _messages.add(
            ChatMessage(
              text:
                  'Error: Failed to get response from AI. Status code: ${response.statusCode}',
              isUser: false,
            ),
          );
          _isLoading = false;
        });
        print('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions during the API call.
      setState(() {
        _messages.add(
          ChatMessage(
            text: 'Error: An unexpected error occurred: $e',
            isUser: false,
          ),
        );
        _isLoading = false;
      });
      print('Exception during API call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0D0D0D),
        appBar: AppBar(
          title: const Text(
            'AlgoBot',
            style: TextStyle(fontFamily: 'Poppins', color: Color(0xffE0E0E0)),
          ),
          backgroundColor: Color(0xff1A1A1A),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            // Expanded widget to ensure the chat messages take up available space.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4.0,
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.amber, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Note: Chats are not saved and will be lost when you leave this screen.',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                // Reverse the list to show the latest messages at the bottom.
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  // Display messages in reverse order.
                  final message = _messages[_messages.length - 1 - index];
                  return MessageBubble(
                    message: message.text,
                    isUser: message.isUser,
                  );
                },
              ),
            ),
            // Show a loading indicator when an API call is in progress.
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: LinearProgressIndicator(color: Color(0xffFFD300)),
              ),
            // Input area for the user to type messages.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  // Text input field.
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.grey[800]),
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Ask about an algorithm...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                      onSubmitted: (_) =>
                          _sendMessage(), // Send message on pressing enter
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  // Send button.
                  FloatingActionButton(
                    onPressed: _sendMessage,
                    backgroundColor: Color(0xffFFD300),
                    foregroundColor: Colors.white,
                    mini: true, // Make the button smaller
                    elevation: 0, // No shadow for a cleaner look
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A simple data class to represent a single chat message.
class ChatMessage {
  final String text;
  final bool isUser; // True if the message is from the user, false if from AI

  ChatMessage({required this.text, required this.isUser});
}

/// A custom widget to display a chat message bubble.
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const MessageBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    // Align messages based on whether they are from the user or the AI.
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: isUser ? Color.fromARGB(255, 233, 194, 0) : Color(0xff1A1A1A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isUser ? 15.0 : 0.0),
            topRight: Radius.circular(isUser ? 0.0 : 15.0),
            bottomLeft: const Radius.circular(15.0),
            bottomRight: const Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: MarkdownBlock(data: message, selectable: true),
      ),
    );
  }
}
