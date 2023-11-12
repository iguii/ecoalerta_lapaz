import 'dart:convert';

import 'package:ecoalerta_lapaz/bloc/rain_cubit.dart';
import 'package:ecoalerta_lapaz/bloc/rain_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final precipitationInputController = TextEditingController();
  final pm10InputController = TextEditingController();
  final no2InputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String riskString = '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoAlerta La Paz'),
      ),
      body: BlocBuilder<RainCubit, RainState>(
        builder: (context, state) {
          if (state.data != null) {
            Map<String, dynamic> userMap = jsonDecode(state.data!);
            String riskLevel = userMap['probability'];
            switch (riskLevel) {
              case "0":
                riskString = 'Bajo';
                break;
              case "1":
                riskString = 'Medio';
                break;
              case "2":
                riskString = 'Alto';
                break;
              default:
                riskString = 'Desconocido';
            }
          }
          return Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(screenSize.width * 0.075),
                child: Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // poner una imagen
                        Image.asset(
                          'assets/images/logo.png',
                          width: screenSize.width * 0.5,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        const Text(
                          'Riesgo de Lluvia Ácida',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        const Text(
                          'Datos ambientales:',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenSize.height * 0.005),
                        TextField(
                          controller: precipitationInputController,
                          decoration: const InputDecoration(
                            labelText: 'Probabilidad de precipitación',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        TextField(
                          controller: pm10InputController,
                          decoration: const InputDecoration(
                            labelText: 'PM10 (µg/m3)',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        TextField(
                          controller: no2InputController,
                          decoration: const InputDecoration(
                            labelText: 'NO2 (ppb)',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                double precipitationProbability = double.parse(
                                    precipitationInputController.text);
                                double pm10Value =
                                    double.parse(pm10InputController.text);
                                double no2Value =
                                    double.parse(no2InputController.text);

                                context.read<RainCubit>().postEnvironmentalData(
                                    precipitationProbability,
                                    pm10Value,
                                    no2Value);
                              },
                              child: const Text('Calcular'),
                            ),
                            SizedBox(width: screenSize.width * 0.05),
                            ElevatedButton(
                              onPressed: () {
                                precipitationInputController.clear();
                                pm10InputController.clear();
                                no2InputController.clear();
                              },
                              child: const Text('Limpiar'),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        const Text(
                          'Riesgo calculado:',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        Text(
                          riskString,
                          style: TextStyle(
                            fontSize: 48,
                            color: riskString == 'Alto'
                                ? Colors.red
                                : riskString == 'Medio'
                                    ? Colors.orange
                                    : riskString == 'Bajo'
                                        ? Colors.green
                                        : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
