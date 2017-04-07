#!/usr/bin/expect
sleep 2
spawn telnet localhost 4199
expect "WRU"
exp_send "OP"
sleep 2
exp_send "\r"
sleep 2
exp_send "\r"
expect "!!!"
exp_send "040489D\r"
expect "04/04/89"
exp_send "T\r"
expect "00"
sleep 2
exp_send "REF\r"
sleep 2
exp_send "  "
expect "РАSS:"
exp_send  "MJPOP\r"
expect "БУФЕР:"
exp_send "7/M\r"
sleep 2
exp_send "ЛИС 105\r"
expect "*END FILE"
sleep 2
exp_send "СЛА 105,17\r"
expect "СЧЕТ"
sleep 2
exp_send "KAK\r"
expect "\n"
sleep 5
exp_send "KAK\r"
expect "НЕТ ЗАДАЧ"
sleep 2
exp_send "СЛУ 100\r"
expect "\n"
expect "БУФЕР:"
exp_send "7/M\r"
expect "\n"
sleep 2
exp_send "ЛИС 100\r"
expect "*END FILE"
sleep 2
exp_send "СЛА 100,17\r"
expect "СЧЕТ"
sleep 2
exp_send "KAK\r"
expect "\n"
sleep 5
exp_send "KAK\r"
expect "\n"
sleep 5
exp_send "KAK\r"
expect "НЕТ ЗАДАЧ"
sleep 2
exp_send "ТЕЛЕГРАММА: NEW SYSTEM IS READY! Boot it from DRUM 25\r"
sleep 2
exp_send "K O H"
exit
