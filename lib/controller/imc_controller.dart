import '../model/imc_model.dart';

class ImcController {
  // Método que retorna o IMC ou null se os dados forem inválidos
  double? calcularImc(String pesoStr, String alturaStr) {
    try {
      double peso = double.parse(pesoStr);
      double altura = double.parse(alturaStr);

      ImcModel model = ImcModel(peso: peso, altura: altura);
      return model.calcularImc();
    } catch (e) {
      return null;
    }
  }

  // Método extra, caso você ainda queira um resultado em texto pronto (opcional)
  String calcularResultado(String pesoStr, String alturaStr) {
    try {
      double peso = double.parse(pesoStr);
      double altura = double.parse(alturaStr);

      ImcModel model = ImcModel(peso: peso, altura: altura);
      double imc = model.calcularImc();
      String classificacao = model.classificarImc(imc);

      return 'IMC: ${imc.toStringAsFixed(2)}\n$classificacao';
    } catch (e) {
      return 'Dados inválidos!';
    }
  }
}
