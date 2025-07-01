import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'turismo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://uldotvctssursxcxoqlt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVsZG90dmN0c3N1cnN4Y3hvcWx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgyOTcyMDQsImV4cCI6MjA2Mzg3MzIwNH0.Ie9YLPfnqZsnIfZqi9Ywieji5BcMtVphboGDJ7rGfRM',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Upload App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/turismo': (context) => const TurismoPage(),
      },
    );
  }
}