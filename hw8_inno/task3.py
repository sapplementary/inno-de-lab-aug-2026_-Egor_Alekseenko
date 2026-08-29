"""
Задание 3
Безопасная обработка возвратов
(Try-Except-Finally)
"""
from typing import Any

DEFAULT_RETURN_INDEX_BASE = 10.0


def calculate_overdue_fine(title: str, days_overdue: Any, fine_rate: float) -> tuple[float, float] | None:
    """Рассчитывает штраф и индекс оборачиваемости за просрочку возврата
    Отказоустойчива к ошибкам ручного ввода: некорректный тип
    days_overdue (TypeError), нечисловая строка (ValueError) или
    нулевое количество дней (ZeroDivisionError) не прерывают
    программу — функция логирует ошибку и возвращает None

    Args:
        title (str): Название фильма, используется только для
            идентификации записи в логе ошибок
        days_overdue (Any): Дни просрочки. Тип Any, так как значение
            приходит из необработанного пользовательского ввода и
            может быть числом, строкой или некорректным типом.
        fine_rate (float): Ставка штрафа за один день просрочки

    Returns:
        tuple[float, float] | None: Кортеж (total_fine, return_index),
        либо None при ошибке во входных данных
    """
    try:
        numeric_days = float(days_overdue)
        total_fine = numeric_days * fine_rate
        return_index = DEFAULT_RETURN_INDEX_BASE / numeric_days
        print(f"Фильм: '{title}' | Итоговый штраф: {total_fine}$ | Индекс: {return_index}")
        return total_fine, return_index

    except TypeError as e:
        print(f"[OШИБКA ТИПA] Некoрректный тип дaнных для '{title}': {e}")
        print()
        return None

    except ValueError as e:
        print(f"[ОШИБКA ЗНAЧЕНИЯ] Невозможнo преобразовать дни в число для '{title}': {e}")
        print()
        return None

    except ZeroDivisionError as e:
        print(f"[ОШИБКA ДЕЛЕНИЯ НА НОЛЬ] Вoзврат без просрочки для '{title}': {e}")
        print()
        return None

    finally:
        print('Прoверка транзакции возвратa завершенa')
        print()


test_cases: list[tuple[str, Any, float]] = [
    ("Matrix", 5, 1.5),
    ("Inception", "пять", 2.0),
    ("Avatar", 0, 2.5),
    ("Interstellar", [3], 3.0),
]


for title, days_overdue, fine_rate in test_cases:
    calculate_overdue_fine(title, days_overdue, fine_rate)

