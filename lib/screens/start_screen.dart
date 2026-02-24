import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:provider/provider.dart';
import '../models/player.dart';
import '../providers/game_provider.dart';
import '../constants/game_constants.dart';
import 'game_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _nameController = TextEditingController();
  Player? _selectedPlayer;
  String _gameMode = 'normal';
  String _difficulty = 'normal';

  @override
  Widget build(BuildContext context) {
    return fluent.FluentApp(
      theme: fluent.FluentThemeData(accentColor: fluent.Colors.blue),
      home: fluent.ScaffoldPage(
        header: fluent.PageHeader(
          title: const Center(child: Text('📈 炒股人生', style: TextStyle(fontSize: 32))),
        ),
        content: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 玩家名称
                  fluent.TextBox(
                    controller: _nameController,
                    placeholder: '请输入您的名称',
                  ),
                  const SizedBox(height: 24),
                  
                  // 游戏模式
                  const Text('游戏模式', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 16,
                    children: [
                      _modeCard('📊 普通模式', 'normal', '专注股票交易'),
                      _modeCard('🏠 生存模式', 'survival', '平衡生活与投资'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // 难度选择
                  const Text('难度选择', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: [
                      _difficultyChip('简单', 'easy'),
                      _difficultyChip('普通', 'normal'),
                      _difficultyChip('困难', 'hard'),
                      _difficultyChip('现实', 'realistic'),
                      _difficultyChip('作弊', 'cheat'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // 身份选择
                  const Text('选择身份', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: PLAYER_IDENTITIES.map((player) => _playerCard(player)).toList(),
                  ),
                  const SizedBox(height: 32),
                  
                  // 开始按钮
                  fluent.FilledButton(
                    onPressed: _selectedPlayer == null || _nameController.text.isEmpty ? null : _startGame,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      child: Text('开始游戏', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _modeCard(String title, String mode, String desc) {
    final isSelected = _gameMode == mode;
    return fluent.Card(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () => setState(() => _gameMode = mode),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            border: isSelected ? Border.all(color: fluent.Colors.blue, width: 2) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _difficultyChip(String label, String value) {
    final isSelected = _difficulty == value;
    return fluent.Button(
      style: fluent.ButtonStyle(
        backgroundColor: WidgetStateProperty.all(isSelected ? fluent.Colors.blue : null),
      ),
      onPressed: () => setState(() => _difficulty = value),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.white : null)),
    );
  }

  Widget _playerCard(Player player) {
    final isSelected = _selectedPlayer?.id == player.id;
    return fluent.Card(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () => setState(() => _selectedPlayer = player),
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            border: isSelected ? Border.all(color: fluent.Colors.blue, width: 2) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(player.icon, style: const TextStyle(fontSize: 32)),
              Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('¥${player.initialCash}', style: TextStyle(color: fluent.Colors.green)),
              Text(player.description, style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  void _startGame() {
    final game = context.read<GameProvider>();
    game.startGame(_nameController.text, _selectedPlayer!, mode: _gameMode, difficulty: _difficulty);
    Navigator.pushReplacement(context, fluent.FluentPageRoute(builder: (_) => const GameScreen()));
  }
}
