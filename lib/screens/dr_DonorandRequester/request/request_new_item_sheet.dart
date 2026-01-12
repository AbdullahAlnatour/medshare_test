import 'package:flutter/material.dart';
import '../../../../widgets/toggle_pill.dart';
import '../../../../theme/colors.dart';
import '../../../features/auth/data/unavailable donation/reqeust_service.dart';

class RequestNewItemSheet extends StatefulWidget {
  const RequestNewItemSheet({super.key});

  @override
  State<RequestNewItemSheet> createState() => _RequestNewItemSheetState();
}

class _RequestNewItemSheetState extends State<RequestNewItemSheet> {
  final _formKey = GlobalKey<FormState>();
  final _service = RequestService();

  String _type = "Medicine";

  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  bool _sending = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _sending = true);

    try {
      if (_type == "Medicine") {
        await _service.createUnavailableMedicine(
          itemName: _nameCtrl.text.trim(),
          description: _descCtrl.text.trim(),
        );
      } else {
        await _service.createUnavailableEquipment(
          itemName: _nameCtrl.text.trim(),
          description: _descCtrl.text.trim(),
        );
      }


      if (!mounted) return;

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request submitted")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed: $e")),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 50),
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
                  validator: (v) => v == null || v.isEmpty ? "Required" : null,
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

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _sending ? null : () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _sending ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kTeal,
                        ),
                        child: _sending
                            ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text("Send"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
