//import 'dart:io';
//import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';
//
//
//class FilePickerSection extends StatefulWidget {
//  final String label;
//  final List<File> docs;
//
//  const FilePickerSection({
//    Key key,
//    @required this.label,
//    @required this.docs,
//  }) : super(key: key);
//
//  @override
//  _FilePickerSectionState createState() => _FilePickerSectionState();
//}
//
//class _FilePickerSectionState extends State<FilePickerSection> {
//  // Data props.
//  List<File> selectedDocs = [];
//
//  @override
//  void initState() {
//    selectedDocs = widget.docs;
//    super.initState();
//  }
//
//  // Builds screen
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//      decoration: new BoxDecoration(
//        color: ProPawnColors.kGrey.withOpacity(
//          0.4,
//        ),
//        border: new Border(
//          left: new BorderSide(
//            width: 6.0,
//            color: ProPawnColors.kPrimaryBlue.withOpacity(
//              0.8,
//            ),
//          ),
//        ),
//      ),
//      padding: const EdgeInsets.all(12.0),
//      width: getScreenSize(context: context).width,
//      child: new Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          new Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              new Expanded(
//                child: new Text(
//                  widget.label,
//                  style: const TextStyle(
//                    color: Colors.black,
//                    fontWeight: FontWeight.w600,
//                    fontSize: 12.0,
//                  ),
//                ),
//              ),
//              new Offstage(
//                offstage: selectedDocs.length >= 4,
//                child: new InkWell(
//                  child: new Icon(
//                    Icons.add_circle,
//                    color: ProPawnColors.kPrimaryBlue,
//                  ),
//                  onTap: () async {
//                    File file = await _getFile(
//                      context: context,
//                      fileSizeInMBs: 5,
//                    );
//                    print("FILE PICKED: ${file.path}");
//                    if (file != null) {
//                      setState(() {
//                        selectedDocs.add(file);
//                      });
//                    }
//                  },
//                ),
//              ),
//            ],
//          ),
//          new Padding(
//            padding: const EdgeInsets.only(
//              left: 16.0,
//            ),
//            child: new Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[]..addAll(
//                  new List.generate(
//                    selectedDocs.length,
//                    (int index) {
//                      String fileName = selectedDocs[index].path;
//                      return new Padding(
//                        padding: const EdgeInsets.symmetric(
//                          vertical: 8.0,
//                        ),
//                        child: new Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            new Expanded(
//                              child: new Text(
//                                fileName.split("/").last,
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                              ),
//                            ),
//                            new Padding(
//                              padding: const EdgeInsets.symmetric(
//                                horizontal: 8.0,
//                              ),
//                              child: new InkWell(
//                                child: new Icon(
//                                  Icons.cancel,
//                                  color: ProPawnColors.kSkyBlue,
//                                  size: 20.0,
//                                ),
//                                onTap: () {
//                                  setState(() {
//                                    selectedDocs.removeAt(index);
//                                  });
//                                },
//                              ),
//                            ),
//                          ],
//                        ),
//                      );
//                    },
//                  ),
//                ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  // Methods
//
//  // Gets file with specific limited file size(defaults to 5mb)
//  Future<File> _getFile({
//    @required BuildContext context,
//    int fileSizeInMBs = 5,
//  }) async {
//    try {
//      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
//      print("FILE PATH: $filePath");
//      if (filePath == '' || filePath == null) {
//        return null;
//      }
//
//      String filePathExt = filePath.toLowerCase();
//
//      if (filePathExt.contains('.pdf') ||
//          filePathExt.contains('.doc') ||
//          filePathExt.contains('.jpeg') ||
//          filePathExt.contains('.jpg') ||
//          filePathExt.contains('.png') ||
//          filePathExt.contains('.xls')) {
//        final File file = await new File('$filePath').create();
//        if (file.lengthSync() < fileSizeInMBs * 1024 * 1024) {
//          return file;
//        } else {
//          if (!alertAlreadyActive && mounted) {
//            alertAlreadyActive = true;
//
//            showAlert(
//                context: context,
//                titleText: "ERROR",
//                message: 'File size should not be greater than 5mb.',
//                actionCallbacks: {
//                  "OK": () {
//                    Navigator.pop(context);
//                    alertAlreadyActive = false;
//                  }
//                });
//          }
//        }
//      } else {
//        if (!alertAlreadyActive && mounted) {
//          showAlert(
//              context: context,
//              titleText: "ERROR",
//              message:
//                  'Invalid file format, please upload a .pdf, .doc , .xls, .docx ,.jpeg, .jpg or .png file.',
//              actionCallbacks: {
//                "OK": () {
//                  Navigator.pop(context);
//                  alertAlreadyActive = false;
//                }
//              });
//        }
//      }
//    } catch (e) {
//      print("Error while picking the file: " + e.toString());
//    }
//    return null;
//  }
//}
