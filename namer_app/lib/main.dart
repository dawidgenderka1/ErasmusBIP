import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Movie> movies = [
  Movie(
    'Inception',
    'assets/images/flutter1.jpg',
    'A mind-bending thriller about dreams within dreams.',
    'Inception is a 2010 science fiction action film written and directed by Christopher Nolan. It explores the concept of dreams within dreams, and the idea of planting ideas into people\'s subconscious minds through a process called inception.',
    [
      QuizQuestion(
        question: 'Who directed Inception?',
        options: ['Christopher Nolan', 'Steven Spielberg', 'James Cameron', 'Quentin Tarantino'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'What is the main theme of Inception?',
        options: ['Time travel', 'Dream infiltration', 'Space exploration', 'Superpowers'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  Movie(
    'The Matrix',
    'assets/images/flutter2.jpg',
    'A hacker discovers reality is a simulation.',
    'Inception is a 2010 science fiction action film written and directed by Christopher Nolan. It explores the concept of dreams within dreams, and the idea of planting ideas into people\'s subconscious minds through a process called inception.',
    [
      QuizQuestion(
        question: 'Who directed Inception?',
        options: ['Christopher Nolan', 'Steven Spielberg', 'James Cameron', 'Quentin Tarantino'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'What is the main theme of Inception?',
        options: ['Time travel', 'Dream infiltration', 'Space exploration', 'Superpowers'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  Movie(
    'Interstellar',
    'assets/images/flutter3.jpg',
    'Explorers travel through a wormhole in space.',
    'Inception is a 2010 science fiction action film written and directed by Christopher Nolan. It explores the concept of dreams within dreams, and the idea of planting ideas into people\'s subconscious minds through a process called inception.',
    [
      QuizQuestion(
        question: 'Who directed Inception?',
        options: ['Christopher Nolan', 'Steven Spielberg', 'James Cameron', 'Quentin Tarantino'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'What is the main theme of Inception?',
        options: ['Time travel', 'Dream infiltration', 'Space exploration', 'Superpowers'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  Movie(
    'The Dark Knight',
    'assets/images/flutter4.jpg',
    'Batman faces his greatest enemy, the Joker.',
    'Inception is a 2010 science fiction action film written and directed by Christopher Nolan. It explores the concept of dreams within dreams, and the idea of planting ideas into people\'s subconscious minds through a process called inception.',
    [
      QuizQuestion(
        question: 'Who directed Inception?',
        options: ['Christopher Nolan', 'Steven Spielberg', 'James Cameron', 'Quentin Tarantino'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'What is the main theme of Inception?',
        options: ['Time travel', 'Dream infiltration', 'Space exploration', 'Superpowers'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
];



  @override
  Widget build(BuildContext context) {
    // Uzyskujemy szerokość ekranu
    double screenWidth = MediaQuery.of(context).size.width;

    // Określamy liczbę kafelków w rzędzie na podstawie szerokości ekranu
    int crossAxisCount = screenWidth > 800 ? 4 : (screenWidth > 600 ? 3 : 2);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // Zmienna liczba kafelków w zależności od szerokości
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7, // Proporcje kafelka
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieTile(movie: movie);
          },
        ),
      ),
    );
  }
}

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




class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Zdjęcie
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                movie.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Długi opis
            Text(
              movie.longDescription,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            // Quiz
            Text(
              'Quiz:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...movie.quiz.map((q) => QuizQuestionWidget(question: q)).toList(),
          ],
        ),
      ),
    );
  }
}

class QuizQuestionWidget extends StatefulWidget {
  final QuizQuestion question;

  const QuizQuestionWidget({required this.question, Key? key}) : super(key: key);

  @override
  State<QuizQuestionWidget> createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {
  int? selectedIndex;

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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...List.generate(widget.question.options.length, (index) {
              final option = widget.question.options[index];
              final isSelected = selectedIndex == index;
              final isCorrect = index == widget.question.correctAnswerIndex;
              Color? tileColor;

              if (selectedIndex != null) {
                if (isSelected && isCorrect) {
                  tileColor = Colors.greenAccent;
                } else if (isSelected && !isCorrect) {
                  tileColor = Colors.redAccent;
                }
              }

              return ListTile(
                title: Text(option),
                tileColor: tileColor,
                onTap: selectedIndex == null
                    ? () {
                        setState(() {
                          selectedIndex = index;
                        });
                      }
                    : null,
              );
            }),
          ],
        ),
      ),
    );
  }
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
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: isHovered
                        ? Container(
                            key: ValueKey('description'),
                            color: Colors.deepOrange.shade100,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.movie.shortDescription,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Image.asset(
  widget.movie.imagePath,
  key: ValueKey('image'),
  fit: BoxFit.cover,
)

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.movie.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


