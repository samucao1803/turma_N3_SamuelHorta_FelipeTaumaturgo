# Etapa 3: Implementação dos Componentes

Esta etapa contém os **10 componentes individuais** do sistema Smart Parking Management System, seus **testbenches** e o **relatório de simulações**.

## Estrutura

```text
Etapa 3/
├── src/
│   ├── reg_veiculos.vhd (feito/revisar entradas e saidas )
│   ├── reg_capacidade.vhd (feito/revisar entradas e saidas)
│   ├── reg_vagas_livres.vhd (feito/revisar entradas e saidas)
│   ├── reg_historico.vhd (feito/revisar entradas e saidas)
│   ├── somador.vhd (feito/revisar entradas e saidas)
│   ├── subtrator.vhd (feito/revisar entradas e saidas)
│   ├── comparador.vhd (feito/revisar entradas e saidas)
│   ├── calculador_vagas.vhd (feito/revisar entradas e saidas)
│   ├── decodificador_hex.vhd (feito/revisar entradas e saidas)
│   ├── mux.vhd (feito/revisar entradas e saidas)
│   └── fsm_estacionamento.vhd (feito/revisar entradas e saidas)
    - interface de saida / se precisar (falta)
    - MUX 2x1 (falta)

├── tb/
│   ├── tb_reg_veiculos.vhd
│   ├── tb_reg_capacidade.vhd
│   ├── tb_reg_vagas_livres.vhd
│   ├── tb_reg_historico.vhd
│   ├── tb_somador.vhd
│   ├── tb_subtrator.vhd
│   ├── tb_comparador.vhd
│   ├── tb_calculador_vagas.vhd
│   ├── tb_decodificador_hex.vhd
│   └── tb_mux.vhd
│   └── tb_fsm_estacionamento.vhd
        - interface de saida / se precisae (falta)
        - MUX 2x1 (falta)
└── sim/
    └── relatorio_simulacoes.md
```

## Simulação com GHDL

Exemplo de execução:

```bash
# Dentro de "Etapa 3"
ghdl -a --std=08 src/*.vhd tb/*.vhd
ghdl -e --std=08 tb_reg_veiculos
ghdl -r --std=08 tb_reg_veiculos --wave=sim/tb_reg_veiculos.ghw
```

Repita os comandos `-e` e `-r` para os demais testbenches.

## Arquitetura atualizada

-- sinais de controle 

inc_veiculos -> Incrementa o contador de veículos. 

dec_veiculos -> Decrementa o contador de veículos. 

load_historico -> Atualiza o registrador de histórico. 

atualiza_saidas_hex -> Atualiza os displays. 

reset_regs -> Reinicializa os registradores do sistema. 

-- sinais de status

vaga_disponivel -> Indica a existência de vagas livres no estacionamento. 

estacionamento_lotado -> Indica que a capacidade máxima foi atingida. 

estacionamento_vazio -> Indica ausência de veículos no estacionamento. 

-- componentes

FSM  
Controlar a sequência de execução do sistema e gerar sinais de controle. 
Entradas: CLOCK_50, KEY0, KEY1, SW9(reset) 
Saidas: inc_veiculos, dec_veiculos, load_historico, reset_regs 


Registrador de Veículos &
Armazenar a quantidade atual de veículos(Começar com 0, se receber um sinal de ). &
Entradas:clk, reset, inc_veiculos, dec_veiculos, atualiza_veiculos[3:0]  &
Saidas: veiculos_atual[3:0], veiculos[3:0] 


Registrador de Capacidade &
Calcula e armazena a capacidade máxima configurada (MAX 9 VAGAS). &
Entradas:SW0, SW1, SW2, SW3, clk, reset &
Saidas: capacidade_atual[3:0] 


Registrador de Vagas Livres &
Armazenar a quantidade de vagas disponíveis. &
Entradas:vagas_livres_entrada[3:0], clk, reset &
Saidas: vagas_livres[3:0] 


Registrador de Histórico &
Registrar as últimas movimentações realizadas. &
Entradas: load_historico[7:0], clk, reset &
- 


Somador &
Realizar a operação Veiculos + 1. &
Entradas: veiculos[3:0] &
Saidas: veiculos+1 - [3:0] 


Subtrator &
Realizar a operação Veiculos - 1. &
Entradas: veiculos[3:0] &
Saidas: veiculos-1 -[3:0] 


MUX &
Escolher entre a operação de soma e subtração . &
Entradas: veiculos_subt [3:0], veiculos_adc [3:0], inc_veiculos, dec_veiculos,  &
Saidas: atualiza_veiculos[3:0] 


Comparador &
Comparar a quantidade de veículos com a capacidade máxima. &
Entradas: veiculos_atual[3:0], capacidade_atual[3:0] &
Saidas: vaga_disponivel, estacionamento_lotado, estacionamento_vazio, saida_led0, saida_led1, saida_led2 


Calculador de Vagas Livres &
Calcular vagas livres disponíveis. &
Entradas: capacidade_atual[3:0], veiculos_atual[3:0] &
Saidas: vagas_livres_entrada[3:0] 


Decodificador HEX &
Converter valores binários para displays de sete segmentos. &
Entradas: veiculos_atual[3:0] , vagas_livres[3:0], atualiza_saida_hex  &
Saidas: segmentos_hex0 [6:0], segmentos_hex1 [6:0],








