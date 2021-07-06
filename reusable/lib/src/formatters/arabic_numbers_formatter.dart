part of formatters;

class ArabicNumbersToEnglishFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    const farsi = '۰۱۲۳۴۵۶۷۸۹';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    var text = '';
    for (var i = 0; i < newValue.text.length; i++) {
      var char = newValue.text[i];
      var index = arabic.indexOf(char);
      if (index < 0) index = farsi.indexOf(char);
      if (index < 0) {
        text += char;
      } else {
        text += index.toString();
      }
    }

    return TextEditingValue(
      composing: newValue.composing,
      selection: newValue.selection,
      text: text,
    );
  }
}
