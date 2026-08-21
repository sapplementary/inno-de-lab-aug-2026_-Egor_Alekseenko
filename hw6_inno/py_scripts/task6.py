"""
task 6
Напишите программу, которая работает как простой калькулятор.
Программа должна запросить у пользователя два числа и символ операции (+, *, -, /), а затем выполнить расчёт и вывести результат.
"""

first_num = int(input(f'Введите первое число: '))
second_num = int(input(f'Введите второе число: '))

choice = input(f'Выбери оператор (+, -, *, /): ')

# в этом задании мне удобнее использовать match case
match choice:
    case '+':
        print(f'Результат: {first_num} + {second_num} = {first_num + second_num}')
    case '-':
        print(f'Результат: {first_num} - {second_num} = {first_num - second_num}')
    case '*':
        print(f'Результат: {first_num} * {second_num} = {first_num * second_num}')
    case '/':
        print(f'Результат: {first_num} / {second_num} = {first_num / second_num}')

