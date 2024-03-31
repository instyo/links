class FieldValidators {
  static String? validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return 'URL is required';
    }

    if (url.length > 25) {
      return 'Max length is 25 characters';
    }

    final RegExp urlRegExp = RegExp(
      r"^(?:http|https):\/\/"
      r"(?:(?:[a-zA-Z0-9-]+\.){1,}[a-zA-Z]{2,}|(?:\d{1,3}\.){3}\d{1,3})"
      r"(?:\/[^\s]*)?$",
      caseSensitive: false,
    );

    if (!urlRegExp.hasMatch(url)) {
      return 'Please input a valid URL';
    }

    return null;
  }
}
