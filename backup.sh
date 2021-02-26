# d) Написать скрипт резервного копирования по расписанию следующим образом:
# В первый день месяца помещать копию в backdir/montlhy.
# Бэкап по пятницам хранить в каталоге backdir/weekley.
# В остальные дни сохранять копии в backdir/daily.
# Настроить ротацию следующим образом. Ежемесячные копии хранить 180 дней, ежедневные — неделю, еженедельные — 30 дней. Подсказка: для ротации используйте find.
# Примечание. Задание 2 дано для тех, кому упражнения 1 показалось недостаточно.

$nano ~/backup/back.sh
#!/bin/bash

[ "$1"  = "--help" ]&&{
                        echo \# Скрипт резервного копирования.
                        echo \# Первым аргументом принимает ключи:
                        echo \# -m для месячного бэкапа (хранятся 180 дней)
                        echo \# -w для недельного бэкапа (хранятся 30 дней)
                        echo \# -d для бэкапа за день (хранятся 7 дней)
                        exit
                        }

[ $# == 1 ] || echo Количество аргументов неверное, введите команду: "$0 --help"

# по ключу из первого аргумента скрипта определяем папку и срок хранения
case $1 in
        "-m")
                del=180 ; period="mothly"
                ;;
        "-w")
                del=30 ; period="weekley"
                ;;
        "-d")
                del=7 ; period="daily"
                ;;
esac

backdir="~/backup"
# заходим в папку в которой будет совершаться ротация
cd $backdir/$period
# определяем файлы которые хранились больше указанного времени
dellist=$(find -ctime +$del) 
# удаляем их
for i in $dellist
do
        rm $i
done
