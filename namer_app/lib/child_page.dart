import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'login_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';


class ChildPage extends StatelessWidget {
  const ChildPage({super.key});

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

// --- TABS ---//
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(38.7167, -9.1333); // Lissabon als centrum van Portugal
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
            position: const LatLng(41.528428, -8.613590),
            infoWindow: const InfoWindow(title: 'The Legend of the Rooster of Barcelos'),
            icon: customIcon,
          ),
        );
        // Voeg de nieuwe marker toe
        _markers.add(
          Marker(
            markerId: const MarkerId('custom_location_estrela'),
            position: const LatLng(38.703640, -9.168070),
            infoWindow: const InfoWindow(title: 'The Legend of the Serra da Estrela'),
            icon: customIcon,
          ),
        );
        _markers.add(
          Marker(
            markerId: const MarkerId('custom_location_Moorish_Maiden'),
            position: const LatLng(41.143948, -8.655337),
            infoWindow: const InfoWindow(title: 'The Legend of the Moorish Maiden'),
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
          target: _center, // Centrum op Lissabon
          zoom: 6.5, // Zoomniveau aangepast om heel Portugal te zien
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
      'The Legend of the Rooster of Barcelos',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/PA2900302_galo_emiliarocha_medio.jpg/1200px-PA2900302_galo_emiliarocha_medio.jpg',
      'Portugese legend',
      'A pilgrim is wrongly accused of theft and sentenced to hang. He declares that a roasted rooster will crow if he’s innocent—and it does, proving his innocence.',
      [
        QuizQuestion(
          question: 'Why was the pilgrim in Barcelos accused of a crime?',
          options: ['He stole money from the church.', 'He was mistaken for a thief who robbed a local farmer.', 'He refused to help the townspeople.', 'He insulted the judge.'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What was the pilgrim doing when he was arrested?',
          options: ['Praying at a church', 'Begging for food', 'On his way to Santiago de Compostela', 'Selling goods at the market'],
          correctAnswerIndex: 2,
        ),
        QuizQuestion(
          question: 'Where was the roasted rooster when it miraculously crowed?',
          options: ['In the town square', "On the judge's dinner table", 'At the execution site', "In the pilgrim's bag"],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What did the pilgrim create after being freed?',
          options: ['The Cruzeiro do Senhor do Galo', 'A statue of the Virgin Mary', 'A painting of the miracle', 'A new church in Barcelos'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Movie(
      'The Legend of the Serra da Estrela',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK520mujTATtqoHzVEIQZTXsD_kToBwdYFbQ&s',
      'Touching Portugese fairy tale',
      'A shepherd falls in love with a star that descends from the sky. When he tries to reach her, she returns to the heavens, leaving behind the mountain range named in her honor.',
      [
        QuizQuestion(
          question: "What was the shepherd's occupation?",
          options: ['Blacksmith', 'Shepherd', 'Farmer', 'Miner'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'How did the star first appear to the shepherd?',
          options: ['As a bright light in the sky', 'As a voice in the wind', 'As a reflection in water', 'As a beautiful woman'],
          correctAnswerIndex: 3,
        ),
        QuizQuestion(
          question: 'What happened when the shepherd tried to touch the star?',
          options: ['She turned into gold', ' She returned to the sky', 'She disappeared forever', 'She cursed himeacher'],
          correctAnswerIndex: 1,
        ),
        QuizQuestion(
          question: 'What natural feature was created from this legend?',
          options: ['A mountain range', 'A river', 'A lake', 'A forest'],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    Movie(
      'The Enchanted Moorish Maiden',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2m74WXP6b22LFSCsrz71qJNFbNalH6Xztiw&s',
      'A beautiful story about beautiful princess',
      'A beautiful Moorish princess is cursed to live in a hidden cave, guarding a treasure. Only a pure-hearted knight can break the spell by resisting greed.',
      [
      QuizQuestion(
        question: "What is the Moorish maiden guarding?",
        options: [
          'A sacred book',
          'A treasure',
          'A magic fountain',
          'A royal crown'
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: 'What is the condition to break the spell?',
        options: [
          'Solving a riddle',
          'Resisting greed',
          'Finding a golden key',
          'Staying silent for a year'
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: 'Where does the maiden live?',
        options: [
          'In a hidden cave',
          'In an underwater palace',
          'In a tower',
          'In a magical forest'
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'What happens if someone fails to break the spell?',
        options: [
          'They become stone',
          'They join the maiden in guarding',
          'They lose their memory',
          'They become cursed'
        ],
        correctAnswerIndex: 3,
      ),
    ],
    ),
    Movie(
      'The Miracle of the Roses',
      'https://wp.en.aleteia.org/wp-content/uploads/sites/2/2017/11/web3-saint-elizabeth-of-hungary-chairty-for-poor-roses-public-domain.jpg',
      'Story about loyality',
      'Queen Isabel, secretly carrying bread for the poor, is confronted by her husband. When she opens her cloak, the bread has turned into roses, proving her virtue.',
      [
  QuizQuestion(
    question: "Who was Queen Isabel helping?",
    options: [
      'The royal court',
      'The poor',
      'Wounded soldiers',
      'Orphaned children'
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'What was she secretly carrying?',
    options: [
      'Gold coins',
      'Bread',
      'Medicine',
      'Important documents'
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'Who confronted her about her secret actions?',
    options: [
      'Her ladies-in-waiting',
      'The king',
      'The archbishop',
      'The castle guards'
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'What happened when she opened her cloak?',
    options: [
      'The bread turned to gold',
      'The bread turned to roses',
      'The bread disappeared',
      'The bread multiplied'
    ],
    correctAnswerIndex: 1,
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
  'Portuguese Numbers',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfdRGeZ1Ne0TU6mTGCAl6mey3ultvve2rxsQ&s',
  'Learn how to count in Portuguese!',
  'This quiz will test your understanding of numbers in Portuguese, from 1 to 10 and beyond.',
  [
    QuizQuestion(
      question: 'How do you say "one" in Portuguese?',
      options: ['Dois', 'Três', 'Um', 'Quatro'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'What is the Portuguese word for "five"?',
      options: ['Sete', 'Cinco', 'Nove', 'Dez'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'How is "ten" pronounced in Portuguese?',
      options: ['Seis', 'Oito', 'Dez', 'Três'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'Which of these means "seven" in Portuguese?',
      options: ['Sete', 'Quatro', 'Cinco', 'Dois'],
      correctAnswerIndex: 0,
    ),
  ],
),
    Movie(
  'Animals in Portuguese',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQn-KrgYGceicAfd2TulAH6OWdN1UX6KDlTog&s',
  'Learn the names of animals in Portuguese!',
  'This quiz covers common and unique animals found in Portugal and their Portuguese names.',
  [
    QuizQuestion(
      question: 'What is "dog" in Portuguese?',
      options: ['Gato', 'Cão', 'Pássaro', 'Peixe'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'Which animal is called "lobo" in Portuguese?',
      options: ['Fox', 'Wolf', 'Bear', 'Deer'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'What is the Portuguese word for "bird"?',
      options: ['Cavalo', 'Pássaro', 'Vaca', 'Coelho'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'Which of these is the Iberian Lynx called in Portuguese?',
      options: ['Lobo-Ibérico', 'Lince-Ibérico', 'Tigre-Português', 'Leão-da-Península'],
      correctAnswerIndex: 1,
    ),
  ],
),
    Movie(
  'Famous Portuguese Landmarks',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQR3Gc77OF8A2hSUZQ62Irprw5RhiB2xKuCbA&s',
  'Test your knowledge of Portugal’s most famous landmarks!',
  'This quiz covers UNESCO sites, historic buildings, and natural wonders in Portugal.',
  [
    QuizQuestion(
      question: 'Which famous tower is a symbol of Lisbon?',
      options: ['Torre dos Clérigos', 'Torre dos Clérigos', 'Castelo de São Jorge', 'Ponte Vasco da Gama'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'Where is the Instituto Superior Politécnico Gaya located?',
      options: ['Porto', 'Braga', 'Vila Nova de Gaia', 'Faro'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'Which Portuguese landmark is a medieval castle in Sintra?',
      options: ['Palácio da Pena', 'Castelo dos Mouros', 'Mosteiro dos Jerónimos', 'Convento de Cristo'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'What is the name of Portugal’s longest bridge?',
      options: ['Ponte 25 de Abril', 'Ponte Vasco da Gama', 'Ponte Dom Luís I', 'Ponte da Arrábida'],
      correctAnswerIndex: 1,
    ),
  ],
),
Movie(
  'Traditional Portuguese Dishes',
  'https://media.posterlounge.com/img/products/770000/765525/765525_poster.jpg',
  'How well do you know Portuguese food?',
  'This quiz tests your knowledge of Portugal’s most famous dishes and ingredients.',
  [
    QuizQuestion(
      question: 'What is "Bacalhau" in English?',
      options: ['Pork', 'Sardines', 'Codfish', 'Octopus'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'Which dish is a famous Portuguese custard tart?',
      options: ['Pastel de Nata', 'Bolo de Bolacha', 'Arroz Doce', 'Queijada'],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: 'What is "Francesinha," a famous dish from Porto?',
      options: ['A seafood stew', 'A sandwich with melted cheese and sauce', 'A type of sausage', 'A sweet pastry'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: 'Which soup is a traditional Portuguese bread soup?',
      options: ['Caldo Verde', 'Açorda', 'Sopa da Pedra', 'Canja de Galinha'],
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
      'title': 'The Legend of the Rooster of Barcelos ',
      'url': 'https://www.youtube.com/embed/l0hcXUL6Mms',
    },
    {'title': 'The Legend of the Serra da Estrela ',
      'url': 'https://www.youtube.com/embed/kkloCWhfiK4'},
    {
      'title': 'Numbers • Childrens First Words • Portuguese',
      'url': 'https://www.youtube.com/embed/TwbXFMLptRQ',
    },
    {
      'title': 'Farm animals • Childrens First Words • Portuguese',
      'url': 'https://www.youtube.com/embed/wKxQDJNHJeo',
    },
    {
      'title': '27 Tips I Wish I Knew Before Visiting Porto, Portugal',
      'url': 'https://www.youtube.com/embed/ZK5TyUqk22M',
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