import 'package:flutter/material.dart';
import 'package:prjimc/view/tela_login.dart';   
import 'package:prjimc/view/cadastro_page.dart'; 
import 'package:prjimc/view/imc_page.dart';      

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      initialRoute: '/login',  // rota inicial
      routes: {
        '/login': (context) => const TelaLogin(),
        '/cadastro': (context) => const CadastroPage(),
        '/imc': (context) => const ImcPage(isDarkMode: false),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
