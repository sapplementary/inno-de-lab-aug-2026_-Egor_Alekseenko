"""
Дан список сырых строк, представляющих транзакции в формате
СТАТУС:СУММА. Требуется написать однострочное выражение (генератор списка)
"""

# Список транзакций, полученных от платежного шлюза
raw_transactions = ["SUCCESS:100", "FAILED:50", "SUCCESS:-10", "SUCCESS:0", "SUCCESS:250" ,"ERROR:200"]
# Реализация фильтрации в одну строку с помощью List Comprehension
# Ваш код здесь

result = [
    int(amount)
    for transaction in raw_transactions
    for status, amount in [transaction.split(':')] 
    if status == 'SUCCESS' and int(amount) > 0
]

print(f'Очищенные транзакции: {result}')
