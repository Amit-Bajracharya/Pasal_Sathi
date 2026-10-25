import 'package:auto_route/auto_route.dart';
import 'package:pasal_sathi/src/core/routes/app_router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

bool get _isLoggedIn => Supabase.instance.client.auth.currentSession != null;

/// Protects routes that require an active session (e.g. [HomeRoute]).
/// Supabase restores any persisted session during `Supabase.initialize`
/// in `main.dart`, so this is already correct on cold start.
final authGuard = AutoRouteGuard.redirect(
  (resolver) => _isLoggedIn ? null : const AuthRoute(),
);

/// Protects guest-only routes (e.g. [AuthRoute]) from an already-logged-in
/// user — sends them straight to [HomeRoute] instead.
final guestGuard = AutoRouteGuard.redirect(
  (resolver) => _isLoggedIn ? const HomeRoute() : null,
);
