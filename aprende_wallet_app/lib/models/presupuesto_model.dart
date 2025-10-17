
class Presupuesto {
  final String id;
  final String nombre;
  final double montoTotal;
  final double montoGastado;
  final String icono;

  Presupuesto({
    required this.id,
    required this.nombre,
    required this.montoTotal,
    required this.montoGastado,
    required this.icono,
  });

  factory Presupuesto.fromJson(Map<String, dynamic> json) {
    return Presupuesto(
      id: json['id'],
      nombre: json['nombre'],
      montoTotal: (json['montoTotal'] as num).toDouble(),
      montoGastado: (json['montoGastado'] as num).toDouble(),
      icono: json['icono'],
    );
  }
}