import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 177, 66, 66)),
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFB14242),
                Color(0xFFFFD600),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.white,
            letterSpacing: 2,
            shadows: [
              Shadow(
                color: Colors.black45,
                blurRadius: 4,
                offset: Offset(1, 2),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Usa o SliverGridDelegateWithMaxCrossAxisExtent para responsividade real
            return GridView.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.1,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final icons = [
                  Icons.star,
                  Icons.favorite,
                  Icons.home,
                  Icons.map,
                  Icons.settings,
                  Icons.person,
                ];
                final names = [
                  'Favoritos',
                  'Curtidas',
                  'Início',
                  'Mapa',
                  'Configurações',
                  'Perfil',
                ];
                return GestureDetector(
                  onTap: names[index] == 'Mapa'
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const MapaPage()),
                          );
                        }
                      : () {
                          Widget page;
                          switch (names[index]) {
                            case 'Favoritos':
                              page = const FavoritosPage();
                              break;
                            case 'Curtidas':
                              page = const CurtidasPage();
                              break;
                            case 'Início':
                              page = const InicioPage();
                              break;
                            case 'Configurações':
                              page = const ConfiguracoesPage();
                              break;
                            case 'Perfil':
                              page = const PerfilPage();
                              break;
                            default:
                              page = const SizedBox();
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => page),
                          );
                        },
                  child: Card(
                    elevation: 2,
                    color: names[index] == 'Mapa' ? Colors.amber : null,
                    child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icons[index], size: 36, color: names[index] == 'Mapa' ? Colors.black : null),
                          const SizedBox(height: 8),
            Text(
                            names[index],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: names[index] == 'Mapa' ? Colors.black : null,
                                  fontWeight: names[index] == 'Mapa' ? FontWeight.bold : null,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFD600),
              Color(0xFFB14242),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black, size: 32),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map, color: Colors.black, size: 32),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.black, size: 32),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.black, size: 32),
                label: '',
              ),
            ],
            currentIndex: 0,
            onTap: (index) {},
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}

// Adiciona as páginas personalizadas
class FavoritosPage extends StatelessWidget {
  const FavoritosPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Seus Favoritos', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.amber[700]),
                    title: const Text('Item Favorito 1'),
                    subtitle: const Text('Descrição do item favorito 1'),
                  ),
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.amber[700]),
                    title: const Text('Item Favorito 2'),
                    subtitle: const Text('Descrição do item favorito 2'),
                  ),
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.amber[700]),
                    title: const Text('Item Favorito 3'),
                    subtitle: const Text('Descrição do item favorito 3'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurtidasPage extends StatelessWidget {
  const CurtidasPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Curtidas')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Itens Curtidos', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.pink[400], size: 40),
                const SizedBox(width: 12),
                const Text('Você curtiu 12 itens', style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(6, (i) => Chip(
                avatar: const Icon(Icons.favorite, color: Colors.pink),
                label: Text('Curtida ${i+1}'),
                backgroundColor: Colors.pink[50],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class InicioPage extends StatelessWidget {
  const InicioPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Início')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bem-vindo ao App!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Aqui você encontra atalhos para suas funcionalidades favoritas.'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    Icon(Icons.star, size: 40, color: Colors.amber),
                    SizedBox(height: 8),
                    Text('Favoritos'),
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.favorite, size: 40, color: Colors.pink),
                    SizedBox(height: 8),
                    Text('Curtidas'),
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.settings, size: 40, color: Colors.blueGrey),
                    SizedBox(height: 8),
                    Text('Configurações'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ajustes do App', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SwitchListTile(
              value: true,
              onChanged: (v) {},
              title: const Text('Notificações'),
              subtitle: const Text('Receber notificações do app'),
              secondary: const Icon(Icons.notifications),
            ),
            SwitchListTile(
              value: false,
              onChanged: (v) {},
              title: const Text('Modo escuro'),
              subtitle: const Text('Ativar tema escuro'),
              secondary: const Icon(Icons.dark_mode),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Idioma'),
              subtitle: const Text('Português (Brasil)'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
            const SizedBox(height: 16),
            const Text('João da Silva', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('joao.silva@email.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar Perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MapaPage extends StatelessWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
      return Scaffold(
        appBar: AppBar(title: const Text('Mapa')),
        body: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(-3.742032, -38.521563), // Coordenadas de Teresina - PI
            zoom: 12,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('Mapa')),
        body: const Center(
          child: Text(
            'Google Maps não é suportado nesta plataforma.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }
}