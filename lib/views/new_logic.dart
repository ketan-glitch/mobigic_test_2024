import 'package:flutter/material.dart';

class WordSearchScreen extends StatefulWidget {
  const WordSearchScreen({super.key});

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  List<List<String>> grid = [];

  TextEditingController searchController = TextEditingController();

  List<List<bool>> highlightedGrid = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Search'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          buildGrid(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter word to search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => searchWord(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGrid() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: List.generate(
          grid.length,
          (i) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              grid[i].length,
              (j) => GestureDetector(
                onTap: () => toggleHighlight(i, j),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: highlightedGrid[i][j] ? Colors.yellow : Colors.white,
                  ),
                  child: Text(
                    grid[i][j],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toggleHighlight(int i, int j) {
    setState(() {
      highlightedGrid[i][j] = !highlightedGrid[i][j];
    });
  }

  void searchWord() {
    String searchText = searchController.text.toLowerCase();
    bool found = false;

    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        // Check horizontally
        if (searchHorizontal(i, j, searchText)) {
          found = true;
        }
        // Check vertically
        if (searchVertical(i, j, searchText)) {
          found = true;
        }
        // Check diagonally (south-east)
        if (searchDiagonal(i, j, searchText)) {
          found = true;
        }
      }
    }

    if (!found) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Word Not Found'),
            content: Text('The word "$searchText" is not present in the grid.'),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  bool searchHorizontal(int i, int j, String searchText) {
    if (j + searchText.length > grid[i].length) return false;

    String word = '';
    for (int k = 0; k < searchText.length; k++) {
      word += grid[i][j + k];
    }
    if (word.toLowerCase() == searchText) {
      highlightHorizontal(i, j, searchText.length);
      return true;
    }
    return false;
  }

  void highlightHorizontal(int i, int j, int length) {
    setState(() {
      for (int k = 0; k < length; k++) {
        highlightedGrid[i][j + k] = true;
      }
    });
  }

  bool searchVertical(int i, int j, String searchText) {
    if (i + searchText.length > grid.length) return false;

    String word = '';
    for (int k = 0; k < searchText.length; k++) {
      word += grid[i + k][j];
    }
    if (word.toLowerCase() == searchText) {
      highlightVertical(i, j, searchText.length);
      return true;
    }
    return false;
  }

  void highlightVertical(int i, int j, int length) {
    setState(() {
      for (int k = 0; k < length; k++) {
        highlightedGrid[i + k][j] = true;
      }
    });
  }

  bool searchDiagonal(int i, int j, String searchText) {
    if (i + searchText.length > grid.length || j + searchText.length > grid[i].length) return false;

    String word = '';
    for (int k = 0; k < searchText.length; k++) {
      word += grid[i + k][j + k];
    }
    if (word.toLowerCase() == searchText) {
      highlightDiagonal(i, j, searchText.length);
      return true;
    }
    return false;
  }

  void highlightDiagonal(int i, int j, int length) {
    setState(() {
      for (int k = 0; k < length; k++) {
        highlightedGrid[i + k][j + k] = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    createGrid(5, 5); // Change dimensions as needed
  }

  void createGrid(int m, int n) {
    List<String> alphabets = 'abcdefghijklmnopqrstuvwxyz'.split('');
    grid = List.generate(
      m,
      (i) => List.generate(
        n,
        (j) => alphabets[(i * n + j) % alphabets.length],
      ),
    );
    highlightedGrid = List.generate(m, (i) => List.generate(n, (j) => false));
  }
}
