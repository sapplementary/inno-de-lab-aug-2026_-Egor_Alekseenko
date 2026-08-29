"""
Задание 2. Мониторинг производительности аналитики
(Декораторы и Lambda)
"""
import time
from typing import Callable, Any


PERFORMANCE_LOG_PREFIX = "[PERF_LOG]"
TIME_DECIMALS = 8

def performance_logger(func: Callable[..., Any]) -> Callable[...,Any]:
    """
    Декоратор для замера и логирования времени выполнения функции.

    Оборачивает целевую функцию, фиксирует момент начала и окончания
    её выполнения через time.perf_counter(), вычисляет затраченное время
    и выводит сообщение в лог перед возвратом результата вызывающему коду.

    Args:
        func (Callable[..., Any]): Целевая функция, время выполнения
            которой требуется измерить. Может принимать произвольные
            позиционные и именованные аргументы.

    Returns:
        Callable[..., Any]: Функция-обёртка (wrapper), которая выполняет
        func с переданными аргументами, логирует время выполнения и
        возвращает результат работы func без изменений.
    """
    def wrapper(*args: Any, **kwargs: Any) -> Any:
        """Внутренняя обёртка, замеряющая время выполнения func.

        Args:
            *args (Any): Позиционные аргументы, передаваемые в func.
            **kwargs (Any): Именованные аргументы, передаваемые в func.

        Returns:
            Any: Результат выполнения оригинальной функции func.
        """
        start_time = time.perf_counter()
        result = func(*args, **kwargs)
        elapsed_time = time.perf_counter() - start_time

        print(
            f"{PERFORMANCE_LOG_PREFIX} Функция '{func.__name__}' "
            f"выполнена за {elapsed_time:.{TIME_DECIMALS}f} сек."
        )

        return result

    return wrapper

@performance_logger
def get_sorted_report(
    genre_revenue_data: list[dict[str, str | float]]
) -> list[dict[str, str | float]]:
    """Сортирует данные о выручке по жанрам в порядке убывания продаж.

    Принимает список словарей, где каждый словарь описывает жанр фильма
    и его финансовые показатели, и возвращает новый список, отсортированный
    по ключу 'total_sales' от наибольшего значения к наименьшему.

    Args:
        genre_revenue_data (list[dict[str, str | float]]): Список словарей
            с данными по выручке жанров. Каждый словарь должен содержать
            как минимум ключ 'total_sales' (float) с суммой продаж.

    Returns:
        list[dict[str, str | float]]: Новый список словарей, отсортированный
        по убыванию значения 'total_sales'.
    """
    sorted_data = sorted(
        genre_revenue_data,
        key=lambda genre: genre["total_sales"],
        reverse=True,
    )
    return sorted_data

test_sets: list[list[dict[str, str | float]]] = [
    [
        {"category": "Action", "total_sales": 4311.85},
        {"category": "Animation", "total_sales": 4656.30},
        {"category": "Children", "total_sales": 3655.55},
    ],
    [
        {"category": "Classics", "total_sales": 1200.10},
        {"category": "Comedy", "total_sales": 4000.00},
        {"category": "Documentary", "total_sales": 4000.00},
    ],
    [
        {"category": "Drama", "total_sales": 500.00},
    ],
]

for i, data in enumerate(test_sets, start=1):
        print(f"--- ТЕСТ {i} ---")
        sorted_report = get_sorted_report(data)

        print("Топ категорий по выручке:")
        for rank, item in enumerate(sorted_report, start=1):
            print(f"{rank}. {item['category']}: {item['total_sales']}")

