class UserDetails {
  String nome;
  String avatar;
  String token;

  UserDetails({required this.nome, required this.avatar, required this.token});

  UserDetails.fromJson(Map json)
      : nome = json['username'],
        avatar = json['avatar'],
        token = json['token'];
}
