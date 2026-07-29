import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const StudentifyApp());
}

class StudentifyApp extends StatelessWidget {
  const StudentifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studentify - Study Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          primary: const Color(0xFF6C5CE7),
          secondary: const Color(0xFFA29BFE),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;
  String userName = "Ezza";

  final List<String> motivationList = [
    "“Believe you can and you're halfway there.”",
    "“The secret of getting ahead is getting started.”",
    "“Small daily improvements over time lead to stunning results.”",
    "“Your future self will thank you for the hard work today!”",
    "“Focus on progress, not perfection.”",
  ];

  late String currentMotivation;

  // Task list data
  List<Map<String, dynamic>> taskList = [
    {'title': 'Complete Computer Assignment', 'isCompleted': false},
    {'title': 'Revise Flutter Layouts', 'isCompleted': true},
  ];

  @override
  void initState() {
    super.initState();
    _changeMotivation();
  }

  void _changeMotivation() {
    setState(() {
      currentMotivation =
          motivationList[Random().nextInt(motivationList.length)];
    });
  }

  void _updateUserName(String newName) {
    if (newName.trim().isNotEmpty) {
      setState(() {
        userName = newName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeTab(),
      _buildTasksTab(),
      _buildPomodoroTab(),
      _buildProfileTab(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.task_alt_rounded),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_rounded),
            label: 'Focus',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // --- TAB 1: HOME ---
  Widget _buildHomeTab() {
    int pendingCount = 0;
    int completedCount = 0;
    for (var task in taskList) {
      if (task['isCompleted'] == true) {
        completedCount++;
      } else {
        pendingCount++;
      }
    }

    return SingleChildScrollView(
      child: Column(children: [
  // Yeh raha aapka Streak Widget yahan aa jayega:
  Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.orange, width: 2),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.local_fire_department, color: Colors.orange, size: 30),
        SizedBox(width: 10),
        Text(
          "5 Day Streak! 🔥",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
      ],
    ),
  ),
  
  // Phir aapka purana Container yahan se shuru ho ga:
  Container(
    width: double.infinity,
    ...
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'STUDENTIFY 📚',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: _changeMotivation,
                      tooltip: 'Change Motivation',
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Welcome Back, $userName! ✨',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ready to conquer your goals today?',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.purple.shade50,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFF6C5CE7),
                      size: 30,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "DAILY MOTIVATION",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C5CE7),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentMotivation,
                            style: const TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildStatCard(
                  'Pending Tasks',
                  '$pendingCount',
                  Icons.assignment,
                  Colors.orange,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  'Completed',
                  '$completedCount',
                  Icons.check_circle,
                  Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String count,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(
              count,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // --- TAB 2: TASKS ---
  Widget _buildTasksTab() {
    TextEditingController taskController = TextEditingController();

    return StatefulBuilder(
      builder: (context, setTaskState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Study Tasks'),
            backgroundColor: const Color(0xFF6C5CE7),
            foregroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        decoration: const InputDecoration(
                          labelText: 'Enter a new study task...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      onPressed: () {
                        if (taskController.text.trim().isNotEmpty) {
                          setState(() {
                            taskList.add({
                              'title': taskController.text.trim(),
                              'isCompleted': false,
                            });
                          });
                          taskController.clear();
                          setTaskState(() {});
                        }
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: taskList.isEmpty
                    ? const Center(
                        child: Text(
                          'No tasks yet! Add one above.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: taskList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: taskList[index]['isCompleted'],
                                activeColor: const Color(0xFF6C5CE7),
                                onChanged: (bool? value) {
                                  setState(() {
                                    taskList[index]['isCompleted'] =
                                        value ?? false;
                                  });
                                  setTaskState(() {});
                                },
                              ),
                              title: Text(
                                taskList[index]['title'],
                                style: TextStyle(
                                  decoration: taskList[index]['isCompleted']
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: taskList[index]['isCompleted']
                                      ? Colors.grey
                                      : Colors.black87,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    taskList.removeAt(index);
                                  });
                                  setTaskState(() {});
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- TAB 3: POMODORO TIMER WITH CHARACTER ---
  Widget _buildPomodoroTab() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Timer & Study Buddy'),
        backgroundColor: const Color(0xFF6C5CE7),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF6C5CE7),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🐼', style: TextStyle(fontSize: 40)),
                    const SizedBox(width: 15),
                    const Flexible(
                      child: Text(
                        "Hi Ezza! Main aapka study companion hoon. Chalein mil kar focus karein!",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6C5CE7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '25:00',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C5CE7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Focus'),
                  ),
                  const SizedBox(width: 15),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      side: const BorderSide(color: Color(0xFF6C5CE7)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.refresh, color: Color(0xFF6C5CE7)),
                    label: const Text(
                      'Reset',
                      style: TextStyle(color: Color(0xFF6C5CE7)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- TAB 4: PROFILE & SETTINGS ---
  Widget _buildProfileTab() {
    TextEditingController nameController = TextEditingController(
      text: userName,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Profile'),
        backgroundColor: const Color(0xFF6C5CE7),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit User Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                _updateUserName(nameController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Name Updated Successfully!')),
                );
              },
              child: const Text('Save Name'),
            ),
          ],
        ),
      ),
    );
  }
}
