import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

void main() {
  runApp(MaterialApp(
    title: 'Flutter test',
    home: Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: QuizApp(),
    ),
  ));
}

class QuizApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizState();
  }
}

class QuizState extends State<QuizApp> {
  var _value = '';
  bool _value1 = false;

  _value1Changed(x) {
    setState(() {
      _value1 = x;
    });
  }

  _showSnackBar() {
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text('this is snackBar'),
      action: SnackBarAction(
          label: 'Hide',
          onPressed: () => _scaffoldState.currentState.hideCurrentSnackBar()),
    ));
  }

  _showAlertDialog(BuildContext context, String message) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text(message),
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text('Ok')),
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text('no')),
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text('maybe')),
          ],
        ));
  }

  _change(String value) {
    setState(() {
      _value = value;
    });
  }

  int _radioValue = 0;

  void _onRadioChanged(x) => setState(() => _radioValue = x);

  Widget getRadio() {
    List<RadioListTile> radioList = List();
    for (int i = 0; i < 3; i++) {
      radioList.add(RadioListTile(
        title: Text('this index is $i'),
        value: i,
        groupValue: _radioValue,
        onChanged: _onRadioChanged,
        toggleable: true,
        controlAffinity: ListTileControlAffinity.leading,
        secondary: Icon(Icons.account_balance_outlined),
      ));
    }
    var column = Column(
      children: radioList,
    );
    return column;
  }

  var _sliderValue = 0.0;
  var _dateValue = '';

  Future _pickDate() async {
    DateTime dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2022));
    setState(() {
      _dateValue = dt.toLocal().toString();
    });
    return dt;
  }

  _onSliderChanged(double value) => setState(() => _sliderValue = value);

  _showBottomSheet() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text('hide me'),
                  RaisedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('hide'),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_value),
                ),
                TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.people),
                      hintText: 'Name',
                      labelText: 'Name'),
                  /*onChanged:_change,*/
                  onSubmitted: _change,
                ),
                CheckboxListTile(
                  value: _value1,
                  onChanged: _value1Changed,
                  title: Text('check this'),
                  subtitle: Text('subTitle'),
                  controlAffinity: ListTileControlAffinity.leading,
                  secondary: Icon(Icons.icecream),
                  activeColor: Colors.red,
                  checkColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getRadio(),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$_sliderValue'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slider(
                    onChanged: _onSliderChanged,
                    value: _sliderValue,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('date is $_dateValue'),
                  ),
                ), Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      tooltip: 'click me',
                      icon: (Icon(Icons.timer)),
                      onPressed: () =>
                          _showAlertDialog(context, 'hello flutter'),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('pick date'),
                      onPressed: _pickDate,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('show dialog'),
                      onPressed: _showBottomSheet,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('show snack bar'),
                      onPressed: _showSnackBar,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
