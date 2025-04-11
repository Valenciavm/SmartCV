import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:smart_cv/models/cv.dart';
import 'package:smart_cv/services/api_services.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  _VoicePageState createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  TextEditingController _textController = TextEditingController();

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = 'Pulsa el botón y habla...';
  String voice_cv = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('Status: $val'),
        onError: (val) => print('Error: $val'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              String newText = val.recognizedWords;
              _recognizedText = newText;
              _textController.text =
                  _recognizedText; // Actualiza el texto del TextField

              // Evitar que el texto se agregue repetidamente
              if (!voice_cv.endsWith(newText)) {
                voice_cv +=
                    newText +
                    ' '; // Asegúrate de agregar un espacio entre las frases
              }

              print(_recognizedText);
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reconocimiento de Voz'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // InfoBox
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 145, 66, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Háblanos sobre ti y generaremos una hoja de vida a partir de tu Nombre, Experiencia, Habilidades, Trayectoria y otras cosas más.',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // TextField para mostrar el texto reconocido
            TextField(
              controller: _textController, // Usamos el controlador aquí
              maxLines: null, // Permite que el texto se expanda
              decoration: InputDecoration(
                hintText: 'Habla para llenar el texto...',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40), // Espacio entre los elementos
            // Botón para micrófono
            ElevatedButton(
              onPressed: _listen,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 145, 66, 255),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                _isListening ? 'Detener' : 'Hablar',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 80),

            //Boton finalizar
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    //Funcion cuando se da a finalizar
                    ApiService.sendTextToBackend(voice_cv);
                    print('Finalizar presionado');
                  },
                  child: Text('Finalizar'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
