import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'perfil_controller.dart';

class PerfilPage extends StatelessWidget {
  final PerfilController control = Get.put(PerfilController());

  PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () => control.goBack(context),
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.primary,
          ),
        ),
        title: Text(
          'Más',
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildTitle(),
            const SizedBox(height: 30),
            _buildProfileSection(context),
            const SizedBox(height: 30),
            _buildInfoFields(context),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'Perfil',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => control.editPhoto(),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Editar foto',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                Obx(() => _buildInlineTextField(
                      context: context,
                      label: 'Nombre',
                      value: control.nombre.value,
                      onTap: () => control.editNombre(context),
                    )),
                const SizedBox(height: 20),
                Obx(() => _buildInlineTextField(
                      context: context,
                      label: 'Apellido',
                      value: control.apellido.value,
                      onTap: () => control.editApellido(context),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineTextField({
    required BuildContext context,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value.isEmpty ? '' : value,
              style: TextStyle(
                fontSize: 16,
                color: value.isEmpty ? Colors.grey[400] : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoFields(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Obx(() => _buildTextField(
                context: context,
                label: 'Correo electrónico',
                value: control.email.value,
                onTap: () => control.editEmail(context),
              )),
          const Divider(height: 1, thickness: 8, color: Color(0xFFF5F5F5)),
          Obx(() => _buildTextField(
                context: context,
                label: 'Nacimiento',
                value: control.fechaNacimiento.value,
                onTap: () => control.selectFechaNacimiento(context),
              )),
          _buildDivider(),
          Obx(() => _buildTextField(
                context: context,
                label: 'Género',
                value: control.genero.value,
                onTap: () => control.selectGenero(context),
                showArrow: true,
              )),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String value,
    required VoidCallback onTap,
    bool showArrow = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      value.isEmpty ? '' : value,
                      style: TextStyle(
                        fontSize: 16,
                        color: value.isEmpty || value == 'No especificado'
                            ? Colors.grey[400]
                            : Colors.grey[700],
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (showArrow) ...[
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey[400],
                      size: 24,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey[200],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () => control.cerrarSesion(context),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(
              Icons.logout,
              color: Colors.red[600],
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              'Cerrar sesión',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}