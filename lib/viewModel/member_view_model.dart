import 'package:flutter/cupertino.dart';
import 'package:u_pal/repository/member_repository.dart';

class MemberViewModel with ChangeNotifier {
  late final MemberRepository _memberRepository;

  MemberViewModel() {
    _memberRepository = MemberRepository();
  }
}
