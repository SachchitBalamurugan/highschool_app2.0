class UserDto {
  final String id;
  final String email;
  final String name;
  final String phone;

  const UserDto({
    this.id = '',
    this.email = '',
    this.name = '',
    this.phone = '',
  });

  @override
  String toString() {
    return 'UserDto{id: $id, email: $email, name: $name, phone: $phone}';
  }
}
