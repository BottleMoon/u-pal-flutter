class Member {
  String? id;
  String? nickname;
  int? age;
  String? phoneNum;

  Member({this.id, this.nickname, this.age, this.phoneNum});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
        id: json['id'],
        nickname: json['nickname'],
        age: json['age'],
        phoneNum: json['phoneNum']);
  }
}
