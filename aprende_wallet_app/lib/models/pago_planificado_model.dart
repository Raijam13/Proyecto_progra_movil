import 'dart:convert';

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
      id: json['id'] as int,
      nombre: json['nombre'],
      monto: (json['monto'] as num).toDouble(),
      tipo: json['tipo'],
      periodo: json['periodo'],
      categoria: json['categoria'],
      proximaFecha: DateTime.parse(json['proximaFecha']),
    );
  }
}