import 'package:pasal_sathi/src/core/providers/supabase/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

/// Wraps Supabase's `auth` calls for this app's phone + password flow.
///
/// Kept thin on purpose: no UI, no state, just one Supabase call per method.
/// Callers (e.g. `AuthView`) catch [AuthException] themselves to show the
/// message in a snackbar.
class AuthRepository {
  AuthRepository(this._client);

  final SupabaseClient _client;

  /// Signs an existing user in with their phone number + password.
  ///
  /// Throws [AuthException] (via the underlying Supabase client) if the
  /// phone/password combination is wrong, or if the phone hasn't been
  /// verified yet.
  Future<AuthResponse> signInWithPhone({
    required String phone,
    required String password,
  }) {
    return _client.auth.signInWithPassword(phone: phone, password: password);
  }

  // ---------------------------------------------------------------------
  // YOUR TURN — implement sign up here, following the same shape as
  // signInWithPhone above:
  //
  // Future<AuthResponse> signUpWithPhone({
  //   required String phone,
  //   required String password,
  // }) {
  //   return _client.auth.signUp(phone: phone, password: password);
  // }
  //
  // Notes for when you wire it up:
  // 1. `signUp` sends an OTP SMS to confirm the phone number (unless phone
  //    confirmations are turned off in Supabase Dashboard > Authentication
  //    > Providers > Phone). You'll likely need a follow-up screen that
  //    calls `_client.auth.verifyOTP(phone: ..., token: ..., type:
  //    OtpType.sms)` with the code the user received.
  // 2. The Phone provider + an SMS provider (Twilio, MessageBird, Vonage...)
  //    must be enabled in your Supabase project's dashboard first, or every
  //    call here will throw an AuthException.
  // 3. Add the matching provider method in SignUpView's submit flow the
  //    same way AuthView._submit calls signInWithPhone below.
  // ---------------------------------------------------------------------
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(supabaseClientProvider));
}
