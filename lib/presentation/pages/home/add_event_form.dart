import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/events/events_bloc.dart';
import '../../../constants/device.dart';
import '../../../constants/enums.dart';
import '../../../constants/validators.dart';
import '../../widgets/custom_form_view_widget.dart';
import '../../widgets/custom_textFormField_widget.dart';
import 'date_picker_button_widget.dart';

enum EventType { PersonalEvent, Class }

/// # Add Event Form
/// What gets shown when you want to add an event
/// Uses Modals for stuff
class AddEventForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc(),
      child: AddEventFormView(),
    );
  }
}

class AddEventFormView extends StatefulWidget {
  @override
  _AddEventFormViewState createState() => _AddEventFormViewState();
}

class _AddEventFormViewState extends State<AddEventFormView> {
  // ### Values to be saved
  String _title, _description;
  DateTime _from, _to, _reminder;
  int _numberOfRepetitions;
  RepetitionRange _repetitionRange;

  // TODO Calendar Functions to add later
  // - Location
  // - Guests
  //     - UID
  //     - Names
  //     - Profile Pictures

  // ### Handling the Form Inputs
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _areThingsEnabled = true;
  DateTime _selectedStartingDate = DateTime.now();
  DateTime _selectedEndingDate = DateTime.now().add(Duration(minutes: 30));
  // DateTime _firstSelectableStartingDate = DateTime(DateTime.now().year - 100);
  // DateTime _lastSelectableStartingDate = DateTime(DateTime.now().year + 100);
  // DateTime _firstSelectableEndingDate = DateTime(DateTime.now().year - 100);
  // DateTime _lastSelectableEndingDate = DateTime(DateTime.now().year + 100);
  DateTime _firstSelectableStartingDate = DateTime.now();
  DateTime _lastSelectableStartingDate = DateTime(DateTime.now().year + 100);
  DateTime _firstSelectableEndingDate = DateTime.now();
  DateTime _lastSelectableEndingDate = DateTime(DateTime.now().year + 100);

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return FormView(
      title: "Add Event",
      child: BlocListener<EventsBloc, EventsState>(
        listener: (context, state) {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Device.height(2.0)),

            // ## Form
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      // ### Title Field1
                      CustomTextFormField(
                        size: 3,
                        label: 'Title',
                        enabled: _areThingsEnabled,
                        keyboardType: TextInputType.text,
                        onSaved: (value) => _title = value,
                        validator: Validator.titleValidator,
                      ),

                      SizedBox(height: Device.height(2.0)),

                      // ### Options
                      Container(
                        alignment: Alignment.centerLeft,
                        child: CupertinoRadioChoice(
                          choices: {'Personal': 'Personal', 'Class': 'Class'},
                          selectedColor: Colors.blue,
                          notSelectedColor: Colors.grey,
                          initialKeyValue: 'Personal',
                          onChange: (_selectedEventType) {},
                        ),
                      ),
                      SizedBox(height: Device.height(3.0)),

                      // ### Description Field
                      CustomTextFormField(
                        maxLines: null,
                        label: 'Description',
                        enabled: _areThingsEnabled,
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) => _description = value,
                      ),
                    ],
                  ),

                  SizedBox(height: Device.height(2.0)),

                  // ### Date Picker Part 3
                  // Hours Wasted 6 😢
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DatePickerButton(
                        title: "Starts",
                        icon: Icons.today_rounded,
                        initialSelectedDate: _selectedStartingDate,
                        firstSelectableDate: _firstSelectableStartingDate,
                        lastSelectableDate: _lastSelectableStartingDate,
                        onTap: (date) {
                          DateTime setDate = date;
                          setState(
                            () {
                              _selectedStartingDate = setDate;
                              _selectedEndingDate =
                                  setDate.add(Duration(minutes: 30));
                              _firstSelectableEndingDate =
                                  setDate.add(Duration(minutes: 5));
                            },
                          );
                        },
                      ),
                      DatePickerButton(
                        title: "Ends",
                        initialSelectedDate: _selectedEndingDate,
                        firstSelectableDate: _firstSelectableEndingDate,
                        lastSelectableDate: _lastSelectableEndingDate,
                        onTap: (date) => setState(
                          () {
                            _selectedEndingDate = date;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
