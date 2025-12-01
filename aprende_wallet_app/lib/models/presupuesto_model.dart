class Presupuesto {
  final int id;
  final String nombre;
  final double montoTotal;
  final double montoGastado;
  final String icono;
  final String categoria;
  final int idCategoria;
  final String cuenta;
  final int idCuenta;
  final String periodo;

  Presupuesto({
    required this.id,
    required this.nombre,
    required this.montoTotal,
    required this.montoGastado,
    required this.icono,
    this.categoria = '',
    this.idCategoria = 0,
    this.cuenta = '',
    this.idCuenta = 0,
    this.periodo = '',
  });

  factory Presupuesto.fromJson(Map<String, dynamic> json) {
    return Presupuesto(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      nombre: json['nombre'] ?? 'Sin nombre',
      montoTotal:
          (json['monto_total'] ?? json['montoTotal'] ?? json['monto'] ?? 0)
              .toDouble(),
      montoGastado:
          (json['monto_gastado'] ??
                  json['montoGastado'] ??
                  json['gastado'] ??
                  0)
              .toDouble(),
      icono: json['icono'] ?? '',
      // Parse Category
      categoria: json['categoria'] is Map
          ? (json['categoria']['nombre'] ?? '')
          : (json['categoria'] ?? json['nombre_categoria'] ?? ''),
      idCategoria:
          json['id_categoria'] ??
          (json['categoria'] is Map ? json['categoria']['id'] : 0) ??
          0,
      // Parse Account
      cuenta: json['cuenta'] is Map
          ? (json['cuenta']['nombre'] ?? '')
          : (json['cuenta'] ?? json['nombre_cuenta'] ?? ''),
      idCuenta:
          json['id_cuenta'] ??
          (json['cuenta'] is Map ? json['cuenta']['id'] : 0) ??
          0,
      periodo: json['periodo'] ?? '',
    );
  }
}
