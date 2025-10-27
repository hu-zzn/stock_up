import 'package:flutter/material.dart';
import 'package:temp/pages/home.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:temp/models/item_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(SelectedItemAdapter());
  Hive.registerAdapter(ListModelAdapter());

  await Hive.openBox<Item>('itemsBox');
  await Hive.openBox<SelectedItem>('selectedItemsBox');
  await Hive.openBox<ListModel>('listsBox');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
