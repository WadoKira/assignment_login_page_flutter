import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Color primary = Color(0xff072227);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Login Application",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // You can replace this with your splash screen implementation
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts(); // Fetch posts when the widget is created
  }

  // Function to fetch posts from the API
  Future<void> fetchPosts() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
      List<String> postTitles = [];
      for (var post in data) {
        postTitles.add(post['title']);
      }
      setState(() {
        posts = postTitles;
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Home Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showAlertDialog(context);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(
                image: AssetImage("images/logo.png"),
                width: 105,
                height: 105,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "Welcome to\nStudent Login Portal",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Displaying posts from the API
            Column(
              children: posts.map((post) => Text(post)).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: ButtonTheme(
                  minWidth: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      logout(context);
                      Fluttertoast.showToast(msg: "Logged Out!");
                    },
                    child: Text(
                      "Logout",
                      style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "A student login/register application\n"
                        "with firebase authentication",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Creating a Logout Function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  // Creating an Alert Dialog for the Info button in App Bar
  showAlertDialog(BuildContext context) {
    // Setting up the button
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // Set up the Alert Dialog
    AlertDialog alertDialog = AlertDialog(
      title: Text("Student Login Application"),
      content: Text(
        "DEVELOPED BY KIRA TECHNOLOGIES\n",
      ),
      actions: [okButton],
    );

    // Show the Dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  // Replace this with your login screen implementation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Login Screen"),
      ),
    );
  }
}
