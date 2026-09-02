"""
1 задача:
Расчет стоимости оптовой аренды фильмов
"""

MAX_RENTAL_BATCH_LIMIT = 150.0

def calculate_rental_batch(quantity: int, rental_rate: float, discount: float = 0.0) -> tuple[float, bool]:
    """Рассчитывает стоимость партии дисков и проверяет лимит
    Args:
        quantity: Количество дисков в партии.
        rental_rate: Стоимость аренды одного диска
        discount: Размер скидки в виде десятичной дроби.

    Returns:
        Кортеж из двух значений: итоговая стоимость партии и признак превышения лимита.
    """
    finally_sum = round(quantity * rental_rate * (1 - discount), 2)
    check_limit =  finally_sum > MAX_RENTAL_BATCH_LIMIT

    return finally_sum, check_limit


# 1 партия
batch_1 = calculate_rental_batch(30, 2.99)

# 2 партия
batch_2 = calculate_rental_batch(quantity=40, rental_rate=4.99, discount=0.10)

# 3 партия
batch_3 = calculate_rental_batch(10, 1.99)

# 4 партия
batch_4 = calculate_rental_batch(quantity=50, rental_rate=3.50, discount=0.20)

final_sum, is_limit_exceeded = batch_1
print(f"Партия 1: Сумма {final_sum}$. Превышение лимита: {is_limit_exceeded}")

final_sum, is_limit_exceeded = batch_2
print(f"Партия 2: Сумма {final_sum}$. Превышение лимита: {is_limit_exceeded}")

final_sum, is_limit_exceeded = batch_3
print(f"Партия 3: Сумма {final_sum}$. Превышение лимита: {is_limit_exceeded}")

final_sum, is_limit_exceeded = batch_4
print(f"Партия 4: Сумма {final_sum}$. Превышение лимита: {is_limit_exceeded}")
