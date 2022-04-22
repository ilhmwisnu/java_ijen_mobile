class Validator {
  static String? validateName({required String name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Nama tidak boleh kosong';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Masukkan email dengan benar';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (password.length < 8) {
      return 'Password tidak boleh kurang dari 8 karakter';
    }

    return null;
  }

  static String? validateAlamat({required String alamat}) {
    if (alamat == null) {
      return null;
    }
    if (alamat.isEmpty) {
      return 'Alamat tidak boleh kosong';
    }

    return null;
  }
}
