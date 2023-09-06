import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/profile.dart';
import 'package:untitled/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool? newLaunch = false;

  void loadCounter() async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      _counter = pre.getInt('counter')!;
    });
  }

  void _loadNewLaunch() async {
    var prefs = await SharedPreferences.getInstance();
    newLaunch = (prefs.getBool('newLaunch')) ?? true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCounter();
    _loadNewLaunch();
  }

  void _incrementCounter() async{
    SharedPreferences pre= await SharedPreferences.getInstance();
    setState(() {
      _counter = (pre.getInt('counter') ?? 0) + 1;
      pre.setInt('counter', _counter);

    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: newLaunch! ? const SplashScreen() : const ProfileScreen(),
      //   Column(
      //
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

    );
  }
}
