class TokenModel {
  String? message;
  String? firstname;
  String? lastname;
  String? email;
  String? account;
  String? pub_key;

  TokenModel(
      {required this.message,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.account,
      required this.pub_key});

  TokenModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];

    firstname = json['firstname'];
    lastname = json['lastname'];

    email = json['email'];
    account = json['account'];
    pub_key = json['pub_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;

    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;

    data['email'] = this.email;
    data['pub_key'] = this.pub_key;
    data['account'] = this.account;

    return data;
  }
}
