import 'package:flutter/material.dart';

// CUSTOM TAB
class CustomTab extends StatelessWidget {
  final String title;
  final String iconAsset;
  final double scale = 3;

  const CustomTab({
    Key key,
    @required this.title,
    @required this.iconAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Image.asset(
            iconAsset,
            scale: scale,
          ),
          new Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.0
            ),
          ),
        ],
      ),
    );
  }
}

// CUSTOM TAB BAR (WORKS WITH PAGE CONTROLLER)
class CustomTabBar extends StatefulWidget {
  final TabController controller;
  final List<CustomTab> tabs;
  final Color tabBarColor;
  double tabBarHeight;
  double elevation;
  final Color indicatorColor;
  double indicatorHeight;
  double spacingBetweenTabs;
  final Color selectedLabelColor;
  final Color unSelectedLabelColor;
  final Function(int tabIndex) onTabChanged;

  CustomTabBar(
      {Key key,
      @required this.tabs,
      @required this.indicatorColor,
      @required this.tabBarColor,
      @required this.selectedLabelColor,
      @required this.unSelectedLabelColor,
      @required this.controller,
      this.indicatorHeight,
      this.tabBarHeight,
      this.spacingBetweenTabs,
      this.elevation,
      this.onTabChanged})
      : super(key: key);

  @override
  CustomTabBarState createState() => new CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar> {
  // UI Properties
  int selectedTabIndex = 0;
  Color _defaultIndicatorColor = Colors.transparent;

  // Methods

  // Returns CustomTabs
  List<Widget> _getTabs() {
    List<Widget> tabList = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      tabList.add(new Expanded(
        child: new InkWell(
          onTap: () {
            _selectTab(i);
            widget.controller.animateTo(i,
                duration: new Duration(milliseconds: 100),
                curve: Curves.easeOut);
            // CLOSES KEYBOARD BY CLICKING ANY WHERE ON SCREEN
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: new Container(
            color: i == selectedTabIndex
                ? widget.indicatorColor
                : _defaultIndicatorColor, // INDICATOR
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
            ),
            child:
//            new SafeArea(
//              top: false,
//              child:
//
              i == selectedTabIndex ? widget.tabs[i] : widget.tabs[i],
//            ),
          ),
        ),
      ));
      if (i != widget.tabs.length - 1 && widget.spacingBetweenTabs != null) {
        tabList.add(new SizedBox(width: widget.spacingBetweenTabs));
      }
    }
    return tabList;
  }

  /// Selects Tab
  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    if (widget.onTabChanged != null) {
      widget.onTabChanged(index);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      elevation: widget.elevation ?? 2.0,
      color: Colors.transparent,
      child: new Container(
//        height: widget.tabBarHeight ?? 50.0,
        color: widget.tabBarColor,
        child: new SafeArea(
        top: false,
          child: new Row(
            children: _getTabs(),
          ),
        ),
      ),
    );
  }
}
