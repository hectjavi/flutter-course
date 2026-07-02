import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/assets.dart';
import 'package:flutter_application_1/core/localization/language_selector.dart';
import 'package:flutter_application_1/features/auth/presentation/states/auth_notifier.dart';
import 'package:flutter_application_1/features/auth/presentation/states/auth_state.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/SocialWidget.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Image.asset(
            Assets.loginBackground,
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
          ),
          const BodyWidget(),
        ],
      ),
    );
  }
}

class BodyWidget extends ConsumerStatefulWidget {
  const BodyWidget({super.key});

  @override
  ConsumerState<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends ConsumerState<BodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;
  bool isRegisterMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (message) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        },
      );
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth > 600
                ? (constraints.maxWidth - 600) / 2
                : 24,
            vertical: 40,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeaderWidget(
                  title: isRegisterMode
                      ? localizations.register
                      : localizations.login,
                ),
                const SizedBox(height: 16),
                const LanguageSelector(),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.email),
                    hintText: localizations.email_address,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => _validateEmail(value, localizations),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: localizations.password,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      tooltip: showPassword
                          ? 'Ocultar contraseña'
                          : 'Mostrar contraseña',
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !showPassword,
                  validator: (value) => _validatePassword(value, localizations),
                ),
                const SizedBox(height: 16),
                if (!isRegisterMode) ...[
                  Text(
                    localizations.forgot_password,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                  ),
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          isRegisterMode
                              ? localizations.create_account
                              : localizations.login,
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          setState(() {
                            isRegisterMode = !isRegisterMode;
                          });
                        },
                  child: Text(
                    isRegisterMode
                        ? localizations.already_have_account
                        : localizations.dont_have_account,
                  ),
                ),
                const SizedBox(height: 16),
                if (!isRegisterMode) ...[
                  Text(
                    localizations.example_credentials,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  Text(
                    localizations.or_continue_with,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const SocialRow(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final controller = ref.read(authControllerProvider.notifier);
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (isRegisterMode) {
      await controller.register(email: email, password: password);
    } else {
      await controller.login(email: email, password: password);
    }
  }

  String? _validateEmail(String? value, AppLocalizations localizations) {
    final email = value?.trim() ?? '';
    final emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (email.isEmpty) {
      return localizations.email_required;
    }

    if (!emailRegExp.hasMatch(email)) {
      return localizations.email_invalid;
    }

    return null;
  }

  String? _validatePassword(String? value, AppLocalizations localizations) {
    final password = value ?? '';

    if (password.isEmpty) {
      return localizations.password_required;
    }

    if (password.length < 6) {
      return localizations.password_min_length;
    }

    return null;
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialWidget(color: Colors.blue, imageAsset: Assets.googleIcon),
        const SizedBox(width: 12),
        SocialWidget(color: Colors.blueAccent, imageAsset: Assets.facebookIcon),
        const SizedBox(width: 12),
        SocialWidget(color: Colors.black, imageAsset: Assets.appleIcon),
      ],
    );
  }
}
