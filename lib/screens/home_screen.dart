import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'first_screen.dart';
import 'second_screen.dart';
import 'package:gymtodo/exercise_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GymToDo',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF77C7FF), Color(0xFF4A90E2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.15,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              List<Exercise> exercises = ref.watch(exerciseListProvider);

              return exercises.isEmpty
                  ? Center(
                      child: Text(
                        'No exercises added yet.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: exercises.length,
                        itemBuilder: (context, index) {
                          final exercise = exercises[index];
                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(bottom: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            shadowColor: Colors.blue.withOpacity(0.3),
                            child: ListTile(
                              title: Text(
                                exercise.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  decoration: exercise.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              trailing: Checkbox(
                                value: exercise.isCompleted,
                                onChanged: (_) {
                                  ref
                                      .read(exerciseListProvider.notifier)
                                      .toggleExerciseCompletion(index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
            },
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Exercise'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstScreen()), // FIXED HERE
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF77C7FF), // Blue color for background
              foregroundColor: const Color.fromARGB(255, 0, 0, 0), // Black text color
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text('Delete Exercise'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF77C7FF), // Blue color for background
              foregroundColor: const Color.fromARGB(255, 0, 0, 0), // Black text color
            ),
          ),
        ],
      ),
    );
  }
}
