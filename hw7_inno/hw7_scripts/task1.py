"""
1 task
Разработать скрипт, который принимает на вход неочищенную строку с данными
пользователя.
"""

raw_user_record = " 10827 ; aLeXanDer_vLaDimiRov ; mInSk ; ACTIVE "

#the 1st and the 2nd steps
user_data = [i.strip() for i in raw_user_record.split(';')]

#the 3rd step
user_data[0] = f"UID-{user_data[0]}"

#the 4th step
user_data[1] = user_data[1].replace('_', ' ').title()

#the 5th step
user_data[2] = user_data[2].upper()

#the 6th step
user_data[3] = user_data[3].lower()

#the 7th step
print(' | '.join(user_data))

