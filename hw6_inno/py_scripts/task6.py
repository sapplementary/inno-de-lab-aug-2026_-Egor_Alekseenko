"""
task 6
Напишите программу, которая работает как простой калькулятор.
Программа должна запросить у пользователя два числа и символ операции (+, *, -, /), а затем выполнить расчёт и вывести результат.
"""
try:
    first_num = float(input('Введите первое число: '))
    second_num = float(input('Введите второе число: '))
except ValueError:
    print('Нужно ввести число!')

choice = input('Выбери оператор (+, -, *, /): ')

# в этом задании мне удобнее использовать match case
match choice:
    case '+':
        print(f'Результат: {first_num} + {second_num} = {first_num + second_num}')
    case '-':
        print(f'Результат: {first_num} - {second_num} = {first_num - second_num}')
    case '*':
        print(f'Результат: {first_num} * {second_num} = {first_num * second_num}')
    case '/':
        if second_num == 0:
            print('На ноль делить нельзя')
        else:
            print(f'Результат: {first_num} / {second_num} = {first_num / second_num}')
    case _:
        print('Неизвестный знак, можно только (+, -, *, /)')

