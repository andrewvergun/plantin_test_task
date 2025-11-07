import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantin_test_task/features/auth/presentation/pages/sign_in_page.dart';
import 'package:plantin_test_task/features/auth/presentation/pages/sign_up_page.dart';
import 'package:plantin_test_task/features/home_page/presentation/pages/home_page.dart';
import 'package:plantin_test_task/features/profile_page/presentation/pages/profile_page.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class ListenableFromStream extends ChangeNotifier {
  ListenableFromStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/${SignUpPage.path}',
  refreshListenable: ListenableFromStream(FirebaseAuth.instance.authStateChanges()),
  redirect: (BuildContext context, GoRouterState state) {
    final user = FirebaseAuth.instance.currentUser;
    final bool onSignUp = state.matchedLocation == '/${SignUpPage.path}';
    final bool onSignIn = state.matchedLocation == '/${SignInPage.path}';

    if (user != null && (onSignUp || onSignIn)) {
      return '/${HomePage.path}';
    } else if(user == null && !(onSignUp || onSignIn)) {
      return '/${SignUpPage.path}';
    }
    return null;

  },
  routes: [
    GoRoute(
      path: '/${SignUpPage.path}',
      name: SignUpPage.path,
      builder: (BuildContext context, GoRouterState state) {
        return SignUpPage();
      },
    ),
    GoRoute(
      path: '/${SignInPage.path}',
      name: SignInPage.path,
      builder: (BuildContext context, GoRouterState state) {
        return SignInPage();
      },
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        String location = state.uri.toString();
        int selectedIndex = 0;
        if (location.contains(HomePage.path)) {
          selectedIndex = 0;
        } else if (location.contains(ProfilePage.path)) {
          selectedIndex = 1;
        }

        return Scaffold(
          appBar: AppBar(title: Text('PlantIn Gallery'), centerTitle: true),
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  context.goNamed(HomePage.path);
                  break;
                case 1:
                  context.goNamed(ProfilePage.path);
                  break;
              }
            },
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
          ),
          body: child,
        );
      },
      routes: [
        GoRoute(
            path:'/${HomePage.path}',
            name: HomePage.path,
            builder: (BuildContext context, GoRouterState state) {
              return HomePage();
            },
        ),
        GoRoute(
          path: '/${ProfilePage.path}',
          name: ProfilePage.path,
          builder: (BuildContext context, GoRouterState state) {
            return ProfilePage();
          },
        ),
      ],
    ),
  ],
);
