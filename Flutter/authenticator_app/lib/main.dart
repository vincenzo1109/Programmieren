import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Secrets');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authenticator-App (sicher)',
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade900),
      ),
      home: const MyHomePage(title: 'Authenticator-App (sicher)'),
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

int secretNum = 0;
List<String> Secrets = [];

class QRCodeScan extends StatelessWidget {
  bool found = false;
  final MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner (Bitte scannen)')),
      body: GestureDetector(
        child: RotatedBox(
          quarterTurns: 1,
          child: MobileScanner(
            controller: controller,
            onDetect: (capture) {
              if (found == true) return;
              found = true;

              final QRcode = capture.barcodes.first;
              final String? QRcodeString = QRcode.rawValue;
              if (QRcode != null) {
                Navigator.pop(context,QRcodeString);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Gefunden: $QRcodeString')));

                var Box = Hive.box('Secrets');
                Box.put(secretNum, QRcode);
                secretNum++;
                Secrets.add('$QRcodeString');

                Clipboard.setData(ClipboardData(text: '$QRcodeString'));
                print('Gefundener QR-Code (In Zwischenablage kopiert): $QRcodeString');
              }
            },)
          ,
        ),),);
  }
}

class _MyHomePageState extends State<MyHomePage> {
var Box = Hive.box('Secrets');

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const Text('Test QR Codes:'),
            Expanded(
              child: ListView.builder(
                itemCount: Secrets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(Secrets[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: Secrets[index]));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('In Zwischenablage kopiert')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QRCodeScan()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
