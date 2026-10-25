import 'package:pasal_sathi/src/core/providers/supabase/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

/// Wraps Supabase's `auth` calls for this app's email + password flow.
///
/// Kept thin on purpose: no UI, no state, just one Supabase call per method.
/// Callers (e.g. `AuthView`) catch [AuthException] themselves to show the
/// message in a snackbar.
class AuthRepository {
  AuthRepository(this._client);

  final SupabaseClient _client;

  /// The signed-in user, or `null` if no one is logged in.
  User? get currentUser => _client.auth.currentUser;

  /// The signed-in user's name, as stored at sign up via `data: {'name': ...}`.
  String? get currentUserName =>
      currentUser?.userMetadata?['name'] as String?;

  /// Signs an existing user in with their email + password.
  ///
  /// Throws [AuthException] if the email/password combination is wrong.
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  /// Creates a new account with email + password.
  ///
  /// By default Supabase sends a confirmation link to that email (toggle
  /// this off in Supabase Dashboard > Authentication > Providers > Email
  /// if you want accounts usable immediately). Throws [AuthException] if
  /// the email is already registered or the password is too weak.
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) {
    return _client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
  }

  /// Signs the current user out. With email confirmation disabled, [signUp]
  /// leaves the user signed in — call this right after a successful sign up
  /// if you want them to log in explicitly instead.
  Future<void> signOut() => _client.auth.signOut();
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(supabaseClientProvider));
}
