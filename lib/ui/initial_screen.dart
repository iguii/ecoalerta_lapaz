import 'package:ecoalerta_lapaz/ui/home_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

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
                    30,
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
}
