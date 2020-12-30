import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multiple_counters_firestore_flutter/services/database.dart';
import 'package:multiple_counters_firestore_flutter/ui/multiple_counters_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Database>(
      create: (_) => Database(),
      child: MaterialApp(
        title: 'Multiple Counters with Firestore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: Consumer<Database>(
          builder: (_, database, __) =>
              MultipleCountersPage(database: database),
        ),
      ),
    );
  }
}
