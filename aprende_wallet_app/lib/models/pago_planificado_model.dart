class PagoPlanificado {
  final int id;
  final String nombre;
  final double monto;
  final String tipo; // "ingreso" o "gasto"
  final String periodo;
  final String categoria;
  final DateTime proximaFecha;

  PagoPlanificado({
    required this.id,
    required this.nombre,
    required this.monto,
    required this.tipo,
    required this.periodo,
    required this.categoria,
    required this.proximaFecha,
  });

  factory PagoPlanificado.fromJson(Map<String, dynamic> json) {
    return PagoPlanificado(
      id: json['id'] ?? json['id_pago_planificado'] ?? 0,
      nombre: json['nombre'] ?? 'Sin nombre',
      monto: (json['monto'] is num) ? (json['monto'] as num).toDouble() : 0.0,
      tipo: json['tipo'] ?? 'gasto',
      periodo: json['periodo'] ?? 'Mensual',
      // Categoria might be a string or an object depending on backend
      categoria: json['categoria'] is Map
          ? (json['categoria']['nombre'] ?? '')
          : (json['categoria'] ?? json['nombre_categoria'] ?? ''),
      // Handle date parsing safely
      proximaFecha: json['proximaFecha'] != null
          ? DateTime.parse(json['proximaFecha'])
          : (json['proxima_fecha'] != null
                ? DateTime.parse(json['proxima_fecha'])
                : DateTime.now()),
    );
  }
}
