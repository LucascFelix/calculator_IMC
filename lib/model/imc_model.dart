class ImcModel {
  double peso;
  double altura;

  ImcModel({required this.peso, required this.altura});

  double calcularImc() {
    double alturaMetros = altura / 100;
    return peso / (alturaMetros * alturaMetros);
  }

  String classificarImc(double imc) {
    if (imc < 16) return 'magreza grava';
    if (imc <= 16.9) return 'magreza moderada';
    if (imc <= 18.5) return 'magreza leve';
    if (imc <= 24.9) return 'peso ideal';
    if (imc <= 29.9) return 'sobrepeso';
    if (imc <= 34.9) return 'obesidade grau I';
    if (imc <= 39.9) return 'obesidade grau II ou severa';
    return 'obesidade grau III ou mórbida';
  }
}
