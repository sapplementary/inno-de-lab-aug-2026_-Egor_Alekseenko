"""
Задача 5*: Сборщик метрик инфраструктуры
Разработать агрегатор метрик, который обрабатывает список кортежей
телеметрии.
"""

# Поток данных телеметрии от серверов кластера
system_telemetry = [
    ("srv_01", 12.5, 64, "online"),
    ("srv_02", 85.0, 70, "online"),
    ("srv_03", 0.0, 0, "offline"),
    ("srv_04", 45.2, 78, "online"),
    ("srv_05", 95.1, 99, "online"),
]

# Реализация конвейера агрегации метрик
# Ваш код здесь

active_names = []
active_cpu = []
active_ram = []

for node_name, cpu_load, ram_usage, status in system_telemetry:
    if status == "offline":
        continue

    active_names.append(node_name)
    active_cpu.append(cpu_load)
    active_ram.append(ram_usage)

report = {
    'active_nodes_count': len(active_names),
    'metrics': {
        'average_cpu': round(sum(active_cpu) / len(active_cpu), 2),
        'max_ram': max(active_ram),
    },
}

print(f'Активные узлы в сети: {active_names}')
print('Итоговый отчет телеметрии: ')
print(report)
