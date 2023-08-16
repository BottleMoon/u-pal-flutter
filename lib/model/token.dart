class Token {
  String? accessToken;
  String? refreshToken;

  Token({this.accessToken, this.refreshToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        accessToken: json['accessToken'], refreshToken: json['refreshToken']);
  }
}
