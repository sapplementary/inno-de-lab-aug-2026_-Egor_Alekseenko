"""
Задание 1.
Разработка модуля учета успеваемости
стажеров (Trainee LMS)
"""

class Trainee:
    def __init__(self, name: str, surname: str, score: int = 0, passing_grade: int = 10) -> None:
        self.name: str = name
        self.surname: str = surname
        self.__score: int = score
        self.passing_grade: int = passing_grade

    @property
    def score(self) -> int:
        return self.__score

    @score.setter
    def score(self, value):
        if not isinstance(value, int):
            raise TypeError(f"Expected value of type int, got {type(value)}")
        if value < 0:
            raise ValueError("The score shouldn't be less than 0!")
        else:
            self.__score = value

    def do_homework(self) -> None:
        """Increases score by 1"""
        self.score += 1

    def miss_homework(self) -> None:
        """Decreases score by 1"""
        self.score -= 1

    def visit_lecture(self) -> None:
        """Increases score by 1"""
        self.score += 1

    def miss_lecture(self) -> None:
        """Decreases score by 1"""
        self.score -= 1

    def is_passing(self) -> bool:
        return self.score >= self.passing_grade



# 1. Создание стажера с начальным баллом 9 и проходным баллом 10
#trainee = Trainee(name="Иван", surname="Иванов", score=9,passing_grade=10)

# 2. Выполнение домашнего задания и проверка статуса
#trainee.do_homework()
#print(f"Баллы: {trainee.score}, Прошел курс:{trainee.is_passing()}")

# 3. Пропуск лекции и проверка статуса
#trainee.miss_lecture()
#print(f"Баллы: {trainee.score}, Прошел курс:{trainee.is_passing()}")

# 4. Проверка валидации (попытка задать неверный тип или отрицательное значение)
#try:
#    trainee.score = -5
#except ValueError as e:
#    print(f"Ошибка: {e}")


"""
Задание 2 (дополнительно)
Расширение Trainee LMS: разные типы учащихся + класс "Учебная группа".
"""

class HardworkingTrainee(Trainee):
    def do_homework(self) -> None:
        """Increases score by 2"""
        self.score += 2

class AuditTrainee (Trainee):
    def is_passing(self) -> bool:
        return True

class Cohort:
    def __init__(self, title: str = "Python Core 2026", trainees: list[Trainee] = []) -> None:
        self.title = title
        self.trainees = trainees

    def add_trainee(self, trainee: Trainee) -> None:
        self.trainees.append(trainee)

    def conduct_lecture(self) -> None:
        for trainee in self.trainees:
            trainee.visit_lecture()

    def get_passing_students(self) -> list[Trainee]:
        for trainee in self.trainees:
            if trainee.is_passing():
                return self.trainees


# 1. Создаем учащихся разных типов
std_trainee = Trainee(
    "Алексей",
    "Смирнов",
    score=8,
    passing_grade=10
)

hard_trainee = HardworkingTrainee(
    "Елена",
    "Петрова",
    score=8,
    passing_grade=10
)

audit_trainee = AuditTrainee(
    "Дмитрий",
    "Сидоров",
    score=0,
    passing_grade=10
)

# 2. Создаем группу и добавляем студентов
cohort = Cohort("Python Advanced")
cohort.add_trainee(std_trainee)
cohort.add_trainee(hard_trainee)
cohort.add_trainee(audit_trainee)

# 3. Проводим лекцию для всей группы (+1 балл всем)
cohort.conduct_lecture()

# 4. Проверяем работу переопределенного ДЗ для трудоголика (+2 балла)
hard_trainee.do_homework()

# 5. Выводим список тех, кто проходит курс
passing_students = cohort.get_passing_students()

print(f"=== УСПЕВАЕМОСТЬ ГРУППЫ '{cohort.title}' ===")
for student in cohort.trainees:
    print(f"{student.name} {student.surname} | Баллы: {student.score} | Проходит: {student.is_passing()}")
    print()

print("\nУспешно зачислены на следующий модуль:")
for student in passing_students:
    print(f"- {student.name} {student.surname}")
    print()
