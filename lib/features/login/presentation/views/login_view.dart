import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/assets.dart';
import 'package:flutter_application_1/features/login/presentation/views/dashboard_view.dart';
import 'package:flutter_application_1/features/login/presentation/states/login_provider.dart';
import 'package:flutter_application_1/features/login/presentation/widgets/SocialWidget.dart';
import 'package:provider/provider.dart';

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
      )
    );
  }
}

class BodyWidget extends StatefulWidget  {

  const BodyWidget({super.key});
  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  late bool showPassword;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 @override
  void initState() {
    showPassword = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BodyWidget oldWidget) {
    showPassword = false;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
     final isLoading = context.watch<LoginProvider>().isLoading;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth > 600
                ? (constraints.maxWidth - 600) / 2
                : 24,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'Welcome! ${Env.appName}',
              //     style: const TextStyle(
              //       fontSize: 24,
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              HeaderWidget(),
              SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.email),
                  hintText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: InkWell(
                    child: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onTap: () {
                      showPassword = !showPassword;
                      print('Toggle password visibility');
                      print('showPassword: $showPassword');

                      setState(() {});
                    },
                  ),
                ),
                obscureText: !showPassword,
              ),
              SizedBox(height: 16),
              const Text(
                'Forgot Password?',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                onPressed: isLoading
                    ? null
                    : () async {
                        final email = emailController.text.trim();
                        final password = passwordController.text;

                        final ok = await context
                            .read<LoginProvider>()
                            .login(email, password);

                        if (ok && mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const DashboardView(),
                            ),
                          );
                        } else if (mounted) {
                          final error = context.read<LoginProvider>().error ??
                              'Error de autenticación';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error)),
                          );
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              SizedBox(height: 16),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('Not a member?'),
              //     InkWell(
              //       onTap: () {
              //         print('Navigate to registration page');
              //       },
              //       child: Text(
              //         'Register now',
              //         style: TextStyle(
              //           color: Colors.blue,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Example credentials -- user: jaldana password: 123456',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: '',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Rich text tapped!');
                        },
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ''),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Divider(),
              SizedBox(height: 24),
              Text('Or continue with', textAlign: TextAlign.center),
              SizedBox(height: 16),
              SocialRow(),
            ],
          ),
        );
      },
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //final title = Provider.of<LoginProvider>(context).title;
    final title = context
        .watch<LoginProvider>()
        .title; // Leer valores y actualizar UI

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

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    Theme.of(context).primaryColor;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF006FFD)),
      ),
      onPressed: () {
        /* Provider.of<LoginProvider>(
          context,
          listen: false,
        ).updateTitle('Haciendo login...');*/
        context.read<LoginProvider>().updateTitle(
          'Haciendo login...',
        ); // Solo leer valores para ejecutar funciones
      },
      child: Text('Login', style: TextStyle(color: Colors.white)),
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
        SizedBox(width: 12),
        SocialWidget(color: Colors.blueAccent, imageAsset: Assets.facebookIcon),
        SizedBox(width: 12),
        SocialWidget(color: Colors.black, imageAsset: Assets.appleIcon),
      ],
    );
  }
}