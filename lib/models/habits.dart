part of 'models.dart';

class Habits extends Equatable {
  final String habitId;
  final String habitName;
  final String habitType;
  final String typeValue;
  final String defaultHabit;
  final String positiveHabit;
  final String createdAt;
  final String updatedAt;

  Habits(
    this.habitId,
    this.habitName,
    this.habitType,
    this.typeValue,
    this.defaultHabit,
    this.positiveHabit,
    this.createdAt,
    this.updatedAt,
  );

  @override
  List<Object> get props => [
        habitId,
        habitName,
        habitType,
        typeValue,
        defaultHabit,
        positiveHabit,
        createdAt,
        updatedAt,
      ];
}
