import 'package:flutter/material.dart';
import 'package:bottom_navigation_scaffold/bottom_navigation_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootWidget());
  }
}

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationScaffold(
      bottomNNavigationBarBuilder: (context, tabs, currentIndex, signalUpdate){
        return BottomNavigationBar(
          onTap: (i) => signalUpdate(i),
          items: tabs,
          currentIndex: currentIndex,
        );
      },
      pageDetails: [
        PageDetail(
          pageAppBar: AppBar(
            key: Key("share"),
            title: Text('Share'),
          ),
          page: PageWidget(title: 'Share'),
          tab: BottomNavigationBarItem(icon: Icon(Icons.share), label: "Share"),
          floatingActionButton: FloatingActionButton(
            key: Key("share"),
            onPressed: () {},
            tooltip: 'Share',
            child: Icon(Icons.share),
          ),
        ),
        PageDetail(
          pageAppBar: AppBar(
            key: Key("add"),
            title: Text('Add'),
          ),
          page: PageWidget(title: 'Add'),
          tab: BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          floatingActionButton: FloatingActionButton(
            key: Key("add"),
            onPressed: () {},
            tooltip: 'Add',
            child: Icon(Icons.add),
          ),
        ),
        PageDetail(
          page: PageWidget(title: 'Info'),
          tab: BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
        ),
      ],
    );
  }
}

class PageWidget extends StatelessWidget {
  PageWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
