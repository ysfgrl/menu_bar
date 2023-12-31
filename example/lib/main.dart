import 'package:flutter/material.dart';
import 'package:menu_bar/menu_bar.dart' as Bar;
import 'package:menu_bar/models.dart';
import 'package:menu_bar/controller.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  late TabController controller;
  late MenuBarController  menuBarController;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    menuBarController = MenuBarController(
        initialIndex: 1,
        items: [
          BarItem(id:1,label: "test1",
            icon: const Icon(Icons.ac_unit, color: Colors.white),
            iconBgColor: Colors.green,
            selectedIcon: const Icon(Icons.access_alarm, color: Colors.green,),
            selectedIconBgColor: Colors.white,
          ),
          BarItem(id:2,label: "test2",
            icon: const Icon(Icons.ac_unit),
            iconBgColor: Colors.white,
            selectedIcon: const Icon(Icons.access_alarm),
            selectedIconBgColor: Colors.green,
          ),
        ]
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      bottomNavigationBar: Bar.MenuBar(
        controller: menuBarController,
        barColor: Colors.green,
        barHeight: 70,
        onClick: (item, index) {
          controller.index = item.id-1;
        },
        translationFunc: (key) {
          return "[key]";
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: controller,
        children: <Widget>[
          ExamplePage(title: "Dashboard Page",),
          ExamplePage(title: "Home Page", ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          menuBarController.index = 0;
          controller.index = 0;
        });
      },),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
