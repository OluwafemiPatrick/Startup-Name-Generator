import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = TextStyle(
      fontSize: 18,);
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StartUp Name Generator"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestion(),
    );}

  Widget _buildSuggestion(){
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i){
          if(i.isOdd){
            return Divider();}
          final int index = i ~/ 2;
          if (index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));}
          return _buildRow(_suggestions[index]);
        }
    );}

    Widget _buildRow(WordPair pair){
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          //the alreadySaved boolean is called; if true, Icons.favorite and Colors.red
          // is added. If false;
          // Icons.favorite_boarder and Colors.grey is added.
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : Colors.black,
        ),
        onTap: (){
          setState(() {
            if (alreadySaved){
              _saved.remove(pair);
            }else{
              _saved.add(pair);
            }
          });
        },
    );}

    void _pushSaved(){
      Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context){
              final Iterable<ListTile> tiles = _saved.map((WordPair pair){
                    return ListTile(
                      title: Text(
                        pair.asPascalCase,
                        style: _biggerFont,
                      ),
                    );
                  }
              );

              final List<Widget> divided = ListTile.divideTiles(
                tiles: tiles,
                context: context).toList();

              return Scaffold(
                appBar: AppBar(
                  title: Text("Saved Suggestions"),
              ),
              body: ListView(children: divided),
              );
            }
          )
      );
    }

}
