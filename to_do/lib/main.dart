import 'package:flutter/material.dart';
import 'package:to_do/db/supabase_db.dart';

import 'screens/display_to_dos.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeSupabase();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DisplayToDos(),
    );
  }
}
