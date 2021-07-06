part of helpers;

extension LoadingDialogExtention on BuildContext {
  Future<TType> loadingDialog<TType>({
    required Future<TType> action,
    String? text,
  }) {
    showDialog(
      context: this,
      builder: (_) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    text ??
                        ReusableLocalizations.of(this)?.loading ??
                        'Loading please wait ...',
                    textAlign: TextAlign.center,
                    style: bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
    return action.then((value) {
      Navigator.of(this).pop();
      return value;
    }).catchError((e) {
      Navigator.of(this).pop();
      throw e;
    });
  }
}
