import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'widgets/particle_background.dart';
import 'model/chalisa_data.dart';

class MeaningScrollScreen extends StatefulWidget {
  const MeaningScrollScreen({super.key});

  @override
  State<MeaningScrollScreen> createState() => _MeaningScrollScreenState();
}

class _MeaningScrollScreenState extends State<MeaningScrollScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _setupAudio();
  }

  void _setupAudio() {
    // _audioPlayer.setSource(AssetSource('audio/hanuman_chalisa_hari_om_sharan.mp3'));

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          _duration = newDuration;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          _position = newPosition;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      // Mock play for now if no source is set
      setState(() {
        _isPlaying = !_isPlaying;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Audio demo: Playing state toggled')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundLight = Color(0xFFF9F8F6);
    const Color primaryColor = Color(0xFFD97736);

    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF161213)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_fields, color: Color(0xFF161213)),
            onPressed: () {
              // Font size toggle functionality could go here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Subtle background particles
          const Opacity(
            opacity: 0.15,
            child: ParticleBackground(color: primaryColor),
          ),

          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  itemCount: chalisaData.length,
                  itemBuilder: (context, index) {
                    final verse = chalisaData[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                verse.hindi,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.newsreader(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF161213),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF5A5A5A,
                                  ).withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  verse.meaning,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                      color: const Color(
                                        0xFF5A5A5A,
                                      ).withValues(alpha: 0.8),
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ).animate().fadeIn(
                            delay: Duration(
                              milliseconds: (index * 50).clamp(0, 500),
                            ),
                          ),
                    );
                  },
                ),
              ),

              // Audio Player Bottom Bar
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Song Info
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hanuman Chalisa',
                              style: GoogleFonts.newsreader(
                                textStyle: const TextStyle(
                                  color: Color(0xFF161213),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Hari Om Sharan',
                              style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                  color: const Color(
                                    0xFF5A5A5A,
                                  ).withValues(alpha: 0.6),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_previous,
                            color: primaryColor,
                          ),
                          onPressed: () {},
                        ),
                        FloatingActionButton.small(
                          onPressed: _togglePlayPause,
                          backgroundColor: primaryColor,
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_next,
                            color: primaryColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Progress Bar
                    LinearProgressIndicator(
                      value: _duration.inMilliseconds > 0
                          ? (_position.inMilliseconds /
                                    _duration.inMilliseconds)
                                .clamp(0.0, 1.0)
                          : 0.0,
                      backgroundColor: const Color(
                        0xFF5A5A5A,
                      ).withValues(alpha: 0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        primaryColor,
                      ),
                    ),
                  ],
                ),
              ).animate().slideY(begin: 1.0, end: 0.0, curve: Curves.easeOut),
            ],
          ),
        ],
      ),
    );
  }
}
