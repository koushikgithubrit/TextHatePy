import 'package:flutter/material.dart';
import 'navbar.dart'; // Import your app bar
import 'bottomnavbar.dart'; // Import your bottom navigation bar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translate & Detect Hate Speech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userInput = '';
  String translatedText = '';
  String detectionResult = '';
  // Add variables to store graph data

  // Function to handle translation and hate speech detection
  void translateAndDetect() {
    // Call Google Translate API to translate userInput to English
    // Translate API call here

    // Pass translated text to the hate speech detection model
    // Model inference here

    // Update translatedText and detectionResult state variables
    setState(() {
      // Update translatedText and detectionResult based on API and model results
    });

    // Generate graph based on model results
    // Graph generation code here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(), // Use your custom app bar
      // appBar: AppBar(
      //   title: const Text('Hate Speech Detection'),
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Input bar
            TextField(
              onChanged: (value) {
                setState(() {
                  userInput = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter text...',
              ),
            ),
            // Check button
            ElevatedButton(
              onPressed: translateAndDetect,
              child: const Text('Check'),
            ),
            // Output bar
            Column(
              children: [
                Text('Translated Text: $translatedText'),
                Text('Detection Result: $detectionResult'),
                // Display graph here
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // Use your custom bottom nav bar
    );
  }
}


















































//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'navbar.dart'; // Import your app bar
// import 'bottomnavbar.dart'; // Import your bottom navigation bar
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Translate & Detect Hate Speech',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String userInput = '';
//   String translatedText = '';
//   String detectionResult = '';
//   // Add variables to store graph data
//
//   // Function to handle translation and hate speech detection
//   Future<void> translateAndDetect() async {
//     // Call Google Translate API to translate userInput to English
//     final String apiKey = 'YOUR_GOOGLE_TRANSLATE_API_KEY';
//     final String apiUrl =
//         'https://translation.googleapis.com/language/translate/v2?key=$apiKey&source=en&target=en&q=$userInput';
//
//     final response = await http.post(Uri.parse(apiUrl));
//     final decoded = json.decode(response.body);
//
//     setState(() {
//       translatedText = decoded['data']['translations'][0]['translatedText'];
//     });
//
//     // Pass translated text to the hate speech detection model
//     // Model inference here
//
//     // Update detectionResult state variables
//     setState(() {
//       // Update detectionResult based on model results
//     });
//
//     // Generate graph based on model results
//     // Graph generation code here
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: NavBar(), // Use your custom app bar
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Input bar
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   userInput = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Enter text...',
//               ),
//             ),
//             // Check button
//             ElevatedButton(
//               onPressed: translateAndDetect,
//               child: Text('Check'),
//             ),
//             // Output bar
//             Column(
//               children: [
//                 Text('Translated Text: $translatedText'),
//                 Text('Detection Result: $detectionResult'),
//                 // Display graph here
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(), // Use your custom bottom nav bar
//     );
//   }
// }
