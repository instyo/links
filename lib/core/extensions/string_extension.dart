import 'package:get/get.dart';

extension StringX on String {
  String getTitleFromPath() {
    try {
      String lastPart = split('/').last;
      return lastPart.replaceAll(RegExp(r'[-_]'), ' ').capitalizeFirst ?? '';
    } catch (e) {
      return '';
    }
  }

  String getDomainName() {
    try {
      final text = split('.');
      return (text.length > 1 ? text[text.length - 2] : '-').capitalizeFirst ??
          '';
    } catch (e) {
      return '';
    }
  }
}
