class User {
  int? id;
  String usuario;
  String senha;

  User(this.usuario, this.senha);

  User.fromMap(dynamic obj, this.usuario, this.senha) {
    this.usuario = obj['usuario'];
    this.senha = obj['senha'];
  }
  String get username => usuario;
  String get password => senha;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["usuario"] = usuario;
    map["senha"] = senha;
    return map;
  }
}
