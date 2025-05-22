import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'login_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: MaterialApp(
        title: 'Tabbed App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF030154),
            primary: const Color(0xFF030154),
            background: const Color(0xFFFFFFFF),
            surface: const Color(0xFF030154),
            onPrimary: const Color(0xFFFFFFFF),
            onBackground: const Color(0xFF000000),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xFFFFFFFF)),
            titleLarge: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 20,
              shadows: [Shadow(blurRadius: 2.0, color: Color(0xFF000000))],
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 2, 1, 90),
            foregroundColor: const Color(0xFFFFFFFF),
            elevation: 0,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: const Color(0xFF000000),
            unselectedLabelColor: const Color(0xFFFFFFFF),
            indicatorColor: null,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
            labelPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
            indicator: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          cardTheme: CardTheme(
            color: const Color(0xFFffe648),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
          ),
        ),
        home: const HomeTabController(),
      ),
    );
  }
}

class HomeTabController extends StatefulWidget {
  const HomeTabController({super.key});

  @override
  State<HomeTabController> createState() => _HomeTabControllerState();
}

class _HomeTabControllerState extends State<HomeTabController> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Your Local Quizzes'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 55),
                child: IconButton(
                  icon: const Icon(Icons.person),
                  iconSize: 40,
                  tooltip: 'Profile',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserProfilePage()),
                    );
                  },
                ),
              ),
            ],
            backgroundColor: const Color.fromARGB(255, 2, 1, 90),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              MoviePage(),
              SeriesPage(),
              PlacesPage(),
              MapPage(),
              const StreamingPage(),
            ],
          ),
          bottomNavigationBar: Container(
  height: 48, // <-- wyższy pasek
  color: const Color.fromARGB(255, 2, 1, 90),
  child: TabBar(
    controller: _tabController,
    tabs: const [
      Tab(icon: Icon(Icons.movie)),
      Tab(icon: Icon(Icons.tv)),
      Tab(icon: Icon(Icons.place)),
      Tab(icon: Icon(Icons.map)),
      Tab(icon: Icon(Icons.stream)),
    ],
    labelColor: Colors.yellow,
    unselectedLabelColor: Colors.white,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(width: 4.0, color: Colors.yellow),
      insets: EdgeInsets.symmetric(horizontal: 24.0),
    ),
  ),
),





          backgroundColor: const Color(0xFFFFFFFF),
        ),
        Positioned(
          top: 25,
          right: 8,
          child: Image.asset(
            'assets/images/logo.png',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }



}



// --- SHARED CLASSES ---

class Movie {
  final String title;
  final String imagePath;
  final String shortDescription;
  final String longDescription;
  final List<QuizQuestion> quiz;

  Movie(
    this.title,
    this.imagePath,
    this.shortDescription,
    this.longDescription,
    this.quiz,
  );
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class _MovieTile extends StatefulWidget {
  final Movie movie;

  const _MovieTile({required this.movie, Key? key}) : super(key: key);

  @override
  State<_MovieTile> createState() => _MovieTileState();
}

class _MovieTileState extends State<_MovieTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailPage(movie: widget.movie),
            ),
          );
        },
        child: Card(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        widget.movie.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.movie.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
              if (isHovered)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFffe648).withOpacity(0.8),
                        const Color(0xFF030154).withOpacity(0.4),
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.movie.shortDescription,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({required this.movie, Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  int correctAnswers = 0;
  int totalAnswered = 0;
  bool quizCompleted = false;

  void _handleAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        correctAnswers++;
      }
      totalAnswered++;
      
      if (totalAnswered == widget.movie.quiz.length) {
        quizCompleted = true;
      }
    });
  }

  void _navigateToTourTab() {
    // Navigate to the Tour tab (index 3) while keeping the HomeTabController's app bar
    DefaultTabController.of(context).animateTo(3); // Switch to Tour tab
    Navigator.pop(context); // Pop MovieDetailPage to return to HomeTabController
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.movie.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.movie.longDescription,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateToTourTab,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF030154),
              ),
              child: const Text('View Tour'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quiz:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
                Text(
                  '$correctAnswers/${widget.movie.quiz.length} correct answers',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...widget.movie.quiz.map((q) => QuizQuestionWidget(
                  question: q,
                  onAnswerSelected: _handleAnswer,
                )),
            if (quizCompleted)
              Container(
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFffe648),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Quiz finished!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF030154),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your score: $correctAnswers/${widget.movie.quiz.length}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF030154),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Percentage of correct answers: ${(correctAnswers / widget.movie.quiz.length * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF030154),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF030154),
                      ),
                      child: const Text('Go back to the home page'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
    );
  }
}

class QuizQuestionWidget extends StatefulWidget {
  final QuizQuestion question;
  final Function(bool isCorrect) onAnswerSelected;

  const QuizQuestionWidget({
    required this.question,
    required this.onAnswerSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<QuizQuestionWidget> createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {
  int? selectedIndex;
  bool showCorrectAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(widget.question.options.length, (index) {
              final option = widget.question.options[index];
              final isSelected = selectedIndex == index;
              final isCorrect = index == widget.question.correctAnswerIndex;
              Color? tileColor;
              IconData? icon;

              if (selectedIndex != null) {
                if (isCorrect) {
                  // Prawidłowa odpowiedź - zielone tło z ikoną check
                  tileColor = Colors.green.withOpacity(0.9);
                  icon = Icons.check;
                } else if (isSelected) {
                  // Błędna odpowiedź - czerwone tło z ikoną close
                  tileColor = Colors.redAccent.withOpacity(0.9);
                  icon = Icons.close;
                }
              }

              return ListTile(
                title: Text(
                  option,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                tileColor: tileColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                trailing: icon != null ? Icon(icon, color: Colors.white) : null,
                onTap: selectedIndex == null
                    ? () {
                        setState(() {
                          selectedIndex = index;
                          widget.onAnswerSelected(index == widget.question.correctAnswerIndex);
                        });
                      }
                    : null,
              );
            }),
            if (selectedIndex != null && selectedIndex != widget.question.correctAnswerIndex)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Correct answer: ${widget.question.options[widget.question.correctAnswerIndex]}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// --- TABS ---

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(41.1579, -8.6291);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    try {
      // Laad de afbeelding als bytes
      final ByteData data = await rootBundle.load('assets/images/marker.png');
      final Uint8List bytes = data.buffer.asUint8List();

      // Decodeer de afbeelding
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image image = frameInfo.image;

      // Stel de gewenste grootte in (bijv. 20x20 pixels)
      const double targetWidth = 80.0;
      const double targetHeight = 100.0;

      // Maak een PictureRecorder om de geschaalde afbeelding te tekenen
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final ui.Canvas canvas = ui.Canvas(recorder);
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, targetWidth, targetHeight),
        ui.Paint(),
      );

      // Converteer de geschaalde afbeelding naar bytes
      final ui.Image scaledImage = await recorder.endRecording().toImage(
        targetWidth.toInt(),
        targetHeight.toInt(),
      );
      final ByteData? scaledByteData = await scaledImage.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List scaledBytes = scaledByteData!.buffer.asUint8List();

      // Maak een BitmapDescriptor van de geschaalde afbeelding
      final BitmapDescriptor customIcon = BitmapDescriptor.fromBytes(scaledBytes);

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('custom_location'),
            position: const LatLng(41.1399624945, -8.60946178436),
            infoWindow: const InfoWindow(title: 'Bridge from the movie "Porto"'),
            icon: customIcon,
          ),
        );
        // Voeg de nieuwe marker toe
        _markers.add(
          Marker(
            markerId: const MarkerId('custom_location_porto_nights'),
            position: const LatLng(41.140407, -8.613042),
            infoWindow: const InfoWindow(title: 'Location from the movie "Porto Nights"'),
            icon: customIcon,
          ),
        );
        _markers.add(
          Marker(
            markerId: const MarkerId('Location from the movie "the porto affair".'),
            position: const LatLng(41.145395, -8.678727),
            infoWindow: const InfoWindow(title: 'Location from the movie "the porto affair".'),
            icon: customIcon,
          ),
        );
      });
    } catch (e) {
      print('Fout bij het laden van de aangepaste marker: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        markers: _markers,
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}

class MoviePage extends StatelessWidget {
  MoviePage({super.key});

  final List<Movie> movies = [
    Movie(
      'Porto',
      'https://m.media-amazon.com/images/S/pv-target-images/7bc5621e94413175ae2d0846c3a9d6f4e6e9c30128c5b8394c7a092942dbe3e6.jpg',
      'A fleeting romance in Porto.',
      'Porto (2016) is a romantic drama about a brief but intense love story set in the picturesque city of Porto.',
      [
        QuizQuestion(
          question: 'What is the main theme of the movie Porto?',
          options: ['Action', 'Romance', 'Horror', 'Science Fiction'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which year was Porto released?',
          options: ['2010', '2016', '2020', '2005'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Which city is the setting for Porto?',
          options: ['Lisbon', 'Madrid', 'Porto', 'Barcelona'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'Who directed the movie Porto?',
          options: ['Gabe Klinger', 'Steven Spielberg', 'Quentin Tarantino', 'Christopher Nolan'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Movie(
      'The Porto Affair',
      'https://static.spin.com/files/2019/05/Screen-Shot-2019-05-14-at-1.09.17-PM-1557853802.png',
      'A mystery in Porto’s streets.',
      'The Porto Affair (2020) is a fictional mystery film about a detective unraveling secrets in Porto’s historic district.',
      [
        QuizQuestion(
          question: 'What genre is The Porto Affair?',
          options: ['Romance', 'Mystery', 'Comedy', 'Fantasy'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which year was The Porto Affair set?',
          options: ['2015', '2020', '2010', '2025'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What is the main profession of the protagonist in The Porto Affair?',
          options: ['Chef', 'Detective', 'Artist', 'Teacher'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Which Porto landmark is featured in The Porto Affair?',
          options: ['Clérigos Tower', 'Eiffel Tower', 'Big Ben', 'Colosseum'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Movie(
      'Love by the Douro',
      'https://ilovedouro.pt/img/logo-i-love-douro.jpg',
      'A love story along the Douro River.',
      'Love by the Douro (2018) is a romantic film set along Porto’s Douro River, exploring love and cultural heritage.',
      [
        QuizQuestion(
          question: 'What is the primary setting of Love by the Douro?',
          options: ['Tagus River', 'Douro River', 'Seine River', 'Thames River'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What theme is central to Love by the Douro?',
          options: ['Adventure', 'Love', 'War', 'Horror'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which year was Love by the Douro released?',
          options: ['2015', '2018', '2021', '2012'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Which city is featured in Love by the Douro?',
          options: ['Porto', 'Lisbon', 'Faro', 'Braga'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Movie(
      'Porto Nights',
      'https://media.istockphoto.com/id/465130576/photo/port-portugal-skyline.jpg?s=612x612&w=0&k=20&c=MWThB1AbplZLqv7e8miuAa-Px1jMs6M5ih1qtHp5Uj0=',
      'A drama under Porto’s lights.',
      'Porto Nights (2019) is a drama about a group of friends navigating life and love in Porto’s vibrant nightlife.',
      [
        QuizQuestion(
          question: 'What is the main setting of Porto Nights?',
          options: ['Porto’s nightlife', 'Lisbon’s beaches', 'Madrid’s museums', 'Barcelona’s markets'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'What genre is Porto Nights?',
          options: ['Sci-Fi', 'Drama', 'Comedy', 'Thriller'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which year was Porto Nights released?',
          options: ['2017', '2019', '2022', '2014'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What is a key theme in Porto Nights?',
          options: ['Friendship', 'Time Travel', 'Espionage', 'Cooking'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildGridPage(context, movies, const Color(0xFFFFFFFF));
  }
}

class SeriesPage extends StatelessWidget {
  SeriesPage({super.key});

  final List<Movie> series = [
    Movie(
      'Santiago’s Path',
      'https://media.cntraveler.com/photos/578908eba3f6784a6a6125de/16:9/w_1280,c_limit/camino-de-santiago-trail-GettyImages-146582436.jpg',
      'A spiritual journey in Porto.',
      'Santiago’s Path (2022) is a series about pilgrims finding themselves in Porto, inspired by the Camino de Santiago.',
      [
        QuizQuestion(
          question: 'What is the main focus of Santiago’s Path?',
          options: ['Crime Investigation', 'Pilgrimage', 'Time Travel', 'Cooking Competition'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which year was Santiago’s Path released?',
          options: ['2018', '2020', '2022', '2024'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'Which city is a key setting in Santiago’s Path?',
          options: ['Lisbon', 'Porto', 'Faro', 'Braga'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What inspired Santiago’s Path?',
          options: ['World War II', 'Camino de Santiago', 'Industrial Revolution', 'Space Exploration'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Movie(
      'Porto Secrets',
      'https://www.bespeaking.com/wp-content/uploads/2019/10/Secrets.jpg',
      'A mystery in Porto’s alleys.',
      'Porto Secrets (2021) is a mystery series about hidden histories uncovered in Porto’s old town.',
      [
        QuizQuestion(
          question: 'What genre is Porto Secrets?',
          options: ['Romance', 'Mystery', 'Comedy', 'Fantasy'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which year was Porto Secrets released?',
          options: ['2019', '2021', '2023', '2017'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What is the main setting of Porto Secrets?',
          options: ['Porto’s old town', 'Lisbon’s markets', 'Madrid’s palaces', 'Barcelona’s beaches'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'What is uncovered in Porto Secrets?',
          options: ['New species', 'Hidden histories', 'Alien artifacts', 'Lost recipes'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Movie(
      'Douro Dreams',
      'https://cf.bstatic.com/xdata/images/city/square250/971982.jpg?k=b65c557258d14ccaf06765683a26d8f2bc5088d751af34e0986923daa72eab98&o=',
      'A family saga by the Douro.',
      'Douro Dreams (2020) is a drama series about a family’s legacy along Porto’s Douro River.',
      [
        QuizQuestion(
          question: 'What is the primary setting of Douro Dreams?',
          options: ['Tagus River', 'Douro River', 'Seine River', 'Thames River'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What genre is Douro Dreams?',
          options: ['Sci-Fi', 'Drama', 'Horror', 'Adventure'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which year was Douro Dreams released?',
          options: ['2018', '2020', '2022', '2016'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What is the main focus of Douro Dreams?',
          options: ['Space travel', 'Family legacy', 'Sports', 'Fashion'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Movie(
      'Porto Lights',
      'https://kinolorber.com/media_cache/userFiles/uploads/products/porto/full/738329229252.jpg',
      'A coming-of-age story.',
      'Porto Lights (2023) is a series about young adults finding their way in Porto’s vibrant cultural scene.',
      [
        QuizQuestion(
          question: 'What is the main theme of Porto Lights?',
          options: ['War', 'Coming-of-age', 'Espionage', 'Cooking'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which year was Porto Lights released?',
          options: ['2020', '2021', '2023', '2019'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'Which city is central to Porto Lights?',
          options: ['Porto', 'Lisbon', 'Coimbra', 'Faro'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'What is the cultural focus of Porto Lights?',
          options: ['Technology', 'Vibrant cultural scene', 'Agriculture', 'Mining'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildGridPage(context, series, const Color(0xFFFFFFFF));
  }
}

class PlacesPage extends StatelessWidget {
  PlacesPage({super.key});

  final List<Movie> places = [
    Movie(
      'Kathedraal van Porto',
      'https://cdn.visitportugal.com/sites/default/files/styles/encontre_detalhe_poi_destaque/public/mediateca/Porto_SeCatedral_660x371.jpg?itok=Vifwfxmr',
      'Gothic masterpiece.',
      'The Kathedraal van Porto is a historic monument in Porto, renowned for its distinctive Gothic architecture.',
      [
        QuizQuestion(
          question: 'What architectural style is the Kathedraal van Porto known for?',
          options: ['Baroque', 'Renaissance', 'Gothic', 'Modern'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'In which city is the Kathedraal van Porto located?',
          options: ['Lisbon', 'Faro', 'Porto', 'Braga'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'What is a notable feature of the Kathedraal van Porto?',
          options: ['Glass Dome', 'Gothic Cloister', 'Spiral Staircase', 'Marble Fountain'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What is the primary material used in the Kathedraal van Porto’s construction?',
          options: ['Wood', 'Granite', 'Brick', 'Steel'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Movie(
      'Palácio da Bolsa',
      'https://www.portugal.com/wp-content/uploads/2021/12/bolsa1-scaled.jpeg',
      'Architectural gem.',
      'Palácio da Bolsa, built in the 19th century, served as Porto’s stock exchange and showcases stunning architecture.',
      [
        QuizQuestion(
          question: 'What was the original function of Palácio da Bolsa?',
          options: ['Royal Palace', 'Stock Exchange', 'Museum', 'Library'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which century was Palácio da Bolsa built?',
          options: ['17th', '18th', '19th', '20th'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'Which city is home to Palácio da Bolsa?',
          options: ['Porto', 'Lisbon', 'Coimbra', 'Faro'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'What is a famous room in Palácio da Bolsa?',
          options: ['Crystal Hall', 'Arabian Room', 'Golden Chamber', 'Mirror Gallery'],
          correctAnswerIndex: 1,
        ),
      ],
    ),
    Movie(
      'Clérigos Tower',
      'https://www.discover-portugal.com/wp-content/uploads/2024/03/Clerigos-Tower-2-768x1024.jpg',
      'Iconic Porto landmark.',
      'Clérigos Tower is an 18th-century Baroque tower in Porto, known for its panoramic views and historical significance.',
      [
        QuizQuestion(
          question: 'What architectural style is Clérigos Tower known for?',
          options: ['Gothic', 'Baroque', 'Renaissance', 'Modern'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'In which century was Clérigos Tower built?',
          options: ['16th', '17th', '18th', '19th'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'What is a key feature of Clérigos Tower?',
          options: ['Underground tunnels', 'Panoramic views', 'Glass dome', 'Water fountain'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Which city is home to Clérigos Tower?',
          options: ['Porto', 'Lisbon', 'Faro', 'Braga'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Movie(
      'Livraria Lello',
      'https://thirdeyetraveller.com/wp-content/uploads/Livraria-Lello-Porto-36.jpg',
      'Historic bookstore.',
      'Livraria Lello is one of the world’s most beautiful bookstores, located in Porto, known for its neo-Gothic design.',
      [
        QuizQuestion(
          question: 'What is Livraria Lello primarily known as?',
          options: ['Museum', 'Bookstore', 'Church', 'Theater'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What architectural style is Livraria Lello known for?',
          options: ['Baroque', 'Neo-Gothic', 'Renaissance', 'Minimalist'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'Which city is home to Livraria Lello?',
          options: ['Porto', 'Lisbon', 'Coimbra', 'Faro'],
          correctAnswerIndex: 0,
        ),
        QuizQuestion(
          question: 'What is a famous feature of Livraria Lello?',
          options: ['Spiral staircase', 'Rooftop garden', 'Underground vault', 'Marble fountain'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildGridPage(context, places, const Color(0xFFFFFFFF));
  }
}

class TourPage extends StatefulWidget {
  final String? initialTour;

  const TourPage({super.key, this.initialTour});

  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  late String? selectedTour;

  @override
  void initState() {
    super.initState();
    selectedTour = null;
  }

  final Map<String, String> tours = {
    'Porto': '',
    'The Porto Affair': '',
    'Love by the Douro': '',
    'Porto Nights': ''
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tour selection buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.center,
                  children: tours.keys.map((tourName) {
                    final isSelected = selectedTour == tourName;
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedTour = tourName;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: isSelected ? const Color(0xFF030154) : Colors.white,
                        backgroundColor: isSelected ? const Color(0xFFffe648) : const Color(0xFF030154),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text(
                        tourName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Message indicating tours are coming soon
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tours coming soon.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
    );
  }
}

class StreamingPage extends StatefulWidget {
  const StreamingPage({super.key});

  @override
  State<StreamingPage> createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  final List<Map<String, String>> videos = [
    {
      'title': '27 Tips I Wish I Knew Before Visiting Porto, Portugal',
      'url': 'https://www.youtube.com/embed/ZK5TyUqk22M',
    },
    {
      'title': 'FC Porto Stadium Tour',
      'url': 'https://www.youtube.com/embed/ztPQ0CIFJtI',
    },
    {
      'title': 'Porto 4K drone view',
      'url': 'https://www.youtube.com/embed/7chyxBvCYd8',
    },
  ];

  late YoutubePlayerController _controller;
  String? selectedVideoId;

  @override
  void initState() {
    super.initState();
    final initialUrl = videos[0]['url']!.trim();
    selectedVideoId = YoutubePlayer.convertUrlToId(initialUrl);
    _controller = YoutubePlayerController(
      initialVideoId: selectedVideoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        showLiveFullscreenButton: false
      ),
    );
  }

  void _loadVideo(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url.trim());
    if (videoId != null) {
      setState(() {
        selectedVideoId = videoId;
        _controller.load(videoId);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900], // dark blue background
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        title: const Text(
          'Streaming',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.redAccent,
            
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    tileColor: Colors.indigo[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(
                      video['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(Icons.play_arrow, color: Colors.white70),
                    onTap: () => _loadVideo(video['url']!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // białe tło całego ekranu
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: const Color(0xFF030154),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Kafelek z informacjami użytkownika na środku
            Card(
              color: const Color(0xFF030154), // zmieniamy tło kafelka na biały
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFffe648), // kółko z ikoną na ten kolor
                      child: Icon(Icons.person, size: 50, color: Color(0xFF030154)),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Name: John',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'E-mail: johndoe@example.com',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Przycisk wylogowania na dole, wycentrowany
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log out'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF030154),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- HELPER FUNCTION ---

Widget _buildGridPage(BuildContext context, List<Movie> items, Color backgroundColor) {
  double screenWidth = MediaQuery.of(context).size.width;
  int crossAxisCount = screenWidth > 800 ? 4 : (screenWidth > 600 ? 3 : 2);

  return Container(
    color: backgroundColor,
    padding: const EdgeInsets.all(8.0),
    child: GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) => _MovieTile(movie: items[index]),
    ),
  );
}