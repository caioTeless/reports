class ValidatorApp {
  static String? stringValidator(String? value) {
    if (value!.isEmpty) return 'Insira alguma informação';
  }

  static String? doubleValidator(String? value){
    if(value!.isEmpty) return 'Insira algum valor';
    if(double.parse(value.replaceAll(',', '.')) <= 0) return 'Informação inválida';
  }
}
