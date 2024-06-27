import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/camera_page.dart';
import 'pages/market_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn ? _buildMainScreen() : LoginPage(onLogin: _login),
    );
  }

  Widget _buildMainScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: [
            const Text("Accueil", style: TextStyle(fontFamily: 'papyrus', fontSize: 21)),
            const Text("Liste de Marchés", style: TextStyle(fontFamily: 'papyrus', fontSize: 21)),
            const Text("Statut", style: TextStyle(fontFamily: 'papyrus', fontSize: 21)),
          ][_currentIndex],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: [
        const HomePage(),
        const MarketPage(),
        CameraPage(cameras: widget.cameras),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setCurrentIndex(index),
        selectedItemColor: const Color.fromARGB(255, 255, 81, 0),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color.fromARGB(255, 6, 143, 255),
        iconSize: 21,
        elevation: 20,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Planing",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: "Statut",
          ),
        ],
      ),
    );
  }
}