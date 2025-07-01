import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final supabase = Supabase.instance.client;
  String selectedRole = 'visitante';
  bool isLogin = true;

      Future<void> login() async {
    try {
      // Verificar credenciales en la tabla perfiles
      final response = await supabase
          .from('perfiles')
          .select('email, password, role')
          .eq('email', emailController.text)
          .eq('password', passwordController.text)
          .eq('role', selectedRole)
          .maybeSingle();

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bienvenido, ${response['role']}')),
        );
        
        // Navegar a TurismoPage pasando el rol del usuario y el email
        Navigator.pushReplacementNamed(
          context, 
          '/turismo',
          arguments: {
            'userRole': response['role'],
            'userEmail': response['email'],
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas o rol no válido')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    }
  }

  Future<void> signup() async {
    try {
      // Verificar si el email ya existe
      final existingUser = await supabase
          .from('perfiles')
          .select('email')
          .eq('email', emailController.text)
          .maybeSingle();

      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Este email ya está registrado')),
        );
        return;
      }

      // Insertar nuevo usuario en la tabla perfiles
      await supabase.from('perfiles').insert({
        'email': emailController.text,
        'password': passwordController.text,
        'role': selectedRole,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada exitosamente')),
      );
      
      setState(() {
        isLogin = true;
        emailController.clear();
        passwordController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrarse: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Iniciar Sesión' : 'Registrarse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            
            // Selector de rol
            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: const InputDecoration(labelText: 'Rol'),
              items: const [
                DropdownMenuItem(value: 'visitante', child: Text('Visitante')),
                DropdownMenuItem(value: 'publicador', child: Text('Publicador')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),
            
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLogin ? login : signup,
                child: Text(isLogin ? 'Iniciar Sesión' : 'Registrarse'),
              ),
            ),
            
            const SizedBox(height: 16),
            
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                  emailController.clear();
                  passwordController.clear();
                });
              },
              child: Text(
                isLogin 
                  ? '¿No tienes cuenta? Regístrate' 
                  : '¿Ya tienes cuenta? Inicia sesión'
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}