import 'package:flutter/material.dart';

class AppStyle {
  static Color primaryColor(bool isDarkMode) =>
      isDarkMode ? Colors.tealAccent : Colors.lightBlue;

  static Color inputColor(bool isDarkMode) =>
      isDarkMode ? Colors.grey[800]! : Colors.white;

  static Color buttonColor(bool isDarkMode) =>
      isDarkMode ? Colors.teal : Colors.lightBlue;

  static EdgeInsets get contentPadding =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  static TextStyle titleStyle(bool isDarkMode) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: isDarkMode ? Colors.white : Colors.black,
  );

  static TextStyle resultStyle(bool isDarkMode) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: isDarkMode ? Colors.white70 : Colors.black87,
  );
  static Map<String, dynamic> mensagemCorImc(double imc) {
    if (imc < 18.5) {
      return {'msg': 'Abaixo do peso', 'cor': Colors.orange};
    } else if (imc < 25) {
      return {'msg': 'Peso normal', 'cor': Colors.green};
    } else if (imc < 30) {
      return {'msg': 'Sobrepeso', 'cor': Colors.yellow[700]};
    } else if (imc < 35) {
      return {'msg': 'Obesidade Grau I', 'cor': Colors.redAccent};
    } else if (imc < 40) {
      return {'msg': 'Obesidade Grau II', 'cor': Colors.red};
    } else {
      return {'msg': 'Obesidade Grau III', 'cor': Colors.red[900]};
    }
  }
}
