import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:plantin_test_task/features/auth/presentation/pages/sign_in_page.dart';
import 'package:plantin_test_task/features/auth/presentation/pages/sign_up_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: SignUpPage.path,
      builder: (BuildContext context, GoRouterState state) {
        return SignUpPage();
      }
    ),
    GoRoute(
      path: '/${SignInPage.path}',
      name: SignInPage.path,
      builder: (BuildContext context, GoRouterState state) {
        return SignInPage();
      }
    ),
  ],
);