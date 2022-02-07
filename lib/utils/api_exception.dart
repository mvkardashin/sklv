class ApiException implements Exception {
  final String message;
  final String content;
  ApiException(this.message, this.content);

  ApiException.connectionError(
      {this.message = 'Проблема с сетью',
      this.content = 'Проверьте, есть ли у вас интернет'});

  ApiException.defaultError(
      {this.message = 'Проблема отправки запроса на сервер',
      this.content = 'Попробуйте позже'});
}
