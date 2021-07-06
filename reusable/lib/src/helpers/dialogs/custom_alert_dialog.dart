part of helpers;

extension CustomDialogExtention on BuildContext {
  void showCustomAlerDialog(Widget child) {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: child,
              ),
            ),
          );
        });
  }
}
