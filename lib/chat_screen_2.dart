import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen2 extends StatefulWidget {
  @override
  _ChatScreen2State createState() => _ChatScreen2State();
}

class _ChatScreen2State extends State<ChatScreen2> {
  late FlutterTts flutterTts;
  late stt.SpeechToText speech;
  String botText = "안녕하세요.\n벌써 저녁시간이 되었네요.\n오늘 하루는 어떠셨나요?";
  String userText = "";
  bool initialized = false;
  bool botSpoken = false;
  final List<Map<String, String>> messages = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    speech = stt.SpeechToText();
    _initTts();
    _speak("안녕하세요. 벌써 저녁시간이 되었네요. 오늘 하루는 어떠셨나요");
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    initialized = true;
    _speak(botText);
  }

  Future<void> _speak(String text) async {
    if (!initialized) return;
    await flutterTts.speak(text);
    setState(() {
      messages.add({"text": text, "sender": "bot"});
    });
  }

  Future<void> _speakMessage(String message) async {
    await flutterTts.speak(message);
  }

  void _startListening() async {
    bool available = await speech.initialize();
    if (available) {
      speech.listen(
        onResult: (val) => setState(() {
          userText = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {
            speech.stop();
            _handleUserInput(userText);
          }
        }),
      );
    }
  }

  void _handleUserInput(String input) async {
    setState(() {
      userText = input;
      messages.add({"text": input, "sender": "user"});
    });

    if (!botSpoken) {
      botSpoken = true;
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        botText = "감사합니다!\n오늘도 좋은 하루 되세요!";
      });
      _speak(botText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오랜지'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(10.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue[200] : Colors.orange[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          message['text']!,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      if (!isUser)
                        IconButton(
                          icon: Icon(Icons.volume_up),
                          onPressed: () => _speakMessage(message['text']!),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onChanged: (value) {
                      userText = value;
                    },
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: _startListening,
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _handleUserInput(_textController.text);
                      _textController.clear();  // 입력 필드 초기화
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
