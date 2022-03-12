#!/bin/bash
if [ -f scan_report.txt ]
then
rm scan_report.txt
fi
passou=1
erro=$(echo $2 | grep -i "[a-z]")
total=0
contA=0
contIna=0
contInv=0
if  [ $# -ne 4 ]
then
	echo "Nao cumpre os parametros"
	passou=0
else
	if [ "$1" = "-f" ]
	then
		if [ ! -f "$2" ]
		then
			echo "Nao cumpre os parametros"
			passou=0
		fi
	else
		if [ -n "$erro" ]
		then
			echo "Nao cumpre os parametros"
			passou=0
		else
			if [ $2 -le 0 ] || [ $2 -ge 65535 ]
			then
				echo "Nao cumpre os parametros"
				passou=0
			fi
		fi
	fi
	if [ ! -f $4 ]
	then
		echo "Nao cumpre os parametros"
		passou=0
	else
		if [ ! "$3" = "-h" ]
		then
			echo "Nao cumpre os parametros"
			passou=0
		fi
	fi
fi
if [ $passou -eq 1 ]
then
	if [ $1 = "-f" ]
	then
		for linha in $(cat $4)
		do
			touch tempAtiv
			touch tempIna
			touch tempNaoDa
			for linha1 in $(cat $2)
			do
			total=$((total+1))
			if [ $linha1 -ge 1 ] && [ $linha1 -le 65535 ]
			then
				result=$(nc -zvw1 $linha $linha1 2>&1 | grep succeeded)
				if [ -n "$result" ]
				then
					echo "$linha1">>tempAtiv
				else
					echo "$linha1">>tempIna
				fi
			else
			echo "$linha1">>tempNaoDa
			fi
			done
			echo "Para o ip $linha" >> scan_report.txt
			echo "Portas Ativas">>scan_report.txt
			cat tempAtiv >> scan_report.txt
			echo "Portas Inativas">>scan_report.txt
			cat tempIna >> scan_report.txt
			echo "Portas Inválidas">>scan_report.txt
			cat tempNaoDa >> scan_report.txt
			rm tempAtiv
			rm tempIna
			rm tempNaoDa
		done
	else
		for linha in $(cat $4)
		do
		touch tempAtiv
		touch tempIna
		touch tempNaoDa
		total=$((total+1))
		result=$(nc -zvw1 $linha $2 2>&1 | grep succeeded)
		if [ -n "$result" ]
		then
			echo "$2">>tempAtiv
		else
			echo "$2">>tempIna
		fi
			touch tempNaoDa
			echo "Para o ip $linha" >> scan_report.txt
			echo "Portas Ativas">>scan_report.txt
			cat tempAtiv >> scan_report.txt
			echo "Portas Inativas">>scan_report.txt
			cat tempIna >> scan_report.txt
			echo "Portas Inválidas">>scan_report.txt
			cat tempNaoDa >> scan_report.txt
			rm tempAtiv
			rm tempIna
			rm tempNaoDa
		done
	fi
fi
