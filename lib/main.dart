import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './opencard.dart';
import 'package:share_plus/share_plus.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EXAM News 24',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const MyHomePage(title: 'EXAM News 24'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool loading = false;
  static const List<Widget> _wOptions = <Widget>[
    Text('Home', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    Text('Search ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    Text('Profile ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    Text('Exit ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    Text('Setting ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final String _content = 'https://www.convertapi.com/doc-to-html#snippet=html';

  List items = [];

  fetchData() async {
    setState(() => loading = true);
    var url = 'https://mocki.io/v1/7a349247-eb91-4bb1-81e2-6f90098dd70d';
    var response = await http.get(
        //Encode the url
        (Uri.parse(url)),
        //Only accept Json response
        headers: {
          "Accept": "application/json"
        });

    // print(response.body);

    Future.delayed(const Duration(milliseconds: 3000), () {
      String responseData = response.toString();

      final convertedJsonResponse = jsonDecode(response.body);

      items = (convertedJsonResponse['data']);

      print(items.length);

      setState(() => loading = false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
            TextField(),
            actions: [
              IconButton(
                icon:Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
        );
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage("https://wallpapercave.com/wp/wp6715177.jpg"), fit: BoxFit.fill),
                ),
                accountName: Text(
                  "Divyansh Seksaria",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "seksariadivyansh049@gmail.com",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications_active,
                ),
                title: const Text('Upcoming Jobs'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.offline_pin,
                ),
                title: const Text('Form Filled'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              AboutListTile(
                icon: Icon(
                  Icons.info,
                ),
                child: Text('About app'),
                applicationIcon: Icon(
                  Icons.local_play,
                ),
                applicationName: 'Exam News 24',
                applicationVersion: '1.0.25',
                applicationLegalese: '© 2019 Company',
                aboutBoxChildren: [
                  ///Content goes here...
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search', backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile', backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite', backgroundColor: Colors.red),
        ], type: BottomNavigationBarType.shifting, currentIndex: _selectedIndex, selectedItemColor: Colors.black, iconSize: 25, onTap: _onItemTapped, elevation: 5),
        body: Center(
            child: loading
                ? const LinearProgressIndicator(
                    color: Colors.white,
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 3 / 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
                    itemCount: items.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        decoration: BoxDecoration(color: Colors.grey, border: Border.all(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(20)),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          SizedBox(
                            child: Stack(fit: StackFit.passthrough, children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NewScreen(),
                                  ));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  height: MediaQuery.of(context).size.height * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.red, width: 1.5),
                                    image: DecorationImage(image: NetworkImage(items[index]["featureimgthum"]), fit: BoxFit.fill),
                                  ),
                                  child: Card(
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    shadowColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0.1,
                                bottom: 0.1,
                                child: new GestureDetector(
                                  onTap: () {
                                    Share.share(_content);
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(color: Colors.black, border: Border.all(color: Colors.white, width: 0.9), borderRadius: BorderRadius.circular(30)),
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0.1,
                                  bottom: 0.1,
                                  child: new GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(content: Text("245 Vacancy Available"));
                                      Scaffold.of(context).showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(color: Colors.black, border: Border.all(color: Colors.white, width: 0.9), borderRadius: BorderRadius.circular(30)),
                                      child: Icon(
                                        Icons.post_add_sharp,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ))
                            ]),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  (items[index]["title"]).toString().length > 19 ? (items[index]['title']).toString().substring(0, 25) : items[index]["title"],
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(background: Paint()..color = Colors.black, color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          //  Padding(
                          //    padding: const EdgeInsets.all(4.0),
                          //    child: Row(
                          //        crossAxisAlignment: CrossAxisAlignment.center,
                          //
                          //       children: [
                          //         Icon(Icons.newspaper,color: Colors.white, size: 10),
                          //         SizedBox(width: 10,),
                          //         Expanded(child: Text(items[index]["title"], style: TextStyle(color: Colors.red,fontSize:10),)),
                          //
                          //
                          //       ]
                          //   ),
                          //
                          // ),

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Icon(Icons.location_on, color: Colors.black, size: 12),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                items[index]["location"],
                                style: TextStyle(background: Paint()..color = Colors.white, color: Colors.black, fontSize: 12),
                              )),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Icon(Icons.ballot, color: Colors.black, size: 10),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                items[index]["vacancy_name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(background: Paint()..color = Colors.white, color: Colors.black, fontSize: 10),
                              )),
                            ]),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Icon(Icons.school, color: Colors.black, size: 10),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                items[index]["yogyata"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(background: Paint()..color = Colors.white, color: Colors.black, fontSize: 10),
                              )),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Icon(Icons.calendar_today, color: Colors.black, size: 10),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                items[index]["lastdate"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(background: Paint()..color = Colors.white, color: Colors.black, fontSize: 10),
                              )),
                            ]),
                          )
                          // Padding(
                          //   padding: const EdgeInsets.all(4.0),
                          //   child: Row(
                          //
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //
                          //         Expanded(
                          //           child: Row(
                          //
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 Icon(Icons.location_on ,color: Colors.white, size: 10),
                          //                 SizedBox(width: 10,),
                          //                 Expanded(child: Text(items[index]["title"], style: TextStyle(color: Colors.red,fontSize:08),)),
                          //
                          //               ]),
                          //         ),
                          //         Expanded(
                          //           child: Row(
                          //
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 Icon(Icons.access_time,color: Colors.white, size: 10),
                          //                 SizedBox(width: 10,),
                          //                 Expanded(child: Text(items[index]["state"], style: TextStyle(color: Colors.red,fontSize:08),)),
                          //
                          //               ]),
                          //         ),
                          //
                          //       ]),
                          // ),
                        ]),
                      );
                    })));
  }
}
