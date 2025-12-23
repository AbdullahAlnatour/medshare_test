import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime(2024, 12, 13);
  DateTime currentMonth = DateTime(2024, 12);
  bool isEditMode = false;
      final timeController = TextEditingController();
    final titleController = TextEditingController();
  @override
  void dispose() {
    timeController.dispose();
    titleController.dispose();
    super.dispose();
  }
  List<Task> tasks = [
    Task(
      time: '3:20PM',
      title: 'Oxycontin',
      status: 'Not Match yet',
      icon: Icons.medication,
      isMatched: false,
      matchedTo: null,
    ),
    Task(
      time: '7:45PM',
      title: 'Patient bed',
      status: 'Matched to Dana Ahmad',
      icon: Icons.bed,
      isMatched: true,
      matchedTo: 'Dana Ahmad',
    ),
    Task(
      time: '10:00PM',
      title: 'Amoxicillin',
      status: 'Matched to Rama Noel',
      icon: Icons.medication,
      isMatched: true,
      matchedTo: 'Rama Noel',
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Calendar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Date Text Field
          _buildDateTextField(),
          
          // Divider with text
          _buildDivider(),
          
          // Tasks List
          Expanded(
            child: _buildTasksList(),
          ),
          
          // Action Button
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildDateTextField() {
    final dateText = '${_getDayName(selectedDate.weekday)}, ${_getMonthName(selectedDate.month)} ${selectedDate.day}, ${selectedDate.year}';
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        readOnly: true,
        controller: TextEditingController(text: dateText),
        decoration: InputDecoration(
          labelText: 'Select Date',
          hintText: 'Tap to select date',
          prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF34AFB7)),
          suffixIcon: const Icon(Icons.arrow_drop_down, color: Color(0xFF34AFB7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF34AFB7), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF34AFB7),
                    onPrimary: Colors.white,
                    onSurface: Colors.black87,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null && picked != selectedDate) {
            setState(() {
              selectedDate = picked;
              currentMonth = DateTime(picked.year, picked.month);
            });
          }
        },
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[weekday % 7];
  }

  Widget _buildDivider() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: Text(
            "There's three plans-",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTasksList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return _buildTaskCard(tasks[index], index);
      },
    );
  }

  Widget _buildTaskCard(Task task, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time
          SizedBox(
            width: 70,
            child: Text(
              task.time,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Task Card
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: task.isCompleted 
                    ? const Color(0xFF34AFB7).withValues(alpha: 0.2)
                    : const Color(0xFF34AFB7).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Icon and Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // Toggle between original icon and done icon
                                tasks[index].isDone = !tasks[index].isDone;
                              });
                            },
                            child: Icon(
                              tasks[index].isDone ? Icons.check_circle : tasks[index].icon,
                              color: tasks[index].isDone 
                                  ? Color(0xFF34AFB7) 
                                  : Color(0xFF34AFB7),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  task.status,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Completed checkmark or Edit icon
                  if (task.isCompleted)
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF34AFB7).withValues(alpha: 0.3),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: IconButton(
                        icon: Icon(
                          isEditMode ? Icons.save : Icons.edit,
                          size: 20,
                        ),
                        color: isEditMode ? const Color(0xFF34AFB7) : Colors.grey.shade700,
                        onPressed: () {
                          setState(() {
                            if (isEditMode) {
                              // Exit edit mode - icon changes to edit
                              isEditMode = false;
                            } else {
                              // Enter edit mode - icon changes to save
                              isEditMode = true;
                            }
                          });
                          // If exiting edit mode, show dialog after state update
                          if (!isEditMode) {
                            Future.delayed(const Duration(milliseconds: 100), () {
                              _showTaskAssignedDialog();
                            });
                          }
                        },
                      ),
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
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (isEditMode) {
              setState(() {
                isEditMode = false;
              });
              // Small delay to ensure UI updates before showing dialog
              Future.delayed(const Duration(milliseconds: 100), () {
                _showTaskAssignedDialog();
              });
            } else {
              // Show add task dialog
              _showAddTaskDialog();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF34AFB7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            
          ),
          child: Text(
            isEditMode ? 'Save changes' : 'Add Task',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }


  void _showAddTaskDialog() {


    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) {
        IconData selectedIcon = Icons.medication;
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add New Task',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Time picker
                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      hintText: 'e.g., 3:20PM',
                      prefixIcon: const Icon(Icons.access_time, color: Color(0xFF34AFB7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF1DB9A3), width: 2),
                      ),
                    ),
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: dialogContext,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF34AFB7),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        final hour = picked.hour > 12 ? picked.hour - 12 : (picked.hour == 0 ? 12 : picked.hour);
                        final minute = picked.minute.toString().padLeft(2, '0');
                        final period = picked.hour >= 12 ? 'PM' : 'AM';
                        final selectedTime = '$hour:$minute$period';
                        timeController.text = selectedTime;
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  // Title input
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                      hintText: 'e.g., Oxycontin, Patient bed',
                      prefixIcon: const Icon(Icons.task, color: Color(0xFF34AFB7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF34AFB7), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Icon selector
                  const Text(
                    'Select Icon',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIconOption(Icons.medication, selectedIcon, setDialogState, () {
                        setDialogState(() {
                          selectedIcon = Icons.medication;
                        });
                      }),
                      _buildIconOption(Icons.bed, selectedIcon, setDialogState, () {
                        setDialogState(() {
                          selectedIcon = Icons.bed;
                        });
                      }),
                      _buildIconOption(Icons.local_hospital, selectedIcon, setDialogState, () {
                        setDialogState(() {
                          selectedIcon = Icons.local_hospital;
                        });
                      }),
                      _buildIconOption(Icons.medical_services, selectedIcon, setDialogState, () {
                        setDialogState(() {
                          selectedIcon = Icons.medical_services;
                        });
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (timeController.text.isNotEmpty && titleController.text.isNotEmpty) {
                              setState(() {
                                tasks.add(Task(
                                  time: timeController.text,
                                  title: titleController.text,
                                  status: 'Not Match yet',
                                  icon: selectedIcon,
                                  isMatched: false,
                                  matchedTo: null,
                                ));
                              });
                              Navigator.pop(dialogContext);
                              
                              _showTaskAssignedDialog();
                              timeController.clear();
                              titleController.clear();
                              
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF34AFB7),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Add Task',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
      },
    );
  }

  Widget _buildIconOption(IconData icon, IconData selectedIcon, StateSetter setDialogState, VoidCallback onSelect) {
    final isSelected = icon == selectedIcon;
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF34AFB7).withValues(alpha: 0.2) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF34AFB7) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF34AFB7) : Colors.grey.shade600,
          size: 24,
        ),
      ),
    );
  }

  void _showTaskAssignedDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Task Assigned!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34AFB7),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

}

class Task {
  final String time;
  final String title;
  final String status;
  IconData icon;
  final bool isMatched;
  final String? matchedTo;
  final bool isCompleted;
  bool isDone;

  Task({
    required this.time,
    required this.title,
    required this.status,
    required this.icon,
    required this.isMatched,
    this.matchedTo,
    this.isCompleted = false,
    this.isDone = false,
  });
  
}

