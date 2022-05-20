import 'package:flutter_test/flutter_test.dart';
import 'package:quizlet/services/auth.services.dart';

void main() {
  test('Sign up by email successfully', () async {
    final String x =
        await AuthService().emailSignup("name", "d@gmail.com", "dvahn1111");
    expect(x, "");
  });
}

