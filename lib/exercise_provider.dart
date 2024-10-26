import 'package:flutter_riverpod/flutter_riverpod.dart';

class Exercise {
  String name;
  bool isCompleted;

  Exercise(this.name, {this.isCompleted = false});
}

final exerciseListProvider =
    StateNotifierProvider<ExerciseListNotifier, List<Exercise>>(
  (ref) => ExerciseListNotifier(),
);

class ExerciseListNotifier extends StateNotifier<List<Exercise>> {
  ExerciseListNotifier() : super([]);

  void addExercise(String name) {
    state = [...state, Exercise(name)];
  }

  void toggleExerciseCompletion(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Exercise(state[i].name, isCompleted: !state[i].isCompleted)
        else
          state[i]
    ];
  }
}
