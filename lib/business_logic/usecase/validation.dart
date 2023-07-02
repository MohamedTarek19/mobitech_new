class Validator {
  Validator._();

  static bool isValidPassword(String? password) {
    return password!.length >= 6;
  }

  static bool isValidEmail(String? email) {
    final _emailRegExpString = r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
        r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
    return RegExp(_emailRegExpString, caseSensitive: false).hasMatch(email!) ;
  }
  static bool isValidAddress(String address) {
    return address.length >= 7;
  }
  static bool isValidPhone(String? phone) {
    // final _phoneRegExpString = r'(^(?:[+0]9)?[0-9]{11}$)';
    final _phoneRegExpString1 = r'(^\+?01[0-2]{1}[0-9]{8}$)';
    final _phoneRegExpString2 = r'(^\+?015[0-9]{8}$)';
    return RegExp(_phoneRegExpString1).hasMatch(phone!) ||RegExp(_phoneRegExpString2).hasMatch(phone);
  }
   static bool isValidNumber(String?number) {
      final _phoneRegExpString1 = r'(^[0-9]+$)';
    return RegExp(_phoneRegExpString1).hasMatch(number!)  ;
  }

  static bool isValidUserName(String userName) {
    return userName.length >= 3;
  }
 static bool isValidName(String? name) {
    return name!.length >= 3;
  }

 static bool isValidMeasure(String name) {
   return double.tryParse(name) != null;

  }



  static bool isValidDropDown(String hint,String value) {
    return value!= null && value != hint;
  }
  static bool isMatchPassword(String password, String matchPassword) {
    return password == matchPassword;
  }
}