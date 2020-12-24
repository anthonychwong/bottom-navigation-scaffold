import 'package:bottom_navigation_scaffold/src/page_detail.dart';
import 'package:flutter/material.dart';

typedef BottomNNavigationBarBuilder<T> = Widget Function(BuildContext context,
    List<T> tabs, int currentIndex, void Function(int) signalUpdateScaffold);

class BottomNavigationScaffold<T> extends StatefulWidget {
  final List<PageDetail<T>> pageDetails;
  final BottomNNavigationBarBuilder<T> bottomNNavigationBarBuilder;

  const BottomNavigationScaffold(
      {Key key, this.pageDetails, this.bottomNNavigationBarBuilder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationScaffoldState(
        pageDetails: this.pageDetails,
        bottomNNavigationBarBuilder: bottomNNavigationBarBuilder);
  }
}

class _AnimatedAppBar extends StatelessWidget implements PreferredSizeWidget {

  final PreferredSizeWidget actualAppBar;

  const _AnimatedAppBar({Key key, this.actualAppBar}) : super(key: key);

  @override
  Size get preferredSize => actualAppBar?.preferredSize ?? Size.zero;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: actualAppBar,
            );
  }
}

class _BottomNavigationScaffoldState<T>
    extends State<BottomNavigationScaffold> {
  final List<PageDetail<T>> pageDetails;
  final BottomNNavigationBarBuilder bottomNNavigationBarBuilder;

  List<Widget> _pages;
  List<T> _tabs;

  _BottomNavigationScaffoldState(
      {@required this.pageDetails,
      @required this.bottomNNavigationBarBuilder}) {
    _pages = pageDetails.map((e) => e.page).toList();
    _tabs = pageDetails.map((e) => e.tab).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: pageDetails.length,
        child: Builder(builder: (BuildContext context) {
          DefaultTabController.of(context).addListener(() => setState(() {}));
          int _currentIndex = DefaultTabController.of(context).index;

          return Scaffold(
            appBar: _AnimatedAppBar(actualAppBar: pageDetails[_currentIndex].pageAppBar),
            body: TabBarView(children: _pages,),
            floatingActionButton: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  child:FadeTransition(child: child, opacity: animation),
                  scale: animation
                );
              },
              child: pageDetails[_currentIndex].floatingActionButton,
            ),
            bottomNavigationBar: this.bottomNNavigationBarBuilder(
              context,
              _tabs,
              _currentIndex,
              (selectedIndex) => DefaultTabController.of(context).index = selectedIndex
            ),
          );
        }));
  }
}
