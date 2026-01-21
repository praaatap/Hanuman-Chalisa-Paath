import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'widgets/particle_background.dart';
import 'model/chalisa_data.dart';
import 'logic/app_settings.dart';

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
  final ScrollController _scrollController = ScrollController();
  String _appBarTitle = "Hanuman Chalisa";

  // Approximate item height for scroll tracking (Title + Verse + Meaning + Spacing)
  final double _itemHeight = 280.0;

  @override
  void initState() {
    super.initState();
    _setupAudio();
    _scrollController.addListener(_updateAppBarTitle);
  }

  void _setupAudio() {
    // Use Hari Om Sharan version from Archive.org
    _audioPlayer.setSource(
      UrlSource(
        'https://archive.org/download/HanumanChalisa_HariOmSharan/Hanuman%20Chalisa%20-%20Hari%20Om%20Sharan.mp3',
      ),
    );

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

  void _updateAppBarTitle() {
    if (!_scrollController.hasClients) return;

    // Estimate current index based on offset.
    // This isn't perfect but works for general localization.
    int index = (_scrollController.offset / _itemHeight).floor();
    if (index < 0) index = 0;
    if (index >= chalisaData.length) index = chalisaData.length - 1;

    String newTitle;
    if (index < chalisaData.length) {
      final verse = chalisaData[index];
      // Display e.g. "Chaupai 1" or "Doha 1"
      // Assuming layout is strictly linear.
      newTitle = "${verse.type} ${index + 1}";
    } else {
      newTitle = "Hanuman Chalisa";
    }

    if (newTitle != _appBarTitle) {
      setState(() {
        _appBarTitle = newTitle;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundLight = Color(0xFFF9F8F6);
    const Color primaryColor = Color(0xFFD97736);

    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: backgroundLight,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF161213)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _appBarTitle,
          style: GoogleFonts.newsreader(
            textStyle: const TextStyle(
              color: Color(0xFF161213),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_fields, color: Color(0xFF161213)),
            onPressed: () {
              // Future font size toggle
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background particles
          const Opacity(
            opacity: 0.15,
            child: ParticleBackground(color: primaryColor),
          ),

          Column(
            children: [
              Expanded(
                child: ListenableBuilder(
                  listenable: AppSettings(),
                  builder: (context, child) {
                    final settings = AppSettings();
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 16,
                        bottom: 160,
                      ),
                      itemCount: chalisaData.length,
                      itemBuilder: (context, index) {
                        final verse = chalisaData[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Hindi Text
                                  Text(
                                    verse.hindi,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.newsreader(
                                      textStyle: TextStyle(
                                        color: const Color(0xFF161213),
                                        fontSize: settings.fontSize + 6,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // Meaning Card (Paper Style)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFF2ECDD,
                                      ), // Parchment
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFFD7C9A8),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.05,
                                          ),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      verse.meaning,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.manrope(
                                        textStyle: TextStyle(
                                          color: const Color(0xFF4A4A4A),
                                          fontSize: settings.fontSize - 2,
                                          fontStyle: FontStyle.italic,
                                          height: 1.6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(
                                duration: 600.ms,
                                delay: Duration(
                                  milliseconds: (index * 50).clamp(0, 500),
                                ),
                              ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Audio Player Control Panel
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Song Info & Controls
                      Row(
                        children: [
                          Expanded(
                            child: Column(
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
                                      ).withValues(alpha: 0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.replay_10,
                              color: primaryColor,
                            ),
                            onPressed: () {
                              final newPos =
                                  _position - const Duration(seconds: 10);
                              _audioPlayer.seek(
                                newPos < Duration.zero ? Duration.zero : newPos,
                              );
                            },
                          ),
                          FloatingActionButton(
                            onPressed: _togglePlayPause,
                            backgroundColor: primaryColor,
                            elevation: 2,
                            child: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.forward_10,
                              color: primaryColor,
                            ),
                            onPressed: () {
                              final newPos =
                                  _position + const Duration(seconds: 10);
                              if (_duration.inSeconds > 0 &&
                                  newPos < _duration) {
                                _audioPlayer.seek(newPos);
                              }
                            },
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
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_position),
                            style: GoogleFonts.manrope(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            _formatDuration(_duration),
                            style: GoogleFonts.manrope(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate().slideY(
                begin: 1.0,
                end: 0.0,
                curve: Curves.easeOut,
                duration: 800.ms,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    if (d.inHours > 0) {
      return '${d.inHours}:${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    }
    return '${d.inMinutes.remainder(60)}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}
