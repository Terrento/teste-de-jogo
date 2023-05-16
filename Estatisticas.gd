extends Node
#Call down, signal up. Estatísticas 'fala' pra Morcego fazer algo 'pra cima'
#Nó pai chama filhos com um metodo; filhos chamam pai com sinais
export var vida_maxima = 1
onready var vida = vida_maxima setget set_vida #É o que funciona pra setar vida em outros personagens

signal vida_zero #Criando um sinal pra ser conectado no node

func set_vida(valor): #A funcao so roda quando o valor é setado. Bom pra otimizacao se nao e checado todo frame
	vida = valor
	if vida <=0:
		emit_signal("vida_zero")
