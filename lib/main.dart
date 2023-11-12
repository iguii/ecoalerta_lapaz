import 'dart:convert';
import 'dart:developer';
import 'package:ecoalerta_lapaz/firebase_options.dart';
import 'package:ecoalerta_lapaz/ui/initial_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String? notificationTitle;
String? notificationBody;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

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
      home: const MyHomePage(title: "home page alv"), // aquí ***
      debugShowCheckedModeBanner: false,
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

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      log("Token: $value!");
      postToken(value!);
    });

    FirebaseMessaging.onMessage.listen((event) {
      log("onMessage: $event");
      setState(() {
        notificationTitle = event.notification?.title;
        notificationBody = event.notification?.body;
      });
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${notificationTitle ?? "No title"}",
              style: const TextStyle(
                fontSize: 28,
                color: Color.fromARGB(255, 79, 79, 79),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${notificationBody ?? "No body"}",
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 79, 79, 79),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

void postToken(String token) async {
  String url = ''; // ************ API URL ************
  Map<String, String> headers = {"Content-Type": "application/json"};
  String jsonBody = json.encode({
    "FCMToken": token,
  });

  try {
    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      log('Token enviado correctamente: ${response.body}');
    } else {
      log('Error al enviar el token: ${response.statusCode}');
    }
  } catch (e) {
    log('Error al conectar con la API: $e');
  }
}
