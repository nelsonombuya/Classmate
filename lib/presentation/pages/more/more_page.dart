import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../data/repositories/user_repository.dart';
import '../../common_widgets/custom_list_tile.dart';
import 'manage_units/manage_units.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserRepository _userRepository = context.read<UserRepository>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomListTile(
            icon: Icons.book_rounded,
            title: "Manage Registered Units",
            onTap: () => showBarModalBottomSheet(
              context: context,
              builder: (context) => ManageUnits(_userRepository),
            ),
          )
        ],
      ),
    );
  }
}
