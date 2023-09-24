import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wow_client/wow_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'configs/mouse_touch_web.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  TextEditingController _newTitleController = TextEditingController();
  TextEditingController _newConentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  bool _isPrime = false;

  List<Article?>? articles;

  int? amountOfArtciles;

  double? temperature;

  String? strange;

  getStrange() async {
    strange =await  client.artikool.getString();
    setState(() {
      
    });
  }

  getTemp() async {
    await client.artikool
        .getWeatherInfo(24)
        .then((value) => temperature = value.temperature);
    setState(() {});
  }

  getArticles() async {
    articles = await client.artikool.getArticles();
    setState(() {});
  }

  getAmountOfArticles() async {
    amountOfArtciles = await client.artikool.getArticlesTotalAmont();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArticles();
    getAmountOfArticles();
    getTemp();
    // getStrange();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      home: Scaffold(
        appBar: AppBar(
          title: temperature == null ? Text('fewfewfwefewfwefwefwe') : Text(temperature.toString()),
        ),
          key: _scaffoldStateKey,
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Column(
                        children: [
                          TextField(
                            controller: _title,
                            decoration: InputDecoration(
                              hintText: 'Title',
                            ),
                          ),
                          TextField(
                            controller: _content,
                            decoration: InputDecoration(
                              hintText: 'Content',
                            ),
                          ),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text('Prime?'),
                                value: _isPrime,
                                onChanged: (value) {
                                  setState(() {
                                    _isPrime = !_isPrime;
                                  });
                                },
                              );
                            },
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await client.artikool.addArticle(Article(
                                    title: _title.text,
                                    content: _content.text,
                                    publishedOn: DateTime.now(),
                                    isPrime: _isPrime));

                                Navigator.of(context).pop();
                                getArticles();
                                // FToast().showToast(child: Text('SUCCES'));
                              },
                              child: temperature == null
                                  ? Text('ADDDDDDD')
                                  : Text(temperature.toString()))
                        ],
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.add)),
          body: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              itemCount: articles?.length ?? 2,
              itemBuilder: (context, index) {
                return articles == null
                    ? Container()
                    : Slidable(
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SizedBox(
                            width: 70,
                            child: GestureDetector(
                              onTap: () async {
                                var articles =
                                    await client.artikool.getArticles();
                                int currentId = articles[index]!.id!;
                                await client.artikool.deleteArticle(currentId);
                                await getArticles();
                                setState(() {});
                              },
                              child: Container(
                                color: Colors.red,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Column(
                                children: [
                                  TextField(
                                    controller: _newTitleController,
                                  ),
                                  TextField(
                                    controller: _newConentController,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        print(_newTitleController.text);
                                        print(_newConentController.text);
                                        await client.artikool.editArticle(
                                            Article(
                                                title: _newTitleController.text,
                                                content:
                                                    _newConentController.text,
                                                publishedOn: DateTime.now(),
                                                isPrime: true));

                                        await getArticles();
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                      child: Text('save changes'))
                                ],
                              );
                            },
                            child: SizedBox(
                              width: 70,
                              child: Container(
                                color: Colors.blue,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                        child: ListTile(
                          title: Text(articles![index]!.title),
                          subtitle: Text(articles![index]!.content),
                        ),
                      );
              })),
    );
  }
}
