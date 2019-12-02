import 'package:flutter/material.dart';

class CustomPageViewWithPageControlDots extends StatefulWidget {
  final List<Widget> pageContent;
  final double pageControlDotSize;
  final BoxShape pageControlDotShape;
  final double spacing;
  final Color pageControlDotColorSelected;
  final Color pageControlDotColorUnSelected;
  final Function(double pageOffset) onPageChanged;
  final PageController pageController;

  const CustomPageViewWithPageControlDots({
    Key key,
    @required this.pageContent,
    this.pageControlDotSize,
    this.pageControlDotShape,
    this.spacing,
    this.pageControlDotColorSelected,
    this.pageControlDotColorUnSelected,
    this.onPageChanged,
    @required this.pageController,
  }) : super(key: key);

  @override
  _CustomPageViewWithPageControlDotsState createState() =>
      new _CustomPageViewWithPageControlDotsState();
}

class _CustomPageViewWithPageControlDotsState
    extends State<CustomPageViewWithPageControlDots>
    with TickerProviderStateMixin {
  // CONTROLLERS
  PageController _pageController;

  // UI PROPERTIES
  double _pageOffset;
  double _pageControlDotSize;
  double _spacing;
  int _itemCount;
  BoxShape _pageControlDotShape;
  Color _pageControlDotColor;

  // METHODS

  /// SETS UI PROPERTIES TO DEFAULTS
  void _setDefaults() {
    _pageOffset = 0.0;
    _pageControlDotSize = widget.pageControlDotSize ?? 12.0;
    _spacing = widget.spacing ?? 5.0;
    _itemCount = widget.pageContent.length;
    _pageControlDotShape = widget.pageControlDotShape ?? BoxShape.rectangle;
    _pageControlDotColor = widget.pageControlDotColorSelected ?? Colors.black;
  }

  // OVERRIDDEN METHODS

  @override
  void initState() {
    _setDefaults();
    _pageController = widget.pageController;
    _pageController.addListener(() {
      setState(() {
        _pageOffset = _pageController.page;
      });
      widget.onPageChanged(_pageOffset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.only(
//            bottom: _pageControlDotSize + 16.0,
              ),
          child: new PageView.builder(
            itemCount: _itemCount,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                child: widget.pageContent[index],
              );
            },
          ),
        ),
        new Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 16.0,
          ),
          child: new Container(
            alignment: Alignment.bottomCenter,
            width: (_itemCount * _pageControlDotSize) + (_itemCount * _spacing),
            child: _itemCount > 1
                ? new Wrap(
                    spacing: widget.spacing,
                    children: <Widget>[]
                      ..addAll(List<Widget>.generate(_itemCount, (int index) {
                        if ((_pageOffset != index.toDouble())) {
                          if ((_pageOffset.toInt() == index)) {
                            if ((_pageOffset > index.toDouble())) {
                              return new Container(
                                height: _pageControlDotSize,
                                width: _pageControlDotSize,
                                decoration: new BoxDecoration(
                                  shape: _pageControlDotShape,
                                  border: Border.all(
                                    color: _pageControlDotColor,
                                    width: (_pageControlDotSize / 2.0) -
                                        ((_pageOffset - index.toDouble()) *
                                            (_pageControlDotSize * 0.46)),
                                  ),
                                ),
                              );
                            }
                          } else {
                            if ((index - _pageOffset.toInt()) == 1) {
                              return new Container(
                                height: _pageControlDotSize,
                                width: _pageControlDotSize,
                                decoration: new BoxDecoration(
                                  shape: _pageControlDotShape,
                                  border: Border.all(
                                    color: _pageControlDotColor,
                                    width: (_pageControlDotSize / 2.0) +
                                        ((_pageOffset - index.toDouble()) *
                                            (_pageControlDotSize * 0.46)),
                                  ),
                                ),
                              );
                            }

                            return new Container(
                              height: _pageControlDotSize,
                              width: _pageControlDotSize,
                              decoration: new BoxDecoration(
                                shape: _pageControlDotShape,
                                border: Border.all(
                                  color: _pageControlDotColor,
                                  width: _pageControlDotSize * 0.09,
                                ),
                              ),
                            );
                          }
                        } else {
                          return new Container(
                            height: _pageControlDotSize,
                            width: _pageControlDotSize,
                            decoration: new BoxDecoration(
                              shape: _pageControlDotShape,
                              border: Border.all(
                                color: _pageControlDotColor,
                                width: (_pageControlDotSize / 2.0),
                              ),
                            ),
                          );
                        }
                      })),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
