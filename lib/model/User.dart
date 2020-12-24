

class User {
  String _name;
  String _phoneNumber;
  int _userId;

  User(this._name, this._phoneNumber, this._userId);

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  /**
   * Return dart object to jdon format.
   */
  Map<String, dynamic> toJson() =>
      {'name': _name, 'phone': _phoneNumber, 'id': _userId};

  @override
  String toString() {
    return 'User{_name: $_name, _phoneNumber: $_phoneNumber, _userId: $_userId}';
  }
}