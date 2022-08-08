import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SelectingPage(),
      routes: <String, WidgetBuilder>{
        "/selecting": (BuildContext context) => new SelectingPage(),
        "/custom": (BuildContext context) => new CustomPage(),
        "/pictureBook": (BuildContext context) => new PictureBook()
      },
    );
  }
}

class SelectingPage extends StatefulWidget {
  const SelectingPage({Key? key}) : super(key: key);

  @override
  State<SelectingPage> createState() => _SelectingPageState();
}

class _SelectingPageState extends State<SelectingPage> {
  var _appBarColor = Colors.green;
  var _selectedPokemon = "hushigidane";

  @override
  Widget build(BuildContext context) {
    const firstPokemon1 = ["hushigidane", "hitokage", "zenigame"];
    const secretPokemon = "ピカチュウ";
    const pokemonColor = [Colors.green, Colors.red, Colors.blue];

    final _tab = <Tab>[
      Tab(text: firstPokemon1[0], icon: Icon(Icons.grass)),
      Tab(
          text: firstPokemon1[1],
          icon: Icon(Icons.local_fire_department_sharp)),
      Tab(text: firstPokemon1[2], icon: Icon(Icons.water_drop_sharp))
    ];

    return DefaultTabController(
      length: firstPokemon1.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Select First Pokemon",
            style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
          ),
          backgroundColor: _appBarColor,
          bottom: TabBar(
            tabs: _tab,
            onTap: (index) {
              setState(() {
                _appBarColor = pokemonColor[index];
                _selectedPokemon = firstPokemon1[index];
                debugPrint(index.toString());
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            TabPage(
              pokemonName: firstPokemon1[0],
            ),
            TabPage(
              pokemonName: firstPokemon1[1],
            ),
            TabPage(
              pokemonName: firstPokemon1[2],
            )
          ],
        ),
        floatingActionButton: Align(
          alignment: Alignment(0.6, 0.8),
          child: IconButton(
            icon: Icon(
              Icons.catching_pokemon,
              color: Colors.red,
              size: 100,
            ),
            onPressed: () => Navigator.of(context)
                .pushNamed("/custom", arguments: _selectedPokemon),
          ),
        ),
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  final String? pokemonName;

  const TabPage({Key? key, this.pokemonName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("Images/$pokemonName.png"),
    );
  }
}

class PictureBook extends StatelessWidget {
  final String? pokemonName;
  final String? nickname;
  final double? size;
  const PictureBook({Key? key, this.pokemonName, this.nickname, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String, String> firstPokemonDescription = {
      "hushigidane": "うまれてから　しばらくの　あいだは　せなかの　タネから　えいようを　もらって　おおきく　そだつ",
      "hitokage": "ヒトカゲの　しっぽの　ほのおは　いのちの　ともしび。　げんきな　ときは　ほのおも　ちからづよく　もえあがる。",
      "zenigame": "こうらに　とじこもり　みを　まもる。　あいての　すきを　みのがさず　みずを　ふきだして　はんげきする。"
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon Picture Book"),
        backgroundColor: Colors.orange,
      ),
      body: pokemonDetail(),
    );
  }

  Widget pokemonDetail() {
    return Column(
      children: [statusWithPicture(), description()],
    );
  }

  Widget statusWithPicture() {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              child: Image.asset("Images/$pokemonName.png"),
              width: 150,
              height: 150,
            ),
          ),
          flex: 7,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: basicStatus(),
          ),
          flex: 8,
        )
      ],
    );
  }

  Widget basicStatus() {
    return Column();
  }

  Widget description() {
    return Text("うまれてから　しばらくの　あいだは　せなかの　タネから　えいようを　もらって　おおきく　そだつ");
  }

  void setDescription(String pokemonName) {
    if pokemonName == "hushigidane" {
      return Text(firstPokemonDescription[pokemonName]);
    }
  }
}

class CustomPage extends StatefulWidget {
  const CustomPage({Key? key}) : super(key: key);

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  var _toggleList = <bool>[true, false];
  var _selectedSexIcon = Icon(Icons.male_sharp, color: Colors.lightBlueAccent);
  var _nickname = "";
  var _level = 5.0;
  var _size = 50.0;
  var _imageWidth = 150.0;
  var _imageHeight = 150.0;
  var _selectedPokemonName = "";
  var _imageAlignment = Alignment.center;
  var _visible = true;

  @override
  Widget build(BuildContext context) {
    _selectedPokemonName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Custom Your Pokemon"),
          backgroundColor: ifPokemonColor(),
        ),
        body: customPageBody());
  }

  Widget customPageBody() {
    return Column(
      children: [
        Expanded(
          child: Align(
              alignment: _imageAlignment,
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                child: Image.asset("Images/$_selectedPokemonName.png"),
                width: _imageWidth * _size / 50,
                height: _imageHeight * _size / 50,
              )),
          flex: 10,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: _visible,
              child: customizes(),
            ),
          ),
          flex: 11,
        )
      ],
    );
  }

  Widget customizes() {
    return Column(
      children: [
        sexCustomize(),
        nameCustomize(),
        levelCustomize(),
        sizeCustomize(),
        SizedBox(height: 70),
        finishCustomButton()
      ],
    );
  }

  Widget sexCustomize() {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text("性別"),
          ),
          flex: 2,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: _selectedSexIcon,
          ),
          flex: 2,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: ToggleButtons(
              isSelected: _toggleList,
              children: [
                Icon(Icons.male_sharp, color: Colors.lightBlueAccent),
                Icon(Icons.female_sharp, color: Colors.redAccent)
              ],
              onPressed: (index) {
                setState(() {
                  if (index == 0) {
                    _toggleList[0] = true;
                    _toggleList[1] = false;
                    _selectedSexIcon =
                        Icon(Icons.male_sharp, color: Colors.lightBlueAccent);
                  } else {
                    _toggleList[0] = false;
                    _toggleList[1] = true;
                    _selectedSexIcon =
                        Icon(Icons.female_sharp, color: Colors.redAccent);
                  }
                });
              },
            ),
          ),
          flex: 3,
        )
      ],
    );
  }

  Widget nameCustomize() {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text("ニックネーム"),
          ),
          flex: 2,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(_nickname),
          ),
          flex: 2,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextField(
              onSubmitted: (String newValue) {
                setState(() {
                  _nickname = newValue;
                });
              },
            ),
          ),
          flex: 3,
        )
      ],
    );
  }

  Widget levelCustomize() {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text("レベル"),
          ),
          flex: 2,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(_level.toStringAsFixed(0)),
          ),
          flex: 2,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Slider(
              value: _level,
              min: 1.0,
              max: 100.0,
              onChanged: (double newValue) {
                setState(() {
                  _level = newValue;
                });
              },
            ),
          ),
          flex: 3,
        )
      ],
    );
  }

  Widget sizeCustomize() {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text("サイズ"),
          ),
          flex: 2,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(_size.toStringAsFixed(0)),
          ),
          flex: 2,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Slider(
              value: _size,
              min: 1.0,
              max: 100.0,
              onChanged: (double newValue) {
                setState(() {
                  _size = newValue;
                });
              },
            ),
          ),
          flex: 3,
        )
      ],
    );
  }

  Color ifPokemonColor() {
    if (_selectedPokemonName == "hushigidane") {
      return Colors.green;
    } else if (_selectedPokemonName == "hitokage") {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  Widget finishCustomButton() {
    return Align(
      alignment: Alignment(0.8, 0.8),
      child: ElevatedButton(
        child: Text("完了"),
        onPressed: () {
          setState(() {
            _visible = false;
            _size = 50.0;
            _imageAlignment = Alignment(-0.8, -0.8);
          });
          Future.delayed(Duration(milliseconds: 1500), () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return PictureBook(
                pokemonName: _selectedPokemonName,
                nickname: _nickname,
                size: _size,
              );
            }));
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
