import 'dart:convert' show utf8;
import 'dart:io';
import 'dart:math';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:quizlet/services/firestore.services.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/create/add_term.dart';
import 'package:quizlet/widgets/qtext.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  bool initialized = false;
  String _setId = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController folderController = TextEditingController();

  final List<Widget> widgets = [];
  final List<TextEditingController> termControllers = [];
  final List<TextEditingController> defControllers = [];

  final FirestoreService firestoreService = FirestoreService();

  void _addWidget() {
    setState(() {
      termControllers.add(TextEditingController());
      defControllers.add(TextEditingController());
      widgets.add(
        AddTerm(
          termController: termControllers.last,
          defController: defControllers.last,
        ),
      );
    });
  }

  void _addWidgetWithData(String term, String def) {
    setState(() {
      termControllers.add(TextEditingController(text: term));
      defControllers.add(TextEditingController(text: def));
      widgets.add(
        AddTerm(
          termController: termControllers.last,
          defController: defControllers.last,
        ),
      );
    });
  }

  void _removeWidget(int index) {
    setState(() {
      termControllers.removeAt(index);
      defControllers.removeAt(index);
      widgets.removeAt(index);
    });
  }

  Future<void> _submitData() async {
    final Map<String, String> cards = {};
    if (widgets.length >= 4) {
      for (final widget in widgets) {
        if (widget is AddTerm) {
          cards[widget.termController.text] = widget.defController.text;
        }
      }
      await firestoreService.updateSet(
        _setId,
        nameController.text,
        folderController.text,
        cards,
        {},
      );
      setState(() {
        // widgets.clear();
        // termControllers.clear();
        // defControllers.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: QText(
              text: "Your set has been updated",
              color: Colors.white,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: snackBarColor,
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: QText(
            text: "Please add at least 4 terms!",
            color: Colors.white,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: snackBarColor,
        ),
      );
    }
  }

  Future<void> _csv() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null) {
      final PlatformFile file = result.files.first;
      final input = File(file.path.toString()).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();
      for (final field in fields) {
        final List<String> temp = field[0].toString().split(';');
        _addWidgetWithData(temp[0], temp[1]);
      }
    }
  }

  Future<void> _ocr() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'png', 'jpg'],
    );
    if (result != null) {
      final File file = File(result.files.single.path.toString());
      final inputImage = InputImage.fromFile(file);
      final textRecognizer = TextRecognizer();
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      final String text = recognizedText.text;
      final List<String> words = text.split("\n");
      if (words.length.isEven) {
        words.add("");
      }
      for (var i = 0; i < words.length; i += 2) {
        _addWidgetWithData(words[i], words[i + 1]);
      }
      textRecognizer.close();
    }
  }

  void initUpdate(Map<dynamic, dynamic> setData, String setId) {
    setState(() {
      _setId = setId;
      nameController.text = setData['name'].toString();
      folderController.text = setData['folder'].toString();
      for (final key in setData['cards'].keys) {
        _addWidgetWithData(key.toString(), setData['cards'][key].toString());
      }
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      final Map<dynamic, dynamic> _setCard =
          arguments['setDetail'] as Map<dynamic, dynamic>;
      final String _setId = arguments['setId'] as String;
      initUpdate(_setCard, _setId);
    }
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: const QText(
            text: 'Update',
            color: Colors.white,
            size: 30,
            isBold: true,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  helperText: 'Name',
                  hintStyle:
                      TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5)),
                  helperStyle: TextStyle(color: textColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: textColor),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              TypeAheadField(
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: secondaryColor,
                  shadowColor: Colors.black.withOpacity(0.1),
                  elevation: 0,
                ),
                textFieldConfiguration: TextFieldConfiguration(
                  controller: folderController,
                  decoration: const InputDecoration(
                    helperText: 'Folder',
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5)),
                    helperStyle: TextStyle(color: textColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return firestoreService.getFoldersSuggestion();
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    folderController.text = suggestion.toString();
                  });
                },
              ),
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      key: ValueKey(Random()),
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () {
                            _removeWidget(index);
                          },
                        ),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              _removeWidget(index);
                            },
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: widgets[index],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        _ocr();
                      },
                      child: const Icon(Icons.camera_rounded, size: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        _addWidget();
                      },
                      child: const Icon(Icons.add_circle_rounded, size: 30),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _csv();
                    },
                    child: const Icon(Icons.adf_scanner_rounded, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await _submitData();
                  // Navigator.pop(this.context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 137, right: 137),
                  child: QText(text: "Update", color: textColor),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: QText(
                  color: textColor.withOpacity(0.5),
                  text: "Hint: At least 4 cards must be created within a set.",
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
