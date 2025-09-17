// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import 'app_routes.dart';
//
// class RouterGenerationConfig {
//   static GoRouter goRouter() => GoRouter(
//     initialLocation: AppRoutes.mainScreen,
//     routes: [
//       GoRoute(
//         path: AppRoutes.onboardingScreen,
//         name: AppRoutes.onboardingScreen,
//         builder: (context, state) => const OnboardingScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.loginScreen,
//         name: AppRoutes.loginScreen,
//         builder: (context, state) => const SigninScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.registerScreen,
//         name: AppRoutes.registerScreen,
//         builder: (context, state) => const SignupScreen(),
//       ),
//
//       StatefulShellRoute.indexedStack(
//         builder: (context, state, navigationShell) {
//           return MainScreen(navigationShell: navigationShell);
//         },
//         branches: [
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: AppRoutes.mainScreen,
//                 name: AppRoutes.mainScreen,
//                 builder: (context, state) => const HomeScreen(),
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: AppRoutes.categoriesScreen,
//                 name: AppRoutes.categoriesScreen,
//                 builder: (context, state) => const CategoryManagementScreen(),
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: AppRoutes.tagsScreen,
//                 name: AppRoutes.tagsScreen,
//                 builder: (context, state) => const TagManagementScreen(),
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: AppRoutes.profileScreen,
//                 name: AppRoutes.profileScreen,
//                 builder: (context, state) => const ProfileScreen(),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//   );
// }
