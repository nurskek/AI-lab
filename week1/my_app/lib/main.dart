import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // const reduces the required work for the Garbage Collector
    // it doesn't rebuild
    return MaterialApp(
      title: 'Startup Name Generator',
      // change app's theme by configuring the ThemeData class
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const RandomWords(), // Scaffold was removed
    );
  }
}



class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}



// Most of the app's logic resides here⁠
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{}; // it's set
  final _biggerFont = const TextStyle(fontSize: 18);


  void _pushSaved() {
    // pushes the route to the Navigator's stack
    Navigator.of(context).push(
      // (context) => how does widget knows it location in relation to others? Well, it doesn't
      // whether State/StatelessWidget they are implementation of class Widget
      // Widget has method createElement() -> tracks where specific widget is
      // and createElements if a type of BuildContext. Therefore,
      // context -> shows us where widget is located

      // The content for the new page is built MaterialPageRoute's builder
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                )
              );
            }
          );

          final divided = tiles.isNotEmpty
            // divideTiles() method adds horizontal spacing between each ListTile
            ? ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList() // divided variable holds the final rows converted to a list by the convenience function, toList()
            : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // The ListView class provides a builder property, itemBuilder,
    return Scaffold(
      // Scaffold will provide a framework to implement the basic material design layout
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',)
        ]
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          // The itemBuilder callback is called once per suggested word pairing
          // places each suggestion into a ListTile row

          // odd row => adds a Divider widget to visually separate the entries
          if (i.isOdd) return const Divider();

          // Divide, returning an integer result
          final index = i ~/ 2;

          // even row => for the word pairing
          if (index >= _suggestions.length) {
            // _ means we can access this field  from anywhere else
            _suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = _saved.contains(_suggestions[index]); // boolean value

          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              // favorite, favorite_border is existing icon in class Icons
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if(alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            }
          );
        }
      ),
    );
  }
}