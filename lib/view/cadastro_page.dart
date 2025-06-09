import 'package:flutter/material.dart';
import 'package:prjimc/model/usuario.dart';
import 'package:prjimc/database/usuario_dao.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();

  bool _isLoading = false;

  // Método simples para validar e-mail com regex
  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe o e-mail';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  // Validação da senha conforme requisito: mínimo 8 caracteres, com letras e números
  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha';
    if (value.length < 8) return 'Senha deve ter ao menos 8 caracteres';
    final regexLetra = RegExp(r'[A-Za-z]');
    final regexNumero = RegExp(r'\d');
    if (!regexLetra.hasMatch(value) || !regexNumero.hasMatch(value)) {
      return 'Senha deve conter letras e números';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _nomeController.dispose();
    _sobrenomeController.dispose();
    super.dispose();
  }

  void _cadastrar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final nome = _nomeController.text.trim();
    final sobrenome = _sobrenomeController.text.trim();
    final senha = _senhaController.text.trim();

    final usuarioDao = UsuarioDao();

    try {
      // Verifica se o e-mail já existe no banco
      final usuarioExistente = await usuarioDao.buscarUsuarioPorEmail(email);

      if (usuarioExistente != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('E-mail já cadastrado')));
        return;
      }

      // Se não existe, insere no banco
      final novoUsuario = Usuario(
        nome: nome,
        sobrenome: sobrenome,
        email: email,
        senha: senha,
      );

      await usuarioDao.inserirUsuario(novoUsuario);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );

      // Redireciona para a tela de login
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro no cadastro: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _sobrenomeController,
                decoration: const InputDecoration(labelText: 'Sobrenome'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe o sobrenome'
                    : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: validarEmail,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: validarSenha,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _cadastrar,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
