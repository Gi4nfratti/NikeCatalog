class MValidator {
  static String? validadeEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName é necessário';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu e-mail';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return "Endereço de e-mail inválido";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite sua senha';
    }

    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu número de celular';
    }

    var phoneRegExp = value.replaceAll(new RegExp(r'[^0-9]'), '');

    if (phoneRegExp.length != 11) {
      return 'Número de celular inválido';
    }

    return null;
  }
}
