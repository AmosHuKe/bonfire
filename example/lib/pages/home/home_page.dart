import 'package:bonfire/bonfire.dart';
import 'package:example/pages/forces/forces_page.dart';
import 'package:example/pages/home/widgets/drawer/home_drawer.dart';
import 'package:example/pages/home/widgets/home_content.dart';
import 'package:example/pages/map/terrain_builder/terrain_builder_page.dart';
import 'package:example/pages/map/tiled/tiled_page.dart';
import 'package:example/pages/mini_games/manual_map/game_manual_map.dart';
import 'package:example/pages/mini_games/multi_scenario/multi_scenario.dart';
import 'package:example/pages/mini_games/platform/platform_game.dart';
import 'package:example/pages/mini_games/random_map/random_map_game.dart';
import 'package:example/pages/mini_games/tiled_map/game_tiled_map.dart';
import 'package:example/pages/mini_games/top_down_game/top_down_game.dart';
import 'package:example/pages/player/platform/platform_player_page.dart';
import 'package:example/pages/player/rotation/rotation_player_page.dart';
import 'package:example/pages/player/simple/simple_player_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget content = const HomeContent();
  ItemDrawer? itemSelected;
  late List<SectionDrawer> menu;

  @override
  void initState() {
    menu = _buildMenu();
    itemSelected = menu.first.itens.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('Bonfire examples (Under construction)'),
      ),
      drawer: HomeDrawer(
        itemSelected: itemSelected,
        itens: menu,
        onChange: _onChange,
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: content,
          ),
          if (itemSelected?.codeUrl.isNotEmpty == true)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => _launch(itemSelected!.codeUrl),
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Source code',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  void _onChange(ItemDrawer value) {
    setState(() {
      itemSelected = value;
      content = value.builder(context);
    });
  }

  List<SectionDrawer> _buildMenu() {
    return [
      SectionDrawer(
        itens: [
          ItemDrawer(name: 'Home', builder: (_) => const HomeContent()),
        ],
      ),
      SectionDrawer(
        name: 'Map',
        itens: [
          ItemDrawer(
            name: 'Using Tiled',
            builder: (_) => const TiledPage(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/blob/v3.0.0/example/lib/pages/map/tiled',
          ),
          ItemDrawer(
            name: 'Using matrix',
            builder: (_) => const TerrainBuilderPage(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/blob/v3.0.0/example/lib/pages/map/terrain_builder',
          ),
        ],
      ),
      SectionDrawer(
        name: 'Player',
        itens: [
          ItemDrawer(
            name: 'SimplePlayer',
            builder: (_) => const SimplePlayerPage(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/blob/v3.0.0/example/lib/pages/player/simple',
          ),
          ItemDrawer(
            name: 'RotationPlayer',
            builder: (_) => const RotationPlayerPage(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/blob/v3.0.0/example/lib/pages/player/rotation',
          ),
          ItemDrawer(
            name: 'PlatformPlayer',
            builder: (_) => const PlatformPlayerPage(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/blob/v3.0.0/example/lib/pages/player/platform',
          )
        ],
      ),
      SectionDrawer(
        itens: [
          ItemDrawer(
            name: 'Forces',
            builder: (_) => const ForcesPage(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/blob/v3.0.0/example/lib/pages/forces',
          ),
        ],
      ),
      SectionDrawer(
        name: 'Mini games',
        itens: [
          ItemDrawer(
            name: 'Map by Tiled',
            builder: (_) => const GameTiledMap(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/tree/v3.0.0/example/lib/pages/mini_games',
          ),
          ItemDrawer(
            name: 'Topdown game',
            builder: (_) => const TopDownGame(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/tree/v3.0.0/example/lib/pages/mini_games',
          ),
          ItemDrawer(
            name: 'Platform game',
            builder: (_) => const PlatformGame(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/tree/v3.0.0/example/lib/pages/mini_games',
          ),
          ItemDrawer(
            name: 'Multi scenario game',
            builder: (_) => const MultiScenario(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/tree/v3.0.0/example/lib/pages/mini_games',
          ),
          ItemDrawer(
            name: 'Random Map',
            builder: (_) => RandomMapGame(
              size: Vector2(100, 100),
            ),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/tree/v3.0.0/example/lib/pages/mini_games',
          ),
          ItemDrawer(
            name: 'Manual map game',
            builder: (_) => const GameManualMap(),
            codeUrl:
                'https://github.com/RafaelBarbosatec/bonfire/tree/v3.0.0/example/lib/pages/mini_games',
          ),
        ],
      ),
    ];
  }

  _launch(String codeUrl) {
    launchUrl(Uri.parse(codeUrl));
  }
}
