import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecoalerta_lapaz/service/ip/ip.dart' as ip;

class RainService {
  static String backendUrlBase = ip.urlBackend;

  static Future<String> getAcidRainRisk() async {
    String url = '$backendUrlBase/precipitation';
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  static Future<String> postEnvironmentalData(
    double zone,
    double pm10,
    double no2,
  ) async {
    String url = '$backendUrlBase/precipitation';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      'zone': zone,
      'pm10': pm10,
      'no2': no2,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    debugPrint(response.body);

    return response.body;
  }
}
