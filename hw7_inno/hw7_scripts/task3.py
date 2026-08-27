"""
Задача 3: Безопасный парсинг конфигурации API
Написать программу для анализа конфигурации базы данных.
"""

# Конфигурационный словарь, полученный от сервиса инициализации
db_config = {
    "connection": {
        "host": "production-db.internal",
        "port": 5432,
        "user": "postgres"
    }
}

# Ваш код здесь
connection = db_config.get('connection', {})

host = connection.get('host', 'localhost')
port = connection.get('port', 5432)

ssl_setting = connection.get('ssl_setting', {})
ssl_mode = ssl_setting.get('ssl_mode', 'verify-full')

connection['user'] = 'admin'
connection['max_connection'] = 100

print(f'SSL mode: {ssl_mode}')
print('Параметры соединения:')

for key, value in connection.items():
    print(f'* {key}: {value}')
