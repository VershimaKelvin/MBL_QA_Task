import 'package:flutter/material.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/core/utils/email_validator.dart';

class CustomFormValidation {
  static Color getColor(
    String? text,
    FocusNode focus,
    String? validationError,
  ) {
    if (focus.hasFocus && text == null) {
      return AppColors.red;
    } else if (focus.hasFocus &&
        text!.isEmpty &&
        validationError != null &&
        validationError.isNotEmpty) {
      return Colors.redAccent;
    } else if (focus.hasFocus &&
        text!.isNotEmpty &&
        validationError != null &&
        validationError.isEmpty) {
      return AppColors.primaryColor.withOpacity(0.28);
    } else if (text != null &&
        text.isNotEmpty &&
        validationError != null &&
        validationError.isEmpty) {
      return AppColors.primaryColor.withOpacity(0.28);
    } else if (validationError != null && validationError.isNotEmpty) {
      return AppColors.red;
    } else {
      return const Color.fromRGBO(255, 255, 255, 0.1);
    }
  }


  static String errorNoEmailMessage(
      String? text,
      String message, [
        String? type,
      ]) {
    return 'The entered email is not linked to an active account.';
  }

  static String errorEmailMessage(
    String? text,
    String message, [
    String? type,
  ]) {
    // var text = text ? '' : message;
    // return text;
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (EmailValidator.validEmail(text) == false) {
      return 'Email must be a valid email address';
    } else {
      return '';
    }
  }

  static String errorMessage(String? text, String message, [String? type]) {
    // var text = text ? '' : message;
    // return text;
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else {
      return '';
    }
  }

  static String errorAddressMessage(String? text, String message, [String? type]) {
    // var text = text ? '' : message;
    // return text;
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else {
      return '';
    }
  }

  static String errorMessagePassword2(
    String? text,
    String message, [
    String? type,
  ]) {
    // var text = text ? '' : message;
    // return text;
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 7) {
      return "Password can't be this short";
    } else {
      return '';
    }
  }

  static String errorMessagePassword(
    String? text,
    String message, [
    String? type,
  ]) {
    // var text = text ? '' : message;
    // return text;
    final hasUpperCase = RegExp('(?:[A-Z])');
    final hasLowerCase = RegExp('(?:[a-z])');
    final hasSymbols = RegExp(r"[!@#$%^&*(),|+=;.?':{}<>]");
    final hasANumber = RegExp('(?=.*?[0-9])');
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 7) {
      return 'Password must have 8 or more characters';
    } else if (!hasANumber.hasMatch(text)) {
      return 'Password must have at least a number';
    }  else if (!hasSymbols.hasMatch(text)) {
      return 'Password must have at a special character';
    }  else {
      return '';
    }
  }


  static String errorPhoneNumber(String? text, String message, [String? type]) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length != 10) {
      return 'Phone number must have 10 characters';
    } else {
      return '';
    }
  }

  static String errorPhoneNumber2(
    String? text,
    String message, [
    String? type,
  ]) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length != 11) {
      return 'Phone number must have 11 characters';
    } else {
      return '';
    }
  }

  static String errorPhoneNumber3(
    String? text,
    String message, [
    String? type,
  ]) {
    final hasUpperCase = RegExp('(?:[A-Z])');
    final hasLowerCase = RegExp('(?:[a-z])');
    final invaldSymbols = RegExp(r"[!@#$%^&*(),|=;.?':{}<>]");
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length < 9) {
      return 'Phone number is invalid';
    } else if (!text.startsWith('+')) {
      return "Phone number must start with '+'";
    } else if (invaldSymbols.hasMatch(text)) {
      return 'Phone number is invalid';
    } else if (hasLowerCase.hasMatch(text)) {
      return 'Phone number is invalid';
    } else if (hasUpperCase.hasMatch(text)) {
      return 'Phone number is invalid';
    } else {
      return '';
    }
  }

  static String errorPhoneNumberLogin(
    String? text,
    String message, [
    String? type,
  ]) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (!text.startsWith('0')) {
      if (text.contains('+')) {
        return 'Phone number must not contain special characters';
      }
      if (text.length < 9) {
        return 'Phone numner too short.';
      } else {
        return message;
      }
    } else if (text.startsWith('0') && (text.length < 11 || text.length > 11)) {
      return 'Phone number must have 11 characters';
    } else {
      return '';
    }
  }

  static String errorMessageConfirmPassword(
    String? text,
    String message,
    String password, [
    String? type,
  ]) {
    // final hasUpperCase = RegExp('(?:[A-Z])');
    // final hasLowerCase = RegExp('(?:[a-z])');
    // final hasSymbols = RegExp(r"[!@#$%^&*(),|+=;.?':{}<>]");
    // final hasANumber = RegExp('(?=.*?[0-9])');
    // var text = text ? '' : message;
    // return text;
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 7) {
      return 'Confirmation password must match password';
    } else if (text != password) {
      return 'Confirmation password must match password';
    } else {
      return '';
    }
  }

  static String errorMessagePin(String? text, String message, [String? type]) {
    // var text = text ? '' : message;
    // return text;
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length != 4) {
      return 'Pin must have 4 characters';
    } else {
      return '';
    }
  }

  static String errorMessagePin2(String? text, String message, [String? type]) {
    // var text = text ? '' : message;
    // return text;
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length != 6) {
      return 'OTP must have 6 characters';
    } else {
      return '';
    }
  }

  static String errorMessageConfirmPin(
    String? text,
    String message,
    String password, [
    String? type,
  ]) {
    // var text = text ? '' : message;
    // return text;
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 3) {
      return 'Pin must have 4 characters';
    } else if (text != password) {
      return 'Confirmation pin must match pin';
    } else {
      return '';
    }
  }



}
