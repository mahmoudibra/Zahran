import 'package:flutter/material.dart';

import 'retry_error_body.dart';

class RetryFullScreenError extends StatelessWidget {
  final VoidCallback retry;
  final String? errorMessage;
  final String? errorIcon;

  RetryFullScreenError({
    required this.retry,
    this.errorMessage,
    this.errorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: RetryErrorBody(
          retry: retry,
          errorMessage: errorMessage,
          errorIcon: errorIcon,
        ),
      ),
      color: Theme.of(context).backgroundColor,
    );
  }
}
