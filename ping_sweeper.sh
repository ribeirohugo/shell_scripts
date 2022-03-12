#!/bin/bash

#Variables
input=NULL
count=0
i=1
total=0
countIna=0
countInv=0
countAt=0

lista_ativos=""
lista_inativos=""
lista_invalidos=""

#Funções
logo()
{
	clear
	echo "$quantos endereços recebidos"
	echo "Aguarde um momento..."
	echo "$total de $quantos endereços analisados..."
}

#Script

#a
if [ $# -ne 1 ] || [ ! -f $1 ]
then
	echo "Erro: nenhum ficheiro inserido. Tem mais duas tentativas."
else
	input=$1
fi

#b,c
while [ ! -f "$input" ]
do
	if [ $count -lt 2 ]
	then
		read -p "Insira o nome do ficheiro: " input
		count=$((count+1))
    else
		echo "Erro: nenhum ficheiro inserido."
        exit
	fi
done

#d,e
for linha in $(cat $input)
do
	total=$((total+1))
	count=0
	for octal in 1 2 3 4
	do
		octais=`echo $linha | cut -d"." -f$octal`
		tirarLetras=$(echo $octais | grep -iE "a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|r|s|t|u|v|y|w|x|z")
		if [ -z "$tirarLetras" ]
		then
		if [ $octais -le 255 ] && [ $octais -ge 0 ]
		then
		count=$((count+1))
		fi
		fi
	done
	verifica=`echo $linha | cut -d"." -f5`
	if [ $count -eq 4 ] && [ -z $verifica ]
	then
		testar=`ping -c 1 -w 1 $linha | grep "100% packet loss"`
		if [ ! -z "$testar" ]
		then
			countIna=$((countIna+1))
			lista_inativos+="${linha}\n"
		else
			lista_ativos+="${linha}\n"
		fi
	else
		countInv=$((countInv+1))
		lista_invalidos+="${linha}\n"
	fi
	quantos=`cat $1 | wc -l`
	logo
done

countAt=$((total-countInv-countIna))
printf "Endereços ativos = $countAt\n$lista_ativos" > reachability_test.txt
printf "\nEndereços inativos = $countIna\n$lista_inativos" >> reachability_test.txt
printf "\nEndereços inválidos = $countInv\n$lista_invalidos" >> reachability_test.txt

echo "Endereços ativos= $countAt	Endereços inativos= $countIna	Endereços inválidos= $countInv"
echo "Mais informações no ficheiro reachability_test.txt"
