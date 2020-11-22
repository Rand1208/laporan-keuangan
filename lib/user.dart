class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String jumlahUang;

  User(this.id, this.name, this.email, this.password, this.jumlahUang);

  List<User> getUsers() {
    List<User> users = <User>[];
    users.add(
        User(this.id, this.name, this.email, this.password, this.jumlahUang));

    return users;
  }
}
