import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:otp/otp.dart';
import 'dart:async';
import 'package:qr_flutter/qr_flutter.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Secrets');
  await Hive.openBox('issuer');
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
        scaffoldBackgroundColor: Colors.white,
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
          quarterTurns: 0,
          child: MobileScanner(
            controller: controller,
            onDetect: (capture) {
              if (found == true) return;

              final QRcode = capture.barcodes.first;
              final String? QRcodeString = QRcode.rawValue;

              if (QRcodeString != null &&
                  QRcodeString.startsWith('otpauth://totp') &&
                  QRcodeString.contains('secret=')) {
                // ignore: unnecessary_null_comparison
                if (QRcode != null) {
                  found = true;
                  Navigator.pop(context, QRcodeString);

                  Uri url = Uri.parse(QRcodeString);
                  var secret = url.queryParameters['secret'];
                  var isuser =
                  QRcodeString.split('otpauth://totp/')[1].split('?')[0];
                  ;

                  if (secret != null) {
                    String code = OTP.generateTOTPCodeString(
                      secret,
                      DateTime
                          .now()
                          .millisecondsSinceEpoch,
                      length: 6,
                      algorithm: Algorithm.SHA1,
                    );

                    var Box = Hive.box('Secrets');
                    Box.put(secretNum, secret);
                    var issuer = Hive.box('issuer');
                    issuer.put(secretNum, isuser);
                    secretNum++;
                    debugPrint(secret);
                    Secrets.add(code);
                  }
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var Box = Hive.box('Secrets');
  Timer? _refreshTimer;
  int secondsLeft = 30;
  double progress = 1.0;

  @override
  void initState() {
    super.initState();
    final box = Hive.box('Secrets');
    Secrets = List.generate(box.length, (index) => box.get(index).toString());
    secretNum = box.length;
    setState(() {});
    _updateProgress();

    _refreshTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _updateProgress();
    });
  }

  void _updateProgress() {
    var time = DateTime.now();
    var mseccomplete = 30000;
    secondsLeft = 30 - (time.second % 30);
    progress =
        1 - ((time.millisecond + (time.second % 30) * 1000) / mseccomplete);
    setState(() {});
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Die OTP-Codes :) (noch $secondsLeft Sekunden gültig)',
          style: TextStyle(fontSize: 19, color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white,
            color: Colors.green[500],
          ),
        ),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
      ),
      body: ListView(children: codeGeneration()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QRCodeScan()),
          );
          setState(() {});
        },
        tooltip: 'Add',
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
    );
  }

  List<Widget> codeGeneration() {
    var secrets = Hive.box('Secrets');
    var issuer = Hive.box('issuer');
    List<Widget> widgets = [];
    for (int i = 0; i < secrets.length; i++) {
      String secret = secrets.get(i).toString();
      String code = OTP.generateTOTPCodeString(
        secret,
        DateTime
            .now()
            .millisecondsSinceEpoch,
        interval: 30,
        length: 6,
        algorithm: Algorithm.SHA1,
      );

      widgets.add(
        ListTile(
          title: Text(code, style: TextStyle(fontSize: 17)),
          subtitle: Text(
            issuer.get(i).toString(),
            style: TextStyle(fontSize: 14),
          ),
          onTap: () {
            Clipboard.setData(ClipboardData(text: code));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Der Code wurde in die Zwischenablage kopiert.'),
              ),
            );
          },
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                deleteCode(i);
              } else if (value == 'generate QR-Code') {
                generatQRCode(i);
              }
            },
            itemBuilder:
                (context) =>
            [
              PopupMenuItem(
                  value: 'delete',
                  child: Text('Löschen')),
              PopupMenuItem(
                value: 'generate QR-Code',
                child: Text('QR-Code erstellen'),
              ),
            ],
            initialValue: (i.toString()),
          ),
        ),
      );
    }
    return widgets;
  }

  void deleteCode(int i) {
    //Code wird mit HIVE eintrag gelöscht und anschließen alles andere mit Hilfe von for-Schleife abfragen ob leer und wenn dann das nächste vorschieben
  }

  void generatQRCode(int i) {
    var secrets = Hive.box('Secrets');
    var secret = secrets.get(i);
    var issuers = Hive.box('issuer');
    var issuer = issuers.get(i);

    String URL = 'otpauth://totp/${Uri.encodeComponent(issuer)}?secret=$secret&issuer=${Uri.encodeComponent(issuer)}';

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
              title: Text('QR-Code'),
              content: QrImage(
                data: 'https://example.com',
                version: QrVersions.auto,
                size: 200,
              ),
              actions: [
              TextButton(
              child: Text('Schließen'),
      onPressed: () => Navigator.of(context).pop(),
    ),]
    ,
    )
    ,
    );
  }
}
