import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('StorageNum');
  await Hive.openBox('record');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clicker Test',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const MyHomePage(title: 'Clicker Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int rest = 0;
  int Rekord = 0;
  int interval = 0;
  int increment = 0;
  Timer? _autoClickTimer;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      recordshow();
    });
    recordshow();
    startAutoClicker();
  }

  @override
  void startAutoClicker() {
    _autoClickTimer?.cancel();
    if (_counter >= 1000) {
      interval = 1000;
      increment = 5;
    } else if (_counter >= 100) {
      interval = 1000;
      increment = 1;
    }

    _autoClickTimer = Timer.periodic(Duration(milliseconds: interval),(timer){
      setState(() {
        recordshow();
        _counter = _counter + increment;
        recordshow();
      });
      startAutoClicker();
      recordshow();
    });
  }

  void initState() {
    super.initState();
    recordshow();
  }

  void recordshow() {
    setState(() {
      var record = Hive.box('record');
      Rekord = record.get('record', defaultValue: 0);
      if (_counter >= Rekord + 1) {
        record.put('record', _counter);
        rest = 0;
      } else {
        rest = Rekord - _counter;
      }
    });
  }

  void saveNum() {
    var storage = Hive.box('StorageNum');
    storage.put('counter', _counter);
    print('Deine Zahl wurde erfolgreich gespeichert');
  }

  void loadNum() {
    var storage = Hive.box('StorageNum');
    setState(() {
      _counter = storage.get('counter', defaultValue: 0);
    });
    recordshow();
  }

  void resetRecord() {
    Rekord = 0;
    var Record = Hive.box('record');
    Record.put('record', 0);
    _counter = 0;
    recordshow();
    _autoClickTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Text(
                'Dein Rekord: $Rekord',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Du hast den Knopf $_counter mal gedrückt',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                rest > 0
                    ? 'Noch $rest mal bis zum Rekord!'
                    : 'Rekord erreicht!',
                style: TextStyle(
                  fontSize: 18,
                  color: rest > 0 ? Colors.orange : Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _incrementCounter,
                icon: Icon(Icons.ads_click),
                label: Text('Clicken'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  textStyle: TextStyle(fontSize: 20),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: saveNum,
            tooltip: 'Zahl speichern',
            backgroundColor: Colors.lightBlueAccent,
            child: const Icon(Icons.download),
          ),
          FloatingActionButton(
            onPressed: resetRecord,
            tooltip: 'Alles zurücksetzen',
            backgroundColor: Colors.red,
            child: const Icon(Icons.lock_reset),
          ),
          FloatingActionButton(
            onPressed: loadNum,
            tooltip: 'Zahl laden',
            backgroundColor: Colors.green,
            child: const Icon(Icons.upload),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
