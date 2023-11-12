import 'dart:convert';
import 'dart:developer';
import 'package:ecoalerta_lapaz/bloc/rain_cubit.dart';
import 'package:ecoalerta_lapaz/firebase_options.dart';
import 'package:ecoalerta_lapaz/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RainCubit>(
          create: (context) => RainCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'EcoAlerta La Paz',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const InitialScreen(), // aquí ***
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                buildSlideWithBackground('assets/images/gotas.jpg',
                    'Bienvenido/a a EcoAlerta La Paz.', 35, TextAlign.center),
                buildSlideWithBackground(
                    'assets/images/gotas.jpg',
                    'Esta app permite visualizar el riesgo de lluvia ácida en la ciudad de La Paz.',
                    25,
                    TextAlign.center),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: buildSlideWithBackground(
                      'assets/images/gotas.jpg',
                      '¡Gracias por utilizar EcoAlerta La Paz!\n\nToca la pantalla para continuar.',
                      30,
                      TextAlign.center),
                ),
              ],
            ),
          ),
          buildDotIndicator(),
        ],
      ),
    );
  }

  Widget buildSlideWithBackground(
      String imagePath, String text, double fontSize, TextAlign textAlign) {
    return Stack(
      children: <Widget>[
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.dstATop,
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'SanFranciscoFont',
              fontSize: fontSize,
              color: Colors.black,
              shadows: const <Shadow>[
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 6.0,
                  color: Color.fromARGB(150, 0, 0, 0),
                ),
              ],
            ),
            textAlign: textAlign,
          ),
        ),
      ],
    );
  }

  Widget buildDotIndicator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(3, (int index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 10,
            width: 10,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? Colors.blueAccent : Colors.grey,
            ),
          );
        }),
      );

  void postToken(String token) async {
    String url = "http://10.147.17.41:8000/user";
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
}
