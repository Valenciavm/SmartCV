import 'package:flutter/material.dart';
import 'package:smart_cv/pages/ocr_page.dart';
import 'package:smart_cv/pages/voice_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart CV'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Imagen
            SizedBox(
              width: 150,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  30,
                ), // Establece el radio de 30
                child: Image.asset(
                  'assets/images/Logo.jpg',
                  fit:
                      BoxFit
                          .cover, // Esto ajusta la imagen para cubrir el área del contenedor
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Boton 1
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OCRPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                  255,
                  145,
                  66,
                  255,
                ), // Fondo púrpura
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Bordes redondeados opcional
                ),
              ),
              child: const Text(
                'Foto',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Texto blanco
                  fontFamily: 'Roboto', // Fuente Roboto
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Botón 2
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoicePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                  255,
                  145,
                  66,
                  255,
                ), // Fondo púrpura
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Bordes redondeados opcional
                ),
              ),
              child: const Text(
                'Voz',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Texto blanco
                  fontFamily: 'Roboto', // Fuente Roboto
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
