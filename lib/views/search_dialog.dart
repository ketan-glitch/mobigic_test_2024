import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base/common_button.dart';
import 'base/input_decoration.dart';
import 'question_screen.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({Key? key}) : super(key: key);

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enter a word to search",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14.0,
                  ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: searchTextEditingController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a word';
                }
                return null;
              },
              inputFormatters: [
                // FilteringTextInputFormatter(RegExp(r'^[a-zA-Z]+$'), allow: true, replacementString: getReplacementString()),
                FilteringTextInputFormatter.allow(nameRegExp),
              ],
              cursorColor: Theme.of(context).primaryColor,
              textAlign: TextAlign.center,
              onChanged: (value) {},
              decoration: CustomDecoration.inputDecoration(label: 'Type cat, bat, etc'),
            ),
            const SizedBox(height: 20),
            CustomButton(
              type: ButtonType.primary,
              onTap: () {
                if (searchTextEditingController.text.isNotEmpty) {
                  Navigator.pop(context, searchTextEditingController.text);
                }
              },
              title: "Search",
            ),
          ],
        ),
      ),
    );
  }
}
