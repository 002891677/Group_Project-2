import 'dart:async';
import 'package:flutter/material.dart';

class MindfulnessScreen extends StatefulWidget {
  const MindfulnessScreen({super.key});

  @override
  State<MindfulnessScreen> createState() => _MindfulnessScreenState();
}

class _MindfulnessScreenState extends State<MindfulnessScreen> {
  static const _cycleSeconds = 12; // 4 inhale + 4 hold + 4 exhale
  static const _inhale = 4;
  static const _hold = 4;

  Timer? _timer;
  bool _running = false;
  int _remaining = _cycleSeconds;
  String _phase = 'Ready';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _timer?.cancel();
    setState(() {
      _running = true;
      _remaining = _cycleSeconds;
      _phase = 'Inhale';
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _remaining--;

        final elapsed = _cycleSeconds - _remaining;

        if (elapsed <= _inhale) {
          _phase = 'Inhale';
        } else if (elapsed <= _inhale + _hold) {
          _phase = 'Hold';
        } else {
          _phase = 'Exhale';
        }

        if (_remaining <= 0) {
          _remaining = _cycleSeconds;
          _phase = 'Inhale';
        }
      });
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() {
      _running = false;
      _phase = 'Paused';
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _running = false;
      _remaining = _cycleSeconds;
      _phase = 'Ready';
    });
  }

  double _progressValue() {
    // progress from 0..1 for current cycle
    final elapsed = _cycleSeconds - _remaining;
    return (elapsed / _cycleSeconds).clamp(0.0, 1.0);
  }

  String _tipForPhase() {
    switch (_phase) {
      case 'Inhale':
        return 'Breathe in slowly through your nose.';
      case 'Hold':
        return 'Hold gently. Relax your shoulders.';
      case 'Exhale':
        return 'Exhale slowly. Let tension go.';
      case 'Paused':
        return 'Take a moment. Restart when ready.';
      default:
        return 'Press Start to begin a calm breathing cycle.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final progress = _progressValue();

    return Scaffold(
      appBar: AppBar(title: const Text('Mindfulness')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: cs.surface.withValues(alpha: 0.25),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Text(
                      _phase,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _tipForPhase(),
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),

                    // Big circle + progress
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 160,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 10,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Next cycle in',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              '$_remaining s',
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _running ? null : _start,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Start'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _running ? _pause : null,
                            icon: const Icon(Icons.pause),
                            label: const Text('Pause'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Quick calm prompts',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            _promptCard(
              '5–4–3–2–1 Grounding',
              'Name 5 things you see, 4 you feel, 3 you hear, 2 you smell, 1 you taste.',
            ),
            _promptCard(
              'Mini body scan',
              'Relax your forehead, jaw, shoulders, hands. Notice where tension sits and soften it.',
            ),
            _promptCard(
              '1-minute gratitude',
              'Think of 1 small thing you appreciate right now. Hold it in your mind for 10 seconds.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _promptCard(String title, String text) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(text),
        ),
      ),
    );
  }
}
