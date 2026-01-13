import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import '../../../../widgets/toggle_pill.dart';
import '../../../../theme/colors.dart';
import '../../../features/auth/data/request/create_equipment_request.dart';

class DonateNewItemSheet extends StatefulWidget {
  const DonateNewItemSheet({super.key});

  @override
  State<DonateNewItemSheet> createState() => _DonateNewItemSheetState();
}

class _DonateNewItemSheetState extends State<DonateNewItemSheet> {
  final _formKey = GlobalKey<FormState>();

  String _type = "Medicine";
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  // Medicine fields
  final _medNameCtrl = TextEditingController();
  final _strengthCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  String? _dosageForm;
  DateTime? _expiryDate;
  bool _sealed = false;

  // Equipment fields
  final _deviceCtrl = TextEditingController();
  final _accessoriesCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController();
  String? _condition;
  bool _functional = false;

  // ===================== ENUM MAPPERS (مهم جدًا) =====================

  int _mapDosageToEnum(String dosage) {
    switch (dosage) {
      case "Capsules":
        return 1;
      case "Syrup":
        return 2;
      case "Injection":
        return 3;
      case "Cream":
        return 4;
      case "Other":
        return 5;
      default:
        return 0;
    }
  }

  int _mapConditionToEnum(String condition) {
    switch (condition) {
      case "New":
        return 0;
      case "Like New":
        return 1;
      case "Used (Good)":
        return 2;
      default:
        return 0;
    }
  }

  // ===================== IMAGE & DATE PICKERS =====================

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) setState(() => _expiryDate = picked);
  }

  Future<void> _pickImages() async {
    final result = await _picker.pickMultiImage(imageQuality: 70);
    if (result.isNotEmpty) {
      if (_images.length + result.length > 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Max 3 images allowed")),
        );
        return;
      }
      setState(() {
        _images.addAll(result); // result هو List<XFile>
      });
    }
  }

  // ===================== SUBMIT (BACKEND CONNECTED) =====================

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_images.isEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload at least 1 image")),
      );
      return;
    }

    try {
      if (_type == "Medicine") {
        await createMedicineRequest(
          itemName: _medNameCtrl.text,
          itemDesc: null,
          strength: _strengthCtrl.text,
          quantity: int.tryParse(_qtyCtrl.text) ?? 0,
          dosageForm: _mapDosageToEnum(_dosageForm!),
          expirationDate: _expiryDate!,
          isAvailable: true,
          unOpened: _sealed,
          images: _images,

        );
      } else {
        await createEquipmentRequest(
          itemName: _deviceCtrl.text,
          itemDesc: null,
          quantity: int.tryParse(_quantityCtrl.text) ?? 0,
          condition: _mapConditionToEnum(_condition!),
          accessories: _accessoriesCtrl.text,
          isAvailable: true,
          isWorkingFully: _functional,
          images: _images, // ✅
        );
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.green,content: Text("Donation submitted successfully"),),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(backgroundColor: Colors.redAccent,content: Text("Failed to Upload Donation")));
    }
  }

  // ===================== UI (UNCHANGED) =====================

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 40),
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
                  "New Donation",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_buildImagePicker()],
                ),

                const SizedBox(height: 16),

                if (_type == "Medicine") _buildMedicineForm(),
                if (_type == "Equipment") _buildEquipmentForm(),

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
                          backgroundColor: kTeal,
                        ),
                        child: const Text("Submit"),
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

  // ===================== REMAINING UI HELPERS (UNCHANGED) =====================

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Upload Images (max 3)*",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),

        Wrap(
          spacing: 10,
          children: [
            ..._images.asMap().entries.map((e) => Stack(
              children: [
                Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: kIsWeb
                      ? FutureBuilder<Uint8List>(
                    future: e.value.readAsBytes(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          snapshot.data!,
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(e.value.path),
                      width: 85,
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  right: -10,
                  top: -10,
                  child: IconButton(
                    icon: const Icon(Icons.close,
                        size: 22, color: Colors.red),
                    onPressed: () {
                      setState(() => _images.removeAt(e.key));
                    },
                  ),
                ),
              ],
            )),
            if (_images.length < 3)
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    color: kTeal.withOpacity(.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.add_photo_alternate,
                      size: 30, color: kTeal),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildMedicineForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _medNameCtrl,
          decoration: const InputDecoration(
              labelText: "Medication Name *", border: OutlineInputBorder()),
          validator: (v) => v!.isEmpty ? "Required" : null,
        ),
        const SizedBox(height: 12),

        TextFormField(
          controller: _strengthCtrl,
          decoration: const InputDecoration(
              labelText: "Strength (500mg)*", border: OutlineInputBorder()),
          validator: (v) => v!.isEmpty ? "Required" : null,
        ),
        const SizedBox(height: 12),

        DropdownButtonFormField(
          value: _dosageForm,
          items: const [
            "Capsules",
            "Syrup",
            "Injection",
            "Cream",
            "Other",
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => _dosageForm = v),
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: "Dosage Form *"),
          validator: (v) => v == null ? "Required" : null,
        ),
        const SizedBox(height: 12),

        TextFormField(
          controller: _qtyCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              labelText: "Quantity *", border: OutlineInputBorder()),
          validator: (v) => v!.isEmpty ? "Required" : null,
        ),
        const SizedBox(height: 12),

        InkWell(
          onTap: _pickDate,
          child: InputDecorator(
            decoration: const InputDecoration(
                labelText: "Expiry Date *", border: OutlineInputBorder()),
            child: Text(
              _expiryDate == null
                  ? "Tap to select"
                  : "${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}",
              style: TextStyle(
                  color: _expiryDate == null ? Colors.grey : Colors.black),
            ),

          ),
        ),
        const SizedBox(height: 12),

        CheckboxListTile(
          title: const Text("Unopened (sealed)"),
          value: _sealed,
          onChanged: (v) => setState(() => _sealed = v!),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ],
    );
  }

  Widget _buildEquipmentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _deviceCtrl,
          decoration: const InputDecoration(
            labelText: "Device Name *",
            border: OutlineInputBorder(),
          ),
          validator: (v) => v!.isEmpty ? "Required" : null,
        ),
        const SizedBox(height: 12),

        DropdownButtonFormField(
          value: _condition,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: "Condition *"),
          items: const ["New", "Like New", "Used (Good)"]
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => _condition = v),
          validator: (v) => v == null ? "Required" : null,
        ),
        const SizedBox(height: 12),

        TextFormField(
          controller: _accessoriesCtrl,
          decoration: const InputDecoration(
            labelText: "Accessories (Optional)",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),

        TextFormField(
          controller: _quantityCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Quantity *",
            border: OutlineInputBorder(),
          ),
          validator: (v) => v!.isEmpty ? "Required" : null,
        ),

        CheckboxListTile(
          title: const Text("Fully Functional"),
          value: _functional,
          onChanged: (v) => setState(() => _functional = v!),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ],
    );
  }

}
