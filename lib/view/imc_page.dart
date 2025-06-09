import 'package:flutter/material.dart';
import 'package:prjimc/controller/imc_controller.dart';
import 'package:prjimc/style/app_style.dart';
import 'package:prjimc/view/tela_login.dart'; // Import necessário para navegar ao logout

class ImcPage extends StatefulWidget {
  final bool isDarkMode;
  final String? nomeUsuario;

  const ImcPage({super.key, required this.isDarkMode, this.nomeUsuario});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  final ImcController _controller = ImcController();

  String resultadoMsg = 'Informe seus dados!';
  Color resultadoCor = Colors.black;

  // Função que retorna a saudação com base na hora atual
  String saudacaoPorHora() {
    final hora = DateTime.now().hour;
    if (hora >= 6 && hora < 12) {
      return 'Bom dia';
    } else if (hora >= 12 && hora < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  void _calcular() {
    setState(() {
      double? imc = _controller.calcularImc(
        pesoController.text,
        alturaController.text,
      );

      if (imc == null) {
        resultadoMsg = 'Dados inválidos!';
        resultadoCor = Colors.black;
      } else {
        final Map<String, dynamic> msgCor = AppStyle.mensagemCorImc(imc);
        resultadoMsg = 'IMC: ${imc.toStringAsFixed(2)}\n${msgCor['msg']}';
        resultadoCor = msgCor['cor'];
      }

      // Limpar os campos automaticamente após cálculo
      pesoController.clear();
      alturaController.clear();
    });
  }

  void _resetar() {
    setState(() {
      pesoController.clear();
      alturaController.clear();
      resultadoMsg = 'Informe seus dados!';
      resultadoCor = Colors.black;
    });
  }

  void _fazerLogout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const TelaLogin()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Corpo+'),
        backgroundColor: AppStyle.primaryColor(widget.isDarkMode),
        foregroundColor: Colors.white,
        actions: [
          if (widget.nomeUsuario != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Text(
                  '${saudacaoPorHora()}, ${widget.nomeUsuario!}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          IconButton(onPressed: _resetar, icon: const Icon(Icons.refresh)),
          IconButton(
            onPressed: _fazerLogout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              Icons.person,
              size: 80,
              color: AppStyle.primaryColor(widget.isDarkMode),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                filled: true,
                fillColor: AppStyle.inputColor(widget.isDarkMode),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                filled: true,
                fillColor: AppStyle.inputColor(widget.isDarkMode),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _calcular,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyle.buttonColor(widget.isDarkMode),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Calcular',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              resultadoMsg,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: resultadoCor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
