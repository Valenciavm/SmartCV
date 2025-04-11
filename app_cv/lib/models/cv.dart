class CV {
  final String? nombre;
  final String? correo;
  final String? telefono;
  final String? direccion;
  final String? experiencia;
  final String? educacion;
  final String? habilidades;

  CV({
    this.nombre,
    this.correo,
    this.telefono,
    this.direccion,
    this.experiencia,
    this.educacion,
    this.habilidades,
  });

  @override
  String toString() {
    return '''
    Nombre: $nombre
    Correo: $correo
    Teléfono: $telefono
    Dirección: $direccion
    Experiencia: $experiencia
    Educación: $educacion
    Habilidades: $habilidades
    ''';
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'direccion': direccion,
      'experiencia': experiencia,
      'educacion': educacion,
      'habilidades': habilidades,
    };
  }

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
      nombre: json['nombre'] ?? 'No disponible',
      correo: json['correo'] ?? 'No disponible',
      telefono: json['telefono'] ?? 'No disponible',
      direccion: json['direccion'] ?? 'No disponible',
      experiencia: json['experiencia'] ?? 'No disponible',
      educacion: json['educacion'] ?? 'No disponible',
      habilidades: json['habilidades'] ?? 'No disponible',
    );
  }
}
