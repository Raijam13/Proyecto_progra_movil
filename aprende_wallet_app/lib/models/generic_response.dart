/// Modelo para encapsular una respuesta estándar de API/servicio.
/// Es genérico para poder manejar cualquier tipo de dato en el campo 'data'.
class GenericResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final String? error;

  GenericResponse({
    required this.success,
    this.message,
    this.data,
    this.error,
  });

  /// Factory constructor para crear una instancia desde un JSON.
  /// Requiere una función [fromJsonT] que sepa cómo convertir el campo 'data'
  /// desde JSON al tipo específico T.
  factory GenericResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return GenericResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      error: json['error'] as String?,
    );
  }
}