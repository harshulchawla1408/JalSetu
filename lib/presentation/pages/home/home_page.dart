import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  late PageController _pageController;
  int _currentSlide = 0;
  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'Water Pollution',
      'icon': '🌊',
      'description': 'Together we can make our waters cleaner',
      'color': Colors.blue,
    },
    {
      'title': 'Recycling Benefits',
      'icon': '♻️',
      'description': 'Every small step counts towards a better future',
      'color': Colors.green,
    },
    {
      'title': 'Marine Life Protection',
      'icon': '🐠',
      'description': 'Protecting our underwater friends',
      'color': Colors.teal,
    },
    {
      'title': 'Waste Management',
      'icon': '🚯',
      'description': 'Proper waste disposal saves lives',
      'color': Colors.orange,
    },
    {
      'title': 'Clean Water Initiatives',
      'icon': '🛶',
      'description': 'Working towards clean water for all',
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> _stats = [
    {
      'icon': Icons.water_drop,
      'number': '70%',
      'description': 'Water Pollution',
      'subtext': 'of freshwater is polluted globally',
      'color': Colors.blue,
    },
    {
      'icon': Icons.recycling,
      'number': '100',
      'description': 'Years',
      'subtext': 'for plastic bottle decomposition',
      'color': Colors.green,
    },
    {
      'icon': Icons.waves,
      'number': '35%',
      'description': 'Affected',
      'subtext': 'marine biodiversity',
      'color': Colors.teal,
    },
    {
      'icon': Icons.star,
      'number': '10K+',
      'description': 'Waste Removed',
      'subtext': 'kgs globally',
      'color': Colors.orange,
    },
  ];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pageController = PageController(viewportFraction: 0.9);
    
    // Auto-scroll timer
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _startAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (_currentSlide < _slides.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildCarousel(),
                    _buildLearnMoreButton(),
                    _buildStatsSection(),
                    _buildReportWasteCard(),
                    _buildRecyclingCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade400,
            Colors.blue.shade600,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: WavePainter(_waveController),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Jal Setu — Connecting Humanity with Life Under Water',
                    textStyle: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Container(
      height: 220,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentSlide = index);
              },
              itemCount: _slides.length,
              itemBuilder: (context, index) {
                final slide = _slides[index];
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }
                    return Center(
                      child: SizedBox(
                        height: Curves.easeInOut.transform(value) * 200,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1621451537084-482c73073a0f?q=80&w=1200',
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          (slide['color'] as Color).withOpacity(0.8),
                          BlendMode.overlay,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          slide['icon'] as String,
                          style: const TextStyle(fontSize: 48),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          slide['title'] as String,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          slide['description'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _slides.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  entry.key,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(
                      _currentSlide == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLearnMoreButton() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ElevatedButton(
        onPressed: () => context.go('/about'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Learn How We Make a Difference',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Impact Statistics',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _stats.length,
              itemBuilder: (context, index) {
                final stat = _stats[index];
                return Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: stat['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: stat['color'].withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        stat['icon'] as IconData,
                        size: 48,
                        color: stat['color'] as Color,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        stat['number'] as String,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: stat['color'] as Color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat['description'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat['subtext'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportWasteCard() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1621451537084-482c73073a0f?q=80&w=1200',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue.shade50,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue.shade50,
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: ElevatedButton(
                onPressed: () => context.go('/report-issue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8),
                    Text(
                      'Report Waste Spot',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecyclingCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: ElevatedButton(
        onPressed: () => context.go('/recycling-process'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade50,
          foregroundColor: Colors.green.shade700,
          padding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.recycling,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'See How Waste is Recycled',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;

  WavePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final y = size.height * 0.8;
    path.moveTo(0, y);

    for (double x = 0; x <= size.width; x++) {
      path.lineTo(
        x,
        y + sin((x / size.width * 2 * pi) + (animation.value * 2 * pi)) * 10,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
} 