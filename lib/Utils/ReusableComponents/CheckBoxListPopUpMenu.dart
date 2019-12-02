import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../AppColors.dart';
import '../Localization.dart';
import '../LocalizationValues.dart';
import '../ReusableWidgets.dart';
import '../UniversalFunctions.dart';

class CheckBoxListPopUpMenu extends StatefulWidget {
  final Map<String, String> options;
  final List<int> selectedOptions;
  final String otherSelectedOption;
  final Function(List<int>,
      {String other, Map<String, String> updatedOptionsList}) onDone;
  final bool multipleSelection;
  final String label;
  final String title;
  final Function(Map<String, String>) onOptionsRefresh;
  final Future<Map<String, String>> Function() refresh;

  const CheckBoxListPopUpMenu({
    Key key,
    @required this.options,
    @required this.selectedOptions,
    @required this.onDone,
    this.multipleSelection = true,
    @required this.label,
    @required this.otherSelectedOption,
    this.onOptionsRefresh,
    this.refresh,
    @required this.title,
  }) : super(key: key);

  @override
  _CheckBoxListPopUpMenuState createState() => _CheckBoxListPopUpMenuState();
}

class _CheckBoxListPopUpMenuState extends State<CheckBoxListPopUpMenu> {
  // Controllers
  TextEditingController _otherFieldTxtController;

  // UI Props.
  Map<String, String> _options;
  List _optionKeys;
  List _optionValues;
  List<int> _selectedOptions = [];
  bool _selectAll;
  bool _showOtherTextField;
  OverlayState overlayState;
  bool _refreshingList = false;

  @override
  void initState() {
    _setDefaults();
    super.initState();
  }

  // Builds screen
  @override
  Widget build(BuildContext context) {
    overlayState = Overlay.of(context);
    return new Container(
      height: getScreenSize(context: context).height * 0.5,
      width: getScreenSize(context: context).width * 0.1,
      child: _options.isEmpty
          ? new Offstage(
              offstage: _refreshingList,
              child: getNoDataView(
                context: context,
                  msg: Localization.of(context).trans(LocalizationValues.noDataFound),
                  onRetry: () async {
                    if (widget.refresh != null) {
                      OverlayEntry refreshLoader =
                          OverlayEntry(builder: (BuildContext context) {
                        return new Positioned.fill(
                          child: new Center(
                            child: getAppThemedLoader(
                              context: context,
                              bgColor: Colors.transparent,
                            ),
                          ),
                        );
                      });

                      setState(() {
                        _refreshingList = true;
                      });

                      overlayState.insert(refreshLoader);
                      _options = await widget.refresh() ?? {};
                      _optionKeys = _options.keys.toList();
                      _optionValues = _options.values.toList();
                      refreshLoader.remove();
                      setState(() {
                        _refreshingList = false;
                      });
                    }

                    if (widget.onOptionsRefresh != null) {
                      widget.onOptionsRefresh(_options);
                    }
                  }),
            )
          : new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: new Text(
                    widget.title ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                new Offstage(
                  offstage: !widget.multipleSelection,
                  child: new CheckboxListTile(
                    activeColor: Colors.black,
                    title: new Text(
                      Localization.of(context).trans(LocalizationValues.selectAll),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: _selectAll,
                    onChanged: (bool val) {
                      setState(() {
                        _selectAll = val;
                        _selectedOptions.clear();
                        if (val) {
                          _selectedOptions =
                              new List.generate(_options.length, (int i) => i);
                        }
                      });
                    },
                  ),
                ),
                new Expanded(
                  child: new ListView.builder(
                    itemCount: _options.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new CheckboxListTile(
                        title: new Text(
                          _optionKeys[index],
                        ),
                        activeColor: Colors.black,
                        value: _selectedOptions.contains(index),
                        onChanged: (bool val) {
                          setState(() {
                            if (_selectedOptions.contains(index) && !val) {
                              _selectedOptions.removeWhere(
                                (itemIndex) => index == itemIndex,
                              );
                            } else {
                              if (!widget.multipleSelection) {
                                _selectedOptions.clear();
                              }
                              _selectedOptions.add(index);
                            }

                            if (!widget.multipleSelection) {
                              _showOtherTextField = false;
                              _otherFieldTxtController.clear();
                            }

                            _selectAll =
                                _selectedOptions.length == _optionKeys.length;
                          });
                        },
                      );
                    },
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: _showOtherTextField ? 0.0 : 8.0,
                  ),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new InkWell(
                      child: new Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: new Text(
                          Localization.of(context).trans(LocalizationValues.other),
                          style: const TextStyle(
//                      color: ProPawnColors.kAppYellow,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _showOtherTextField = !_showOtherTextField;
                          _otherFieldTxtController.clear();
                          if (_showOtherTextField &&
                              !widget.multipleSelection) {
                            _selectedOptions.clear();
                          }
                        });
                      },
                    ),
                  ),
                ),
                new Offstage(
                  offstage: !_showOtherTextField,
                  child: new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Colors.black,
                        cursorColor: Colors.black,
                      ),
                      child: new TextFormField(
                        controller: _otherFieldTxtController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                        textCapitalization: TextCapitalization.sentences,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: 8.0,
                          ),
                          helperStyle: new TextStyle(
                            fontSize: 0.0,
                          ),
                          labelText: Localization.of(context).trans(LocalizationValues.enter) +
                              " "+ "${(widget.label ?? "").split("*").first}",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: new Container(
                    width: double.infinity,
                    height: 0.6,
                    color: Colors.black,
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: new Text(
                        Localization.of(context).trans(LocalizationValues.cancel).toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.kAppBlack,
                        ),
                      ),
                    ),
                    new Container(
                      width: 0.6,
                      height: 36.0,
                      color: Colors.black,
                    ),
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (widget.onDone != null) {
                          widget.onDone(
                            _selectedOptions,
                            other: _otherFieldTxtController.text,
                            updatedOptionsList: _options,
                          );
                        }
                      },
                      child: new Text(
                        Localization.of(context).trans(LocalizationValues.done).toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.kAppBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  // Methods

  // Sets defaults
  void _setDefaults() {
    _options = widget.options;
    _otherFieldTxtController = new TextEditingController(
      text: widget.otherSelectedOption,
    );
    _showOtherTextField = widget.otherSelectedOption != null
        ? widget.otherSelectedOption.isNotEmpty
        : false;
    _optionKeys = _options.keys.toList();
    _optionValues = _options.values.toList();

    widget.selectedOptions.forEach((int option) {
      _selectedOptions.add(option);
    });
     try {
      _selectAll = widget.selectedOptions.length == _options.length;
    } catch (e) {
      _selectAll = false;
    }
  }
}
