import 'package:flutter/material.dart';
import 'package:prjimc/view/imc_page.dart'; 
import 'package:prjimc/database/usuario_dao.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // Instância única de UsuarioDao para toda a classe
  final UsuarioDao _usuarioDao = UsuarioDao();

  bool validarEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool validarSenha(String senha) {
    final senhaRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return senhaRegex.hasMatch(senha);
  }

  void _fazerLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final senha = _senhaController.text.trim();

    // Buscar usuário no banco via instancia da classe
    final usuario = await _usuarioDao.buscarUsuarioPorEmail(email);

    if (usuario == null || usuario.senha != senha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail ou senha inválidos')),
      );
      return;
    }

    // Login OK, navega para página da calculadora IMC, passando o nome do usuário
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ImcPage(
          isDarkMode: false,
          nomeUsuario: usuario.nome, // passe o nome para a tela IMC
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/image/imc-seeklogo.png',
              height: 32,
            ),
            const SizedBox(width: 8),
            const Text('Calculadora'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o e-mail';
                  }
                  if (!validarEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a senha';
                  }
                  if (!validarSenha(value)) {
                    return 'Senha deve ter no mínimo 8 caracteres, incluindo letras e números';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _fazerLogin,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/cadastro');
                },
                child: const Text(
                  'Não tem conta? Cadastre-se aqui',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
