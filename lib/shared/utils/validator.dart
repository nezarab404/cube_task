import '../../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

abstract final class Validator {
  static String? emailValidator(String? val) {
    return val!.trim().isEmpty
        ? LocaleKeys.email_validation_message.tr()
        : val.isValidEmail
            ? null
            : LocaleKeys.email_validation_message.tr();
  }

  static String? phoneValidator(String? val) {
    return val!.trim().isEmpty
        ? LocaleKeys.phone_validation_message.tr()
        : val.isValidPhone
            ? null
            : LocaleKeys.phone_validation_message.tr();
  }

  static String? passwordValidator(String? val) {
    return val!.trim().isEmpty
        ? LocaleKeys.password_validation_message.tr()
        : val.length > 7
            ? null
            : LocaleKeys.password_validation_message.tr();
  }

  static String? confirmPasswordValidator(String? val, String password) {
    return val == password ? null : LocaleKeys.confirm_password_validation.tr();
  }

  static String? pinValidator(String? val) {
    return val == null
        ? LocaleKeys.pin_validation.tr()
        : val.length >= 4
            ? null
            : LocaleKeys.pin_validation.tr();
  }

  static String? nameValidator(String? val) {
    return val!.trim().isEmpty
        ? LocaleKeys.name_validation_message.tr()
        : val.length > 2
            ? null
            : LocaleKeys.name_validation_message.tr();
  }
}

extension StringExtensions on String {
  bool get isValidEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  get isValidPhone => RegExp(r'^0\d{9}$').hasMatch(this);
}
