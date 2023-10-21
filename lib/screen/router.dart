import 'package:go_router/go_router.dart';
import 'package:hoppy/screen/screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
