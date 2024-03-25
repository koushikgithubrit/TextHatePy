import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart' show rootBundle;

void loadModel() async {
  final ByteData modelData = await rootBundle.load('assets/hate_speech_detection_model.tflite');
  // Process the model data
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hate Speech Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hate Speech Detection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _detectHateSpeech() async {
    String text = _textController.text;
    // Send text to backend for hate speech detection
    var response = await http.post(
      Uri.parse('your_backend_url_here'),
      body: {'text': text},
    );
    // Handle response
    if (response.statusCode == 200) {
      // Parse response and display result
      // Example: {"result": "Hate speech detected"}
      String result = response.body;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Hate Speech Detection Result'),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Handle error
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to detect hate speech. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _detectHateSpeech,
                child: Text('Detect Hate Speech'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
