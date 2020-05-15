import 'package:flutter/material.dart';
import 'package:hangman/model/theWords.dart';
import 'package:hangman/start/words.dart';
import 'package:hangman/utils/database_helper.dart';

class WordList extends StatefulWidget {
  @override
  WordListState createState() => WordListState();
}

class WordListState extends State<WordList> {
  String _string;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Words> _listOfWords = [];

  List<Widget> get _items => _listOfWords.map((item) => format(item)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Words'),
          leading: IconButton(icon:
          Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                _deleteAll();
              },
            )
          ],
        ),
        body: Center(
            child: ListView
              (
                children: _items
            ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _create(context);
          },
          tooltip: 'Add New Word',
          child: Icon(Icons.add),
        )
    );
  }

  Widget format(Words item) {
    return Container(
      height: 70,
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          title: Text(item.word,textScaleFactor: 1.35,),
          trailing: GestureDetector(
            child: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onTap: () {
              _delete(item);
            },
          ),
          onTap: () => null,
        ),
      ),
    );
  }

  void _delete(Words word) async {
    DB.delete(Words.table, word);
    displaySnackBar('Word deleted successfully');
    refresh();
  }

  void _save() async {
    Navigator.of(context).pop();

    if(_string.contains(" ")) {
        displaySnackBar('Word should not contain spaces');
        return ;
      }

    if ((_string.trim().length != 0) && (_string != null)) {
      Words item = Words(
        word: _string.toLowerCase(),
      );
      try{
        await DB.insert(Words.table, item);
        displaySnackBar('Word added successfully');
      }
      catch(e) {
      displaySnackBar('Word already exists');
    }
      setState(() => _string = '');
      refresh();
    }
    else {
        displaySnackBar('Word should not be empty or null');
      }
  }

  void _create(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add New Word"),
            actions: <Widget>[
              FlatButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop()),
              FlatButton(
                  child: Text('Save'),
                  onPressed: () => _save())
            ],
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Word',
                hintText: 'Enter new word to be added'
              ),
              onChanged: (value) {
                _string = value;
              },
            ),
          );
        });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(Words.table);
    _listOfWords = _results.map((item) => Words.fromMap(item)).toList();
    setState(() {
      GuessWordHelper().generateWords();
    });
  }

  void displaySnackBar(String message)
  {
    final snackBar = SnackBar(content: Text(message),duration: Duration(seconds: 1),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> _deleteAll()
  async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are You Sure You Want to Delete All Words"),
            actions: <Widget>[
              FlatButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop()),
              FlatButton(
                  child: Text('Yes'),
                  onPressed: () async {
                    Navigator.of(context).pop();

                    List<Map<String, dynamic>> _results = await DB.query(Words.table);
                    List<Words> _listOfWords =
                    _results.map((item) => Words.fromMap(item)).toList();
                    for (Words i in _listOfWords) {
                      DB.delete(Words.table, i);
                    }

                    displaySnackBar('All words have been successfully deleted');
                    refresh();
                  })
            ],
            content: Text('This action cannot be Undone')
          );
        });
  }
}
