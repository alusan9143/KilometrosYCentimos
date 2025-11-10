import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient supabase = Supabase.instance.client;
}

final supabase = SupabaseService.supabase;