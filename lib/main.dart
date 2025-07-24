import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story Locals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3), // Azul principal
          primary: const Color(0xFF2196F3),
          secondary: const Color(0xFF43A047), // Verde
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF2196F3)),
          titleTextStyle: TextStyle(
            color: Color(0xFF2196F3),
            fontWeight: FontWeight.bold,
            fontSize: 26,
            letterSpacing: 1.5,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Story Locals'),
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
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    InicioPage(),
    MapaPage(),
    ConfiguracoesPage(),
    PerfilPage(),
  ];

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
                childAspectRatio: 1.1,
            children: List.generate(6, (index) {
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
              final colors = [
                Colors.orange[400],
                Colors.pink[400],
                Colors.blue[400],
                Colors.green[600],
                Colors.grey[700],
                Colors.indigo[400],
              ];
                return GestureDetector(
                onTap: () {
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
                    case 'Mapa':
                      page = const MapaPage();
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
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: Colors.white,
                  shadowColor: colors[index]?.withOpacity(0.2),
                    child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colors[index]?.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Icon(icons[index], size: 36, color: colors[index]),
                        ),
                        const SizedBox(height: 12),
            Text(
                            names[index],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: colors[index],
                                fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            }),
          ),
            );
      case 1:
        return const MapaPage();
      case 2:
        return const ConfiguracoesPage();
      case 3:
        return const PerfilPage();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.location_on, color: Color(0xFF2196F3), size: 30),
            SizedBox(width: 8),
            Text('Story Locals'),
          ],
        ),
      ),
      body: _getBody(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF43A047),
              Color(0xFF2196F3),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
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
                icon: Icon(Icons.home, size: 32),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map, size: 36),
                label: 'Mapa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 32),
                label: 'Config.',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 32),
                label: 'Perfil',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onBottomNavTap,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Color.fromARGB(255, 255, 255, 255),
            unselectedItemColor: Colors.black54,
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
            const Text('Seus Lugares Favoritos', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.place, color: Colors.orange),
                    title: Text('Praça Central'),
                    subtitle: Text('Seu ponto de encontro favorito na cidade.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.place, color: Colors.orange),
                    title: Text('Parque das Águas'),
                    subtitle: Text('Ótimo para caminhadas e relaxar.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.place, color: Colors.orange),
                    title: Text('Café do Centro'),
                    subtitle: Text('O melhor café para trabalhar e estudar.'),
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
            const Text('Lugares que você curtiu', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.pink[400], size: 40),
                const SizedBox(width: 12),
                const Text('Você curtiu 3 lugares recentemente', style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                Chip(
                  avatar: Icon(Icons.place, color: Colors.pink),
                  label: Text('Mirante do Sol'),
                  backgroundColor: Color(0xFFFFF0F6),
                ),
                Chip(
                  avatar: Icon(Icons.place, color: Colors.pink),
                  label: Text('Praia Azul'),
                  backgroundColor: Color(0xFFFFF0F6),
                ),
                Chip(
                  avatar: Icon(Icons.place, color: Colors.pink),
                  label: Text('Museu Histórico'),
                  backgroundColor: Color(0xFFFFF0F6),
                ),
              ],
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
            const Text('Bem-vindo ao Story Locals!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Descubra, salve e compartilhe os melhores lugares da sua cidade ou do mundo.'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    Icon(Icons.place, size: 40, color: Colors.orange),
                    SizedBox(height: 8),
                    Text('Favoritos'),
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.favorite, size: 40, color: Colors.pink),
                    SizedBox(height: 8),
                    Text('Curtidos'),
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.map, size: 40, color: Colors.green),
                    SizedBox(height: 8),
                    Text('Mapa'),
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
            const Text('Ajustes de Localização', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SwitchListTile(
              value: true,
              onChanged: (v) {},
              title: const Text('Permitir acesso à localização'),
              subtitle: const Text('Habilite para encontrar lugares próximos.'),
              secondary: const Icon(Icons.my_location),
            ),
            SwitchListTile(
              value: false,
              onChanged: (v) {},
              title: const Text('Notificações de novos lugares'),
              subtitle: const Text('Receba alertas sobre novidades na sua região.'),
              secondary: const Icon(Icons.notifications_active),
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
            const Text('João Explorador', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('joao.explorador@email.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.edit_location_alt),
              title: const Text('Editar perfil de explorador'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair da conta'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Position? _userPosition;
  String? _error;
  bool _loading = true;

  final List<_LocalInfo> _locais = [
    _LocalInfo(
      markerId: 'alvaro',
      position: LatLng(-5.090970, -42.803370),
      title: 'R. Álvaro Mendes, 94',
      description: 'Centro (Sul), Teresina - PI, 64000-040',
    ),
    _LocalInfo(
      markerId: 'quintino1',
      position: LatLng(-5.091900, -42.805000),
      title: 'R. Quintino Bocaiúva, 141',
      description: 'Centro (Sul), Teresina - PI, 64001-270',
    ),
    _LocalInfo(
      markerId: 'quintino2',
      position: LatLng(-5.091900, -42.804500),
      title: 'R. Quintino Bocaiúva',
      description: 'Centro (Sul), Teresina - PI, 64001-270',
    ),
  ];

  Set<Marker> get _markers => _locais.map((local) => Marker(
    markerId: MarkerId(local.markerId),
    position: local.position,
    infoWindow: InfoWindow(
      title: local.title,
      snippet: local.description,
      onTap: () => _showLocalInfo(local),
    ),
    onTap: () => _showLocalInfo(local),
  )).toSet();

  void _showLocalInfo(_LocalInfo local) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(local.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(local.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _requestLocation();
  }

  Future<void> _requestLocation() async {
    setState(() { _loading = true; _error = null; });
    final status = await Permission.location.request();
    if (status.isGranted) {
      try {
        final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _userPosition = pos;
          _loading = false;
        });
      } catch (e) {
        setState(() {
          _error = 'Erro ao obter localização: $e';
          _loading = false;
        });
      }
    } else {
      setState(() {
        _error = 'Permissão de localização não concedida.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!, style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _requestLocation,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                )
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _userPosition != null
                        ? LatLng(_userPosition!.latitude, _userPosition!.longitude)
                        : const LatLng(-5.090970, -42.803370),
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapType: MapType.normal,
                  markers: _markers,
                ),
    );
  }
}

// Classe auxiliar para informações dos locais
class _LocalInfo {
  final String markerId;
  final LatLng position;
  final String title;
  final String description;
  const _LocalInfo({
    required this.markerId,
    required this.position,
    required this.title,
    required this.description,
  });
}