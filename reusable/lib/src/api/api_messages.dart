part of api_helpers;

class ApiMessages {
  final String noInternetMessage;
  final String connectionTimeOutMessage;
  final String notSuccessResponse;
  final String notFoundMessage;
  final String authorizationMessage;

  const ApiMessages({
    this.notFoundMessage = 'The url u requested is not found',
    this.noInternetMessage = 'No internet or failed to get data',
    this.notSuccessResponse = 'Failed to get data',
    this.authorizationMessage =
        'Sorry you are unauthorized  please contact us or try to clear your cash',
    this.connectionTimeOutMessage =
        'Connection takes too long time please check your internet',
  });

  factory ApiMessages.of(BuildContext context) {
    var localizer = ReusableLocalizations.of(context);
    if (localizer != null) {
      return ApiMessages(
        authorizationMessage: localizer.authorizationMessage,
        notFoundMessage: localizer.notFoundMessage,
        noInternetMessage: localizer.noInternetMessage,
        notSuccessResponse: localizer.notSuccessResponse,
        connectionTimeOutMessage: localizer.connectionTimeOutMessage,
      );
    } else {
      return ApiMessages();
    }
  }
}
