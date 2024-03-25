import 'package:flutter/material.dart';
// import 'CrystalNavigationBar.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Default theme
      darkTheme: ThemeData.dark(), // Dark theme
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
  // int _currentIndex = 0;
  //
  // void _onNavItemTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }
    //translate
  String inputText = '';
  String translatedText = '';
  bool isHateSpeech = false;
  double accuracy = 0.0; // You need to calculate accuracy from model predictions

  void translateAndCheck() {
    // Call translation API to translate inputText into English
    // Call hate speech detection model with translatedText
    // Update isHateSpeech and accuracy
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              '../lib/logo.png', // Replace 'assets/logo.png' with your logo asset path
              height: 40, // Adjust the height as needed
            ),
            const SizedBox(width: 30), // Add some spacing between logo and title
            const Text('Hate Speech Detection'),
          ],
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        // actions:  [
        //   // IconButton(
        //   //   icon:  Icon(Icons.lightbulb_outline),
        //   //   onPressed: () {
        //   //     // Toggle between light and dark mode
        //   //     Theme.of(context).brightness == Brightness.light
        //   //         ? Theme.of(context).brightness = Brightness.dark
        //   //         : Theme.of(context).brightness = Brightness.light;
        //   //   },
        //   // ),
        // ],
      ),

      body:  Stack(
        fit: StackFit.expand,
        children: [
        Image.asset(
        '../lib/body.png', // Replace 'assets/background_image.jpg' with your image asset path
        fit: BoxFit.cover,
      ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (text) {
                  inputText = text;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter a sentence...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: translateAndCheck,
                child: const Text('Check Hate Speech'),
              ),
              const SizedBox(height: 20),
              Text('Translated Text: $translatedText'),
              Text('Is Hate Speech: $isHateSpeech'),
              Text('Accuracy: ${accuracy.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ],
      ),

      // bottomNavigationBar: CrystalNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: _onNavItemTapped,
      //   items: [
      //     CrystalNavigationBarItem(icon: Icons.home, label: 'Home'),
      //     CrystalNavigationBarItem(icon: Icons.info, label: 'About'),
      //     CrystalNavigationBarItem(icon: Icons.contact_mail, label: 'Contact'),
      //   ],
      // ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'H O M E',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent_outlined),
            label: 'C O N T A C T',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'A B O U T',
          ),

        ],
      ),
    );
  }
}