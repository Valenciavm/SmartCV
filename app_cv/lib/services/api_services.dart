import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cv/models/cv.dart';
import 'package:smart_cv/pages/cv_display.dart';
import 'package:smart_cv/main.dart';
import 'package:flutter/material.dart';

class ApiService {
  //static const String _baseUrl = 'http://10.0.2.2:8000/api/cv/parse/'; // URL para la ruta de parseo
  static String get _baseUrl => '${getBaseUrl()}/api/cv/parse/';

  static Future<void> sendTextToBackend(String texto) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'texto': texto}), // Enviar solo el texto al endpoint
    );

    if (response.statusCode == 200) {
      print('Texto enviado correctamente');
      receiveProcessedCV(response.body); //Agregado manualmente
    } else {
      print('Error al enviar texto: ${response.body}');
    }
  }

  static Future<void> receiveProcessedCV(String responseBody) async {
    final Map<String, dynamic> data = jsonDecode(responseBody);

    String nombre = data['nombre'] ?? 'No disponible';
    String correo = data['correo'] ?? 'No disponible';
    String telefono = data['teléfono'] ?? 'No disponible';
    String direccion = data['dirección'] ?? 'No disponible';

    String experiencia =
        (data['experiencia'] as List<dynamic>?)
            ?.map(
              (e) =>
                  '${e['año'] ?? '-'}: ${e['puesto'] ?? '-'}\n${e['descripción'] ?? '-'}',
            )
            .join('\n\n') ??
        'No disponible';

    String educacion =
        (data['educación'] as List<dynamic>?)
            ?.map(
              (e) =>
                  '${e['año'] ?? '-'}: ${e['titulo'] ?? '-'}\n${e['institución'] ?? '-'}',
            )
            .join('\n\n') ??
        'No disponible';

    String habilidades =
        (data['habilidades'] as List<dynamic>?)?.join(', ') ?? 'No disponible';

    print('Datos procesados:');
    print('Nombre: $nombre');
    print('Correo: $correo');
    print('Teléfono: $telefono');
    print('Dirección: $direccion');
    print('Experiencia: $experiencia');
    print('Educación: $educacion');
    print('Habilidades: $habilidades');

    await handleProcessedCV({
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'direccion': direccion,
      'experiencia': experiencia,
      'educacion': educacion,
      'habilidades': habilidades,
    });
  }

  static Future<void> handleProcessedCV(Map<String, dynamic> data) async {
    final cv = CV.fromJson(data);
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => CVDisplayPage(cv: cv)),
    );
  }

  static String getBaseUrl() {
    // Puedes agregar más condiciones según el entorno o IP del dispositivo
    // Esto es solo un ejemplo, puedes ajustarlo a lo que necesites
    const bool runningOnEmulator =
        false; // cambia a false si estás en celular real

    if (runningOnEmulator) {
      return 'http://10.0.2.2:8000'; // Emulator (conecta al host)
    } else {
      return 'http://192.168.70.64:8000'; // IP WIFI  192.168.1.8:8000
    }
  }
}
