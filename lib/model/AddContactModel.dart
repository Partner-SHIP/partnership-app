import 'package:partnership/model/AModel.dart';

class AddContactModel extends AModel {
  AddContactModel(): super();
  List<Member> members = new List();
  int i = 0;
  Member _member;

  List<Member> get listMember => this.members;
  Member get member => this._member;
  set member(Member m) => this._member = m;
}

class Member {
  final String fullName;
  final String email;
  final String uid;

  const Member({this.fullName, this.email, this.uid});
}
