import 'package:flutter/material.dart';

/// Un widget de página base reutilizable para pantallas de "splash" o informativas.
///
/// Muestra una imagen, un título, un subtítulo y un botón de acción.
/// Es ideal para páginas que introducen una nueva sección de la app
/// y animan al usuario a realizar una primera acción.
class SplashInfoPage extends StatelessWidget {
  final String? pageTitle;
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final double imageHeight;

  const SplashInfoPage({
    super.key,
    this.pageTitle,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonPressed,
    this.imageHeight = 220,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título opcional de la página
          if (pageTitle != null) ...[
            Text(pageTitle!, style: textTheme.displaySmall),
            const SizedBox(height: 20),
          ],

          // Imagen representativa
          Image.asset(
            imagePath,
            height: imageHeight,
            fit: BoxFit.contain,
          ),

          // Título y descripción
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // Botón principal
          ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size.fromHeight(50), // Ocupa el ancho
            ),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}