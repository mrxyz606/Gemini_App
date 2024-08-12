import 'package:flutter/material.dart';

// The main entry point of the app
//
// // Main Application widget
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Define initial route
//       initialRoute: '/',
//       routes: {
//         // Define routes for each page
//         '/': (context) => MyPage(),
//         '/page2': (context) => Page2(),
//         // '/page3': (context) => Page3(), // Remove route for Page3
//       },
//     );
//   }
// }

// First page widget
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for Current Location and CircleAvatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Side: Current Location Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Location',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Current Location',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // Right Side: CircleAvatar
                CircleAvatar(
                  radius: 30, // Radius of the circle
                  backgroundImage: AssetImage('images/car.jpeg'), // Path to your image asset
                ),
              ],
            ),
            SizedBox(height: 16),
            // Spacer to push the button section to the center
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Learn More of Environment pressed');
                      },
                      child: Text('Learn More of Environment'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/page2'); // Navigate to Page2
                      },
                      child: Text('Begin Your New Life'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        print('Challenges pressed');
                      },
                      child: Text('Challenges'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Second page widget
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LinearLayout for Text and EditText, positioned above the Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Text Row
                Row(
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Environment Quiz',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow, // Adjust color as needed
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Let’s see',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.5), // Adjust alpha as needed
                  ),
                ),
                SizedBox(height: 16),
                // TextField for user input
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name',
                  ),
                ),
                SizedBox(height: 16),
                // Button to navigate to Page3
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // Page3 removed
                    },
                    child: Text('Start'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

