import 'package:flutter/material.dart';
import 'package:plantin_test_task/common/widgets/common_filled_button.dart';
import '../../../auth/data/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const path = 'profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: CommonFilledButton(onPressed: () {
                    AuthService().signOut();
                  }, text: 'Sign out'),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
