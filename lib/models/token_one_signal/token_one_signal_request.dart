class TokenOneSignalRequest {
  String tokenSignal = "";

  TokenOneSignalRequest(this.tokenSignal);

  Map<String, dynamic> toBodyRequest() => {
        'tokenSignal': tokenSignal,
      };
}
