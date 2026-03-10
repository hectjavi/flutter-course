import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/presentation/states/settings_provider.dart';
import 'package:flutter_application_1/features/login/presentation/widgets/settings_widgets.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider()..loadSettings(),
      child: const Scaffold(
        backgroundColor: Color(0xFFF7F9FC),
        body: SettingsBody(),
      ),
    );
  }
}

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<SettingsProvider>(
          builder: (context, provider, child) {
            // Preview del color seleccionado
            final headerColor = provider.settings?.getHeaderColor() ?? const Color(0xFF006FFD);

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                // Header dinámico con color seleccionado
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 20,
                    bottom: 30,
                    left: constraints.maxWidth > 600
                        ? (constraints.maxWidth - 600) / 2
                        : 24,
                    right: constraints.maxWidth > 600
                        ? (constraints.maxWidth - 600) / 2
                        : 24,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        headerColor,
                        Color.fromARGB(255, headerColor.red ~/ 2, headerColor.green ~/ 2, headerColor.blue ~/ 2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Configuración',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Preview del perfil
                      if (provider.settings != null)
                        Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Container(
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                    child: Text(
                                      'JA',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              provider.settings!.displayName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // Contenido
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 600
                        ? (constraints.maxWidth - 600) / 2
                        : 24,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      // Mensajes
                      if (provider.error != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error, color: Colors.red.shade400),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  provider.error!,
                                  style: TextStyle(color: Colors.red.shade700),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 20),
                                onPressed: provider.clearMessages,
                              ),
                            ],
                          ),
                        ),

                      if (provider.successMessage != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green.shade400),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  provider.successMessage!,
                                  style: TextStyle(color: Colors.green.shade700),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 20),
                                onPressed: provider.clearMessages,
                              ),
                            ],
                          ),
                        ),

                      if (provider.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else ...[
                        // Sección: Perfil
                        SettingsSection(
                          title: 'Información Personal',
                          icon: Icons.person_outline,
                          children: [
                            TextField(
                              controller: provider.nameController,
                              decoration: InputDecoration(
                                labelText: 'Nombre a mostrar',
                                hintText: 'Tu nombre',
                                prefixIcon: const Icon(Icons.edit),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: provider.isSaving
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.save, color: Color(0xFF006FFD)),
                                        onPressed: provider.updateDisplayName,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Este nombre aparecerá en tu perfil y saludos',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Sección: Avatar
                        SettingsSection(
                          title: 'Avatar',
                          icon: Icons.face,
                          children: [
                            AvatarSelector(
                              avatars: provider.availableAvatars,
                              selectedAvatar: provider.settings?.avatarAsset ?? '',
                              onSelect: provider.updateAvatar,
                              isLoading: provider.isSaving,
                            ),
                          ],
                        ),

                        // Sección: Tema
                        SettingsSection(
                          title: 'Personalización',
                          icon: Icons.palette_outlined,
                          children: [
                            ColorSelector(
                              colors: provider.availableColors,
                              selectedColor: provider.settings?.headerColor ?? 'blue',
                              onSelect: provider.updateHeaderColor,
                              isLoading: provider.isSaving,
                            ),
                          ],
                        ),

                        // Sección: Seguridad
                        SettingsSection(
                          title: 'Seguridad',
                          icon: Icons.security,
                          children: [
                            _buildSecurityOption(
                              'Cambiar Contraseña',
                              'Actualiza tu contraseña regularmente',
                              Icons.lock_outline,
                              () {},
                            ),
                            const Divider(),
                            _buildSecurityOption(
                              'Verificación en Dos Pasos',
                              'Activa 2FA para mayor seguridad',
                              Icons.verified_user_outlined,
                              () {},
                            ),
                            const Divider(),
                            _buildSecurityOption(
                              'Historial de Sesiones',
                              'Revisa dónde has iniciado sesión',
                              Icons.devices_outlined,
                              () {},
                            ),
                          ],
                        ),

                        // Cerrar sesión
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 16),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implementar logout
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('Cerrar Sesión'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade50,
                              foregroundColor: Colors.red.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Versión
                        Center(
                          child: Text(
                            'Versión 1.0.0',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSecurityOption(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.grey.shade700),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}