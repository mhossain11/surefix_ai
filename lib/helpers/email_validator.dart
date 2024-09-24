/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

library email_validator;

import 'dart:core';

enum type { None, Alphabetic, Numeric, AlphaNumeric }

class EmailValidator {
  static int _index = 0;
  static const String _atomCharacters = "!#\$%&'*+-/=?^_`{|}~";
  static type _domainType = type.None;

  static bool _isDigit(String c) {
    return c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
  }

  static bool _isLetter(String c) {
    return (c.codeUnitAt(0) >= 65 && c.codeUnitAt(0) <= 90) ||
        (c.codeUnitAt(0) >= 97 && c.codeUnitAt(0) <= 122);
  }

  static bool _isLetterOrDigit(String c) {
    return _isLetter(c) || _isDigit(c);
  }
}
