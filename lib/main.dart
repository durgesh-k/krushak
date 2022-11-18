import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krushak/auth/auth.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/home.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*if (FirebaseAuth.instance.currentUser != null) {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        langCode = value.data()!['language'];
        if (langCode == 'hi') {
          language = 'हिन्दी';
        } else {
          language = 'English';
        }
      },
    );
  }*/
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale.fromSubtags(languageCode: 'hi'),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      builder: (context, child) {
        /*ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return NoResponse(errorDetails: errorDetails);
          };*/

        return ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            maxWidth: getWidth(context),
            minWidth: 300,
            defaultScale: true,
            mediaQueryData:
                MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
            breakpoints: [
              const ResponsiveBreakpoint.resize(300, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5)));
      },
      home: Authenticate(),
    );
  }
}

/*
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US',
      supportedLocales: ['en_US', 'es', 'fa', 'ar', 'ru']);

  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: 'Flutter Translate Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _decrementCounter() => setState(() => _counter--);

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return Scaffold(
      appBar: AppBar(
        title: TranslatedText(translate('app_bar.title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TranslatedText(translate('language.selected_message', args: {
              'language': translate(
                  'language.name.${localizationDelegate.currentLocale.languageCode}')
            })),
            Padding(
                padding: EdgeInsets.only(top: 25, bottom: 160),
                child: CupertinoButton.filled(
                  child: TranslatedText(translate('button.change_language')),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 36.0),
                  onPressed: () => _onActionSheetPress(context),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TranslatedText(translatePlural('plural.demo', _counter))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  iconSize: 48,
                  onPressed: _counter > 0
                      ? () => setState(() => _decrementCounter())
                      : null,
                ),
                IconButton(
                  icon: Icon(Icons.add_circle),
                  color: Colors.blue,
                  iconSize: 48,
                  onPressed: () => setState(() => _incrementCounter()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showDemoActionSheet(
      {required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? value) {
      if (value != null) changeLocale(context, value);
    });
  }

  void _onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: TranslatedText(translate('language.selection.title')),
        message: TranslatedText(translate('language.selection.message')),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: TranslatedText(translate('language.name.en')),
            onPressed: () => Navigator.pop(context, 'en_US'),
          ),
          CupertinoActionSheetAction(
            child: TranslatedText(translate('language.name.es')),
            onPressed: () => Navigator.pop(context, 'es'),
          ),
          CupertinoActionSheetAction(
            child: TranslatedText(translate('language.name.ar')),
            onPressed: () => Navigator.pop(context, 'ar'),
          ),
          CupertinoActionSheetAction(
            child: TranslatedText(translate('language.name.ru')),
            onPressed: () => Navigator.pop(context, 'ru'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: TranslatedText(translate('button.cancel')),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:krushak/data/data.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(
      accentColor: Colors.green,
      scaffoldBackgroundColor: Colors.green[100],
      primaryColor: Colors.green,
    ),
    home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result1 = 'Result 1';
  String result2 = 'Result 2';
  String result3 = 'Result 3';

  bool isLoading = false;

  void extractData() async {
    final response =
        await http.Client().get(Uri.parse('https://www.msamb.com/Home/Index'));

    print('resp--${response.statusCode}');

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        var elements = document
            .getElementsByClassName('table')[0]
            .getElementsByTagName('tr');
        List l = [];
        print('1');
        print(elements.length);
        for (int i = 1; i < elements.length; i++) {
          var responseString1 = elements[i].children[0].text;
          var responseString2 = elements[i].children[1].text;
          var responseString3 = elements[i].children[2].text;
          var responseString4 = elements[i].children[3].text;
          l.add(responseString1);
          print('scraped--$responseString1');
          print('scraped2--$responseString2');
          print('scraped3--$responseString3');
          print('scraped3--$responseString4');
          cropp.add({
            'url': 'assets/image 32.png',
            'title': responseString1,
            'quantity': '$responseString2 quintal',
            'price': responseString4,
          });
        }
        setState(() {});
      } catch (e) {
        print('1e');
      }
    } else {
      print('2e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GeeksForGeeks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Text(result1,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(result2,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(result3,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            MaterialButton(
              onPressed: () async {
                // Setting isLoading true to show the loader
                setState(() {
                  isLoading = true;
                });

                final response = await extractData();
                setState(() {
                  result1 = response[0];
                  result2 = response[1];
                  result3 = response[2];
                  isLoading = false;
                });
              },
              child: Text(
                'Scrap Data',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            )
          ],
        )),
      ),
    );
  }
}*/
