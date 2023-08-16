import '../dataSource/data_source.dart';
import '../model/token.dart';

class AuthRepository {
  final DataSource _dataSource = DataSource();

  Future<Token?> signIn(String email, String password) async {
    return _dataSource.signIn(email, password);
  }
}
