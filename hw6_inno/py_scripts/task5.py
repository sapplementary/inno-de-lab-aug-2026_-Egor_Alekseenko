"""
task 5
Напишите программу, которая генерирует случайное число от 1 до 20. У пользователя есть 5 попыток, чтобы его угадать.
На каждом шаге программа подсказывает («Слишком много!» или «Слишком мало!») и сообщает, сколько попыток осталось.
Игра завершается, если число угадано или закончились попытки.
"""
import random

print('Я загадал число от 1 до 20. У тебя 5 попыток!')

max_attempts = 5
attempt = 1
number = random.randint(1, 20)

while attempt <= max_attempts:
    my_num = int(input(f'Попытка {attempt}. Введите число: '))
    attempts_left = max_attempts - attempt

    if my_num > number:
        print(f'Слишком много! Осталось попыток: {attempts_left}')

    elif my_num < number:
        print(f'Слишком мало! Осталось попыток: {attempts_left}')

    elif my_num == number:
        print('Ты угадал! Отличная работа')
        break

    attempt += 1

else:
    print(f'Попытки закончились. Загаданное число: {number}')
