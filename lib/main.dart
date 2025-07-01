import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'turismo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sodlregonixbebwnvdxf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNvZGxyZWdvbml4YmVid252ZHhmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgyOTcyNTgsImV4cCI6MjA2Mzg3MzI1OH0.eyan4TXu8A1vo5YkedqofqvgC_NvmEkkgbBIXHGndak',
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