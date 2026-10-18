import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Reads Supabase credentials from the `.env` file (loaded in `main.dart`
/// before `runApp`). Keep the real values out of source control — only
/// `.env` (already gitignored) holds them.
class SupabaseConfig {
  SupabaseConfig._();

  static String get url => dotenv.get('SUPABASE_URL');

  static String get publishableKey => dotenv.get('PUBLISHABLE_KEY');
}
