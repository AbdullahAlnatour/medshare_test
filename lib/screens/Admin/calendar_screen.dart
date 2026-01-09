import 'package:flutter/material.dart';
import '../../core/storage/user_storage.dart';
import '../../features/auth/data/tasks/task_response_model.dart';
import '../../features/auth/data/tasks/task_service.dart';
import '../../features/auth/data/tasks/create_task_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  final TaskService _taskService = TaskService();
  bool _loading = true;

  List<TaskResponseModel> tasks = [];

  final Color darkTeal = const Color(0xFF085D62);
  final Color lightTealAccent = const Color(0xFF34AFB7);

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final data = await _taskService.getAllTasks();
      setState(() => tasks = data);
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Calendar',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildDateTextField(),
          _buildDivider(),
          Expanded(child: _buildTasksList()),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildDateTextField() {
    final dateText =
        '${_getDayName(selectedDate.weekday)}, ${_getMonthName(selectedDate.month)} ${selectedDate.day}, ${selectedDate.year}';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        readOnly: true,
        controller: TextEditingController(text: dateText),
        decoration: InputDecoration(
          labelText: 'Select Date',
          prefixIcon: Icon(Icons.calendar_today, color: lightTealAccent),
          suffixIcon: Icon(Icons.arrow_drop_down, color: lightTealAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF34AFB7), // 🔵 اللون الرئيسي (الهيدر + اليوم المحدد)
                    onPrimary: Colors.white,    // لون النص داخل الهيدر
                    onSurface: Colors.black,    // لون النص العام
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF34AFB7), // CANCEL / OK
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) setState(() => selectedDate = picked);
        },
      ),
    );
  }

  Widget _buildTasksList() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredTasks = tasks.where((t) =>
    t.dueDate.year == selectedDate.year &&
        t.dueDate.month == selectedDate.month &&
        t.dueDate.day == selectedDate.day).toList();

    if (filteredTasks.isEmpty) {
      return const Center(child: Text("No tasks for this day."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) =>
          _buildTaskCard(filteredTasks[index]),
    );
  }

  Widget _buildTaskCard(TaskResponseModel task) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              TimeOfDay.fromDateTime(task.dueDate).format(context),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: darkTeal.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.task_alt, color: lightTealAccent),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task #${task.taskId}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          task.notes ?? '',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Color(0xFF34AFB7),
                    onPressed: () async {
                      final controller = TextEditingController(text: task.notes);

                      final updated = await showDialog<String>(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: const Text('Edit Notes'),
                          content: TextField(
                            controller: controller,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: 'Enter notes',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel',style: TextStyle(color: Color(0xFF34AFB7)),),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF34AFB7), // لون الخلفية
                                foregroundColor: Colors.white,            // لون النص
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, controller.text),
                              child: const Text('Save',style: TextStyle(backgroundColor: Color(0xFF34AFB7))),
                            ),
                          ],
                        ),
                      );

                      if (updated != null) {
                        await _taskService.updateTaskNotes(
                          taskId: task.taskId,
                          notes: updated,
                        );

                        setState(() {
                          task.notes = updated; // UI update
                        });
                      }
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.redAccent),
                    onPressed: () async {
                      await _taskService.cancelTask(task.taskId);

                      setState(() {
                        tasks.removeWhere((t) => t.taskId == task.taskId);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkTeal,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: _showAddTaskDialog,
          child: const Text(
            'Add Task',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // ---------------- ADD TASK DIALOG ----------------

  void _showAddTaskDialog() {
    final notesController = TextEditingController();
    final timeController = TextEditingController();
    TimeOfDay? selectedTime;

    String? notesError;
    String? timeError;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Center(
            child: Text("Add New Task",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Time',
                  errorText: timeError,
                  prefixIcon:
                  const Icon(Icons.access_time, color: Colors.grey),
                ),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          timePickerTheme: const TimePickerThemeData(
                            dialHandColor: Color(0xFF34AFB7),
                            dialBackgroundColor: Color(0xFFEEF6F6),
                            hourMinuteColor: Color(0xFF34AFB7),
                            hourMinuteTextColor: Colors.white,
                            dayPeriodColor: Color(0xFF34AFB7),
                            dayPeriodTextColor: Colors.white,
                          ),
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF34AFB7), // OK button + selected
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setDialogState(() {
                      selectedTime = picked;
                      timeController.text = picked.format(context);
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  labelText: 'Notes',
                  errorText: notesError,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkTeal,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                setDialogState(() {
                  notesError = notesController.text.isEmpty ? 'Required' : null;
                  timeError = selectedTime == null ? 'Required' : null;
                });

                if (notesError != null || timeError != null) return;

                final dueDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );

                // ✅ 2) استدعي createTask مع adminId
                await _taskService.createTask(
                  dueDate: dueDateTime,
                  notes: notesController.text,
                );

                // ✅ 3) أمان بعد await
                if (!mounted) return;

                Navigator.pop(context);
                _loadTasks();
              }
,
              child: const Text(
                "Add",
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    final count = tasks.where((t) =>
    t.dueDate.year == selectedDate.year &&
        t.dueDate.month == selectedDate.month &&
        t.dueDate.day == selectedDate.day).length;

    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: Colors.grey.shade300),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: Text("There are $count plans",
              style: TextStyle(color: Colors.grey.shade600)),
        ),
      ],
    );
  }

  String _getDayName(int weekday) =>
      ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][weekday % 7];

  String _getMonthName(int month) => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ][month - 1];
}
