import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do/models/to_do_model.dart';

void initializeSupabase() async {
  await Supabase.initialize(
    url: "https://nkogdmvbcmdajkqdphgi.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5rb2dkbXZiY21kYWprcWRwaGdpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAyMTQ3NzcsImV4cCI6MjAxNTc5MDc3N30.wIHlus7EQRXRolfera0qiSa_wxAoOPMtXp0148_gMio",
  );
}

Future<List<ToDo>> getToDos() async {
  final SupabaseClient supabase = Supabase.instance.client;
  final data = await supabase.from("to-do").select("*");
  List<ToDo> ls = [];
  for (var item in data) {
    ls.add(ToDo.fromJson(item));
  }
  return ls;
}

void deleteToDos(ToDo todo) async {
  final SupabaseClient supabase = Supabase.instance.client;
  final data = await supabase.from("to-do").delete().eq("id", todo.id);
}

void addToDos(ToDo todo) async {
  print(todo.completed);
  final SupabaseClient supabase = Supabase.instance.client;
  final data = await supabase.from("to-do").insert({
    'title': todo.title,
    'description': todo.description,
    'created_at': todo.createdAt,
    'completed': todo.completed,
  });
}

void updateToDos(ToDo todo) async {
  final SupabaseClient supabase = Supabase.instance.client;
  final data = await supabase.from("to-do").update(
    {"completed": todo.completed},
  ).eq("id", todo.id);
}
