import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../models/item_models.dart';
import 'package:hive_ce/hive.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _buildDrawer(context),
      appBar: appbar(),
      body: body(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 185, 170, 188),
            ),
            child: Text('Menu', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: Text('StockUp', style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 239, 220, 220),
      elevation: 0.0,
      //left button
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 230, 240),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/left_arrow.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openEndDrawer();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 230, 240),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 20,
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
 
  Column body() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(205, 189, 189, 189),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: TextField(

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }


  void _addItemDialog(BuildContext context) {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final unitController = TextEditingController();
    final brandController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Item"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
              TextField(controller: categoryController, decoration: const InputDecoration(labelText: "Category")),
              TextField(controller: unitController, decoration: const InputDecoration(labelText: "Default Unit")),
              TextField(controller: brandController, decoration: const InputDecoration(labelText: "Brand")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty) return;
              final newItem = Item(
                id: const Uuid().v4(),
                name: nameController.text,
                category: categoryController.text,
                defaultUnit: unitController.text,
                brand: brandController.text,
              );
              final itemsBox = Hive.box<Item>('itemsBox');
              itemsBox.add(newItem);
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 185, 170, 188),
      onPressed: () => _addItemDialog(context),
      child: const Icon(Icons.add),
      
    );
  }
}