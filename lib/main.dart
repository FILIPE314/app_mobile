import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
      ),
      home: const MyHomePage(title: 'Story'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true, // Centraliza o título
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2, // 2 colunas
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.3, // mais largo para caber 3 linhas
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(6, (index) {
            final icons = [
              Icons.star,
              Icons.favorite,
              Icons.home,
              Icons.person,
              Icons.settings,
              Icons.book,
            ];
            return Card(
              elevation: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[index], size: 36),
                    const SizedBox(height: 8),
                    Text(
                      'Card ${index + 1}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Card 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Card 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Card 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Card 4',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Card 5',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Card 6',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
