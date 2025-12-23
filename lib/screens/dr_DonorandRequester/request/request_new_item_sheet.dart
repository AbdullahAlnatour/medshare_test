import 'package:flutter/material.dart';
import '../../../../widgets/toggle_pill.dart';
import '../../../../theme/colors.dart';

class RequestNewItemSheet extends StatefulWidget {
  @override
  State<RequestNewItemSheet> createState() => _RequestNewItemSheetState();
}

class _RequestNewItemSheetState extends State<RequestNewItemSheet> {
  final _formKey = GlobalKey<FormState>();

  String _type = "Medicine";
  String _priority = "Normal";

  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final data = {
      "type": _type,
      "priority": _priority,
      "name": _nameCtrl.text,
      "desc": _descCtrl.text,
    };

    debugPrint("NEW REQUEST => $data");

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Request submitted")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const Text(
                  "Request New Item",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TogglePill(
                      label: "Medicine",
                      isSelected: _type == "Medicine",
                      onTap: () => setState(() => _type = "Medicine"),
                    ),
                    const SizedBox(width: 10),
                    TogglePill(
                      label: "Equipment",
                      isSelected: _type == "Equipment",
                      onTap: () => setState(() => _type = "Equipment"),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    labelText: "Item Name *",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _descCtrl,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    const Text("Priority:", style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 10),
                    ChoiceChip(
                      label: const Text("Normal"),
                      selected: _priority == "Normal",
                      onSelected: (_) => setState(() => _priority = "Normal"),
                      selectedColor: kTeal,
                      labelStyle: TextStyle(
                        color: _priority == "Normal"
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ChoiceChip(
                      label: const Text("Urgent"),
                      selected: _priority == "Urgent",
                      onSelected: (_) => setState(() => _priority = "Urgent"),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color:
                            _priority == "Urgent" ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kTeal),
                        child: const Text("Send"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
