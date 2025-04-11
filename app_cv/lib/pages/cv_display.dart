import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cv/models/cv.dart';

class CVDisplayPage extends StatefulWidget {
  final CV cv;

  const CVDisplayPage({Key? key, required this.cv}) : super(key: key);

  @override
  State<CVDisplayPage> createState() => _CVDisplayPageState();
}

class EditableInfoBox extends StatefulWidget {
  final String title;
  final String? value;

  const EditableInfoBox({Key? key, required this.title, required this.value})
    : super(key: key);

  @override
  _EditableInfoBoxState createState() => _EditableInfoBoxState();
}

class _EditableInfoBoxState extends State<EditableInfoBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value,
    ); // Inicializa el controlador con el valor
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera el controlador cuando ya no se necesite
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Aquí es donde implementamos el método build
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              setState(() {
                // Si se quiere agregar lógica adicional, como enfoque
              });
            },
            child: TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Escribe aquí...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CVDisplayPageState extends State<CVDisplayPage> {
  File? _selectedImage;

  Widget _buildInfoBox(String title, String? value) {
    return Container(
      width: 150,
      //height: 90,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            value ?? 'No disponible',
            softWrap: true,
            overflow: TextOverflow.visible,
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoBox() {
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _selectedImage = File(pickedFile.path);
          });
        }
      },
      child: Container(
        width: 160,
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child:
            _selectedImage == null
                ? const Center(
                  child: Icon(Icons.person, size: 60, color: Colors.grey),
                )
                : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CV Procesado",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 145, 66, 255),
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 130),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Columna izquierda
                Column(
                  children: [
                    _buildPhotoBox(),
                    EditableInfoBox(title: "Nombre", value: widget.cv.nombre),
                    EditableInfoBox(title: "Correo", value: widget.cv.correo),
                    EditableInfoBox(
                      title: "Teléfono",
                      value: widget.cv.telefono,
                    ),
                    EditableInfoBox(
                      title: "Habilidades",
                      value: widget.cv.habilidades,
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                // Columna derecha
                Column(
                  children: [
                    EditableInfoBox(
                      title: "Dirección",
                      value: widget.cv.direccion,
                    ),
                    EditableInfoBox(
                      title: "Educación",
                      value: widget.cv.educacion,
                    ),
                    EditableInfoBox(
                      title: "Experiencia",
                      value: widget.cv.experiencia,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
