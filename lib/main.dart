import "dart:async";
import "dart:math";
import "package:flutter/material.dart";

void main() {
  runApp(const MemoryMatchApp());
}

class MemoryMatchApp extends StatelessWidget {
  const MemoryMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Memory Match",
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Arial",
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================
// EMOJI
// ============================================================

const List<String> allSymbols = [
  // Ekspresi
  "😀",
  "😂",
  "🥳",
  "😎",
  "🤩",
  "😈",
  "👻",
  "🤖",
  "👽",
  "🤔",
  "😴",
  "🤗",

  // Hewan
  "🐶",
  "🐱",
  "🐭",
  "🐹",
  "🐰",
  "🦊",
  "🐻",
  "🐼",
  "🐨",
  "🐯",
  "🦁",
  "🐮",
  "🐷",
  "🐸",
  "🐵",
  "🐔",
  "🐧",
  "🐦",
  "🦄",
  "🐝",
  "🦋",
  "🐢",
  "🐙",
  "🐠",

  // Buah
  "🍎",
  "🍐",
  "🍊",
  "🍋",
  "🍌",
  "🍉",
  "🍇",
  "🍓",
  "🫐",
  "🍒",
  "🍑",
  "🥝",
  "🥭",
  "🍍",
  "🥥",

  // Bunga dan tanaman
  "🌸",
  "🌺",
  "🌻",
  "🌹",
  "🌷",
  "🌼",
  "💐",
  "🪻",
  "🌱",
  "🌿",
  "🍀",
  "☘️",
  "🌴",
  "🌵",

  // Makanan
  "🍕",
  "🍔",
  "🍟",
  "🌭",
  "🍿",
  "🍩",
  "🍪",
  "🎂",
  "🍰",
  "🧁",
  "🍦",
  "🍫",
  "🍭",
  "🍬",
  "🍜",
  "🍣",
  "🍙",

  // Alam
  "🌈",
  "☀️",
  "🌙",
  "⭐",
  "🌟",
  "☁️",
  "❄️",
  "🔥",
  "🌊",
  "🌍",
  "⚡",

  // Benda dan hobi
  "⚽",
  "🏀",
  "🏈",
  "⚾",
  "🎸",
  "🎹",
  "🎨",
  "🎮",
  "🚗",
  "🚀",
  "✈️",
  "🚲",
  "🎁",
  "💎",
  "👑",
  "🎧",
  "📷",
  "🎯",
];

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCards = 12;

  final List<int> cardOptions = [
    4,
    6,
    8,
    10,
    12,
    14,
    16,
    18,
    20,
  ];

  final Map<int, int> highScores = {};

  void updateHighScore(int cardCount, int score) {
    final int currentBest = highScores[cardCount] ?? 0;

    if (score > currentBest) {
      setState(() {
        highScores[cardCount] = score;
      });
    }
  }

  void showHighScores() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "🏆 SKOR TERTINGGI",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 360,
            child: ListView.builder(
              itemCount: cardOptions.length,
              itemBuilder: (context, index) {
                final int cards = cardOptions[index];
                final int score = highScores[cards] ?? 0;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        "$cards",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      "$cards Kartu",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "$score",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("TUTUP"),
            ),
          ],
        );
      },
    );
  }

  void showHowToPlay() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "🎮 CARA BERMAIN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. Pilih jumlah kartu yang ingin dimainkan.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  "2. Tekan tombol MULAI BERMAIN.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  "3. Buka dua kartu untuk mencari emoji yang sama.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  "4. Pasangan yang benar akan tetap terbuka.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  "5. Pasangan yang salah akan tertutup kembali.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  "6. Semakin cepat menyelesaikan permainan, semakin besar bonus waktunya.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  "7. Kumpulkan skor setinggi mungkin! 🏆",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("MENGERTI"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A5AE0),
              Color(0xFF8E7CFF),
              Color(0xFFB39DFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    "🧠",
                    style: TextStyle(
                      fontSize: 70,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "MEMORY MATCH",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Uji ingatanmu dan temukan semua pasangan!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // PILIH JUMLAH KARTU
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "PILIH JUMLAH KARTU",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: cardOptions.map((cards) {
                            final bool selected =
                                selectedCards == cards;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCards = cards;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                width: 58,
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.15),
                                  borderRadius:
                                      BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: selected ? 2 : 1,
                                  ),
                                ),
                                child: Text(
                                  "$cards",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: selected
                                        ? const Color(0xFF6A5AE0)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // MULAI BERMAIN
                  // ==================================================

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GamePage(
                              totalCards: selectedCards,
                              onScore: updateHighScore,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:
                            const Color(0xFF6A5AE0),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "▶  MULAI BERMAIN",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ==================================================
                  // SKOR TERTINGGI
                  // ==================================================

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: showHighScores,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:
                            const Color(0xFF6A5AE0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "🏆  SKOR TERTINGGI",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ==================================================
                  // CARA BERMAIN
                  // ==================================================

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: showHowToPlay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:
                            const Color(0xFF6A5AE0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "❓  CARA BERMAIN",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "✨ Temukan semua pasangan!",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
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
}

// ============================================================
// GAME PAGE
// ============================================================

class GamePage extends StatefulWidget {
  final int totalCards;
  final void Function(int cardCount, int score) onScore;

  const GamePage({
    super.key,
    required this.totalCards,
    required this.onScore,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Random random = Random();

  List<String> cards = [];
  List<bool> flipped = [];
  List<bool> matched = [];

  int? firstIndex;
  int? secondIndex;

  bool checking = false;
  bool gameOver = false;
  bool scoreSaved = false;

  int score = 0;
  int moves = 0;
  int timeLeft = 0;

  Timer? timer;

  int get startingTime {
    switch (widget.totalCards) {
      case 4:
        return 30;
      case 6:
        return 40;
      case 8:
        return 50;
      case 10:
        return 60;
      case 12:
        return 70;
      case 14:
        return 80;
      case 16:
        return 90;
      case 18:
        return 100;
      case 20:
        return 110;
      default:
        return 70;
    }
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startGame() {
    timer?.cancel();

    final int pairCount = widget.totalCards ~/ 2;

    final List<String> shuffled =
        List<String>.from(allSymbols)..shuffle(random);

    final List<String> selected =
        shuffled.take(pairCount).toList();

    cards = [
      ...selected,
      ...selected,
    ]..shuffle(random);

    flipped =
        List<bool>.filled(widget.totalCards, false);

    matched =
        List<bool>.filled(widget.totalCards, false);

    firstIndex = null;
    secondIndex = null;

    checking = false;
    gameOver = false;
    scoreSaved = false;

    score = 0;
    moves = 0;
    timeLeft = startingTime;

    setState(() {});

    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted || gameOver) {
          timer.cancel();
          return;
        }

        if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        }

        if (timeLeft <= 0) {
          timer.cancel();
          endGame(false);
        }
      },
    );
  }

  void tapCard(int index) {
    if (gameOver ||
        checking ||
        flipped[index] ||
        matched[index]) {
      return;
    }

    setState(() {
      flipped[index] = true;
    });

    if (firstIndex == null) {
      firstIndex = index;
    } else {
      secondIndex = index;
      moves++;
      checkMatch();
    }
  }

  void checkMatch() {
    if (firstIndex == null || secondIndex == null) {
      return;
    }

    checking = true;

    final int first = firstIndex!;
    final int second = secondIndex!;

    Future.delayed(
      const Duration(milliseconds: 700),
      () {
        if (!mounted || gameOver) {
          return;
        }

        if (cards[first] == cards[second]) {
          setState(() {
            matched[first] = true;
            matched[second] = true;
            score += 10;
          });

          firstIndex = null;
          secondIndex = null;
          checking = false;

          if (matched.every((value) => value)) {
            endGame(true);
          }
        } else {
          setState(() {
            flipped[first] = false;
            flipped[second] = false;

            score -= 2;

            if (score < 0) {
              score = 0;
            }
          });

          firstIndex = null;
          secondIndex = null;
          checking = false;
        }
      },
    );
  }

  void endGame(bool won) {
    if (gameOver) {
      return;
    }

    timer?.cancel();

    final int finalScore =
        score + (won ? timeLeft : 0);

    if (!scoreSaved) {
      widget.onScore(
        widget.totalCards,
        finalScore,
      );

      scoreSaved = true;
    }

    setState(() {
      gameOver = true;
    });

    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        if (mounted) {
          showResultDialog(
            won,
            finalScore,
          );
        }
      },
    );
  }

  void showResultDialog(
    bool won,
    int finalScore,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Column(
            children: [
              Text(
                won ? "🏆" : "⏰",
                style: const TextStyle(
                  fontSize: 55,
                ),
              ),
              Text(
                won ? "HEBAT!" : "WAKTU HABIS",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "SKOR AKHIR",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "$finalScore",
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Gerakan",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "$moves",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Waktu",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "${timeLeft}s",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Text(
                "Jumlah kartu: ${widget.totalCards}",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          actionsAlignment:
              MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  startGame();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "🔄  MAIN LAGI",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  "🏠  MENU UTAMA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int get gridColumns {
    if (widget.totalCards <= 6) {
      return 2;
    } else if (widget.totalCards <= 12) {
      return 3;
    } else if (widget.totalCards <= 16) {
      return 4;
    } else {
      return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        timeLeft / startingTime;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1FF),
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF6A5AE0),
        foregroundColor: Colors.white,
        title: Text(
          "${widget.totalCards} KARTU",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Mulai ulang",
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title:
                        const Text("🔄 Mulai Ulang?"),
                    content: const Text(
                      "Permainan saat ini akan dimulai dari awal.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:
                            const Text("BATAL"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          startGame();
                        },
                        child:
                            const Text("ULANGI"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // STATISTIK
            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                12,
                12,
                5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: StatBox(
                      icon: "⭐",
                      title: "SKOR",
                      value: "$score",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatBox(
                      icon: "🎯",
                      title: "GERAKAN",
                      value: "$moves",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatBox(
                      icon: "⏱️",
                      title: "WAKTU",
                      value: "${timeLeft}s",
                    ),
                  ),
                ],
              ),
            ),

            // PROGRESS TIMER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value:
                      progress.clamp(0.0, 1.0),
                  minHeight: 7,
                  backgroundColor:
                      Colors.black12,
                ),
              ),
            ),

            const SizedBox(height: 5),

            // GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  physics:
                      const BouncingScrollPhysics(),
                  itemCount: cards.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        gridColumns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder:
                      (context, index) {
                    return FlipCard(
                      symbol: cards[index],
                      isFlipped:
                          flipped[index] ||
                              matched[index],
                      isMatched:
                          matched[index],
                      onTap: () {
                        tapCard(index);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STAT BOX
// ============================================================

class StatBox extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const StatBox({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            icon,
            style: const TextStyle(
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FLIP CARD 3D
// ============================================================

class FlipCard extends StatelessWidget {
  final String symbol;
  final bool isFlipped;
  final bool isMatched;
  final VoidCallback onTap;

  const FlipCard({
    super.key,
    required this.symbol,
    required this.isFlipped,
    required this.isMatched,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: isFlipped ? 1 : 0,
        ),
        duration:
            const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
        builder:
            (context, value, child) {
          final double angle = value * pi;
          final bool isBack = value < 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: isBack
                ? buildBack()
                : Transform(
                    alignment:
                        Alignment.center,
                    transform:
                        Matrix4.identity()
                          ..rotateY(pi),
                    child: buildFront(),
                  ),
          );
        },
      ),
    );
  }

  Widget buildBack() {
    return Container(
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6A5AE0),
            Color(0xFF8E7CFF),
          ],
        ),
        borderRadius:
            BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.15),
            blurRadius: 7,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          "?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildFront() {
    return Container(
      decoration: BoxDecoration(
        color: isMatched
            ? const Color(0xFFE7F8EA)
            : Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: isMatched
              ? Colors.green
              : Colors.black12,
          width: isMatched ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.10),
            blurRadius: 7,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: AnimatedScale(
          scale: isMatched ? 1.1 : 1.0,
          duration:
              const Duration(milliseconds: 250),
          child: Text(
            symbol,
            style: const TextStyle(
              fontSize: 38,
            ),
          ),
        ),
      ),
    );
  }
}
