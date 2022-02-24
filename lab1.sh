#! /bin/bash

# Выводим информацию
echo "Package info"
echo "Author: Artem"
echo "Using this program you can find info about needed package or install it"

# Создаём переменную, хранящую ответ пользователя и сразу присваиваем ответ да, чтобы зайти в цикл
user_response="y"

# Начинаем цикл, чтобы постоянно запрашивать ответ пользователя, цикл длится, пока пользователь отвечает да, т.е. вводит y
while [[ $user_response = "y" ]]
do
	# Просим ввести имя пакета
	echo "Type package name"
	# Читаем, что ввёл пользователь
	read packname
	# Проверяем, есть ли пакет, с помощью менеджера. 
	# Не показываем пользователю, что вывел менеджер, перенаправляя весь вывод на несуществующее устройство 
	yum info $packname 2> /dev/null 1> /dev/null
	# Проверяем код ошибки предыдущей команды. Если он не равен 0, значит пакет не установлен
	if [[ $? != 0 ]]
		then
		# Говорим, что пакет не установлен и спрашиваем, нужно ли его установить
		echo "Package is not installed!" >&2
		echo "Do you want to install it? (y/n?)"
		# Читаем ответ пользователя
		read user_response
		# Если пользователь ответил нет, т.е. ввёл n
		if [[ $user_response = "n" ]]
			then
			# Спрашиваем, хочет ли он в принципе продолжить работать с нашей программой
			echo "Do you want to continue? (y/n)"
			read user_response
			if [[ $user_response = "n" ]]
				# Если не хочет, выходим, возвращая код ошибки 0 (код 0 означает отсутствие ошибки)
				then
				exit 0
			else
				# Если пользователь всё-таки хочет продолжить работу с программой, начинаем цикл заново
				continue
			fi
		else
			# Если пользователь всё-таки хочет установить пакет, устанавливаем менеджером. Здесь уже показываем пользователю весь процесс установки.
			yum install $packname
			# Проверяем код ошибки после установки. Если код не равен 0, значит установка почему-то не удалась (скорее всего менеджер напишет, почему)
            if [[ $? != 0 ]]
            then
				# Если установка не удалась, пишем пользователю об этом и спрашиваем, хочет ли он продолжить, ответ обрабатываем так же, как и выше
                echo "Something went wrong!" >&2
                echo "Do you want to continue? (y/n)"
                read user_response
                if [[ $user_response = "n" ]]
                    then
                    exit 1
                else
                    continue
                fi
            else
				# Если же код ошибки после установки был 0, значит всё установилось, о чём и сообщаем пользователю
                echo "Packege installed!"
				# Снова спрашиваем, хочет ли продолжить и обрабатываем ответ
                echo "Do you want to continue? (y/n)"
                read user_response
                if [[ $user_response = "n" ]]
                    then
                    exit 0
                else
                    continue
                fi
            fi
		fi
	fi
    
	# Если пакет всё-таки уже установлен, выводим информацию о нём
	yum info $packname
	# Снова спрашиваем про продолжение и обрабатываем
    echo "Do you want to continue? (y/n)"
    read user_response
    if [[ $user_response = "n" ]]
        then
        exit 0
    else
        continue
    fi

done