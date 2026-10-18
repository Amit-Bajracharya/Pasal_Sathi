import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_client_provider.g.dart';

/// The single [SupabaseClient] instance, created once in `main.dart` via
/// `Supabase.initialize(...)`. `keepAlive: true` because auth state should
/// never be disposed just because no widget happens to be watching it.
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(Ref ref) => Supabase.instance.client;
