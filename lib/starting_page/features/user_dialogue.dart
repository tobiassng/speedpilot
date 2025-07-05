import 'package:flutter/material.dart';
import "package:speedpilot/models/card_list.dart";

class AddUserDialogue extends StatefulWidget {
  final Function(CardList) addDeviceCard;

  const AddUserDialogue(this.addDeviceCard, {super.key});
  @override
  _AddUserDialogueState createState() => _AddUserDialogueState();
}

class _AddUserDialogueState extends State<AddUserDialogue> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ipaddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget buildTextField(String hint, TextEditingController controller) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: hint,
            labelStyle: const TextStyle(color: Colors.white70),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
          ),
          controller: controller,
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Add Vehicle",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        buildTextField('Name', nameController),
        buildTextField('IP Address', ipaddressController),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            final device =
                CardList(nameController.text, "ws://${ipaddressController.text}");
            widget.addDeviceCard(device);
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
