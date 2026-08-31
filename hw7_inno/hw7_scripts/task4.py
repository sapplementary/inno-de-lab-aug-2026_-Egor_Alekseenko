"""
Задача 4: Аудит прав доступа и дедупликация
Написать модуль аудита безопасности
"""

# Список ролей, переданный в запросе на авторизацию (содержит повторы)
requested_roles = ["guest", "developer", "guest", "admin", "developer", "guest"]

# Набор обязательных ролей для выполнения административных функций
required_admin_roles = {"admin", "security_officer", "audit_manager"}

# Ваш код здесь

unique_requested_roles = set(requested_roles)

match_role = unique_requested_roles & required_admin_roles

missing_admin_roles = required_admin_roles - unique_requested_roles

availability_security_officer = 'security_officer' in unique_requested_roles

print(f'Уникальные запрошенные роли: {unique_requested_roles}')
print(f'Общие административные роли: {match_role}')
print(f'Недостающие административные роли: {missing_admin_roles}')
print(f'Наличие роли security_officer в запросе: {availability_security_officer}')
