import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoAlerta La Paz'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: RiskCard(),
        ),
      ),
    );
  }
}

class RiskCard extends StatelessWidget {
  const RiskCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String riskString = 'Bajo'; // TODO: get from API
    String dateString = "Hoy, 11 de noviembre de 2023"; // TODO: get from API
    return Container(
      padding: EdgeInsets.all(screenSize.width * 0.075), // 5% of screen width
      child: Card(
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Riesgo de lluvia ácida',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                dateString,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const Text(
                'La Paz - Bolivia',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                riskString,
                style: TextStyle(
                  fontSize: 48,
                  color: riskString == 'Alto'
                      ? Colors.red
                      : riskString == 'Medio'
                          ? Colors.orange
                          : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_circle_left_outlined),
                    onPressed: () {
                      // al apretar el botón izquierdo (riesgo anterior)
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_circle_right_outlined),
                    onPressed: () {
                      // al aprertar el botón derecho (riesgo siguiente)
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
