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
│   └── fsm_estacionamento.vhd (feito/revisar entradas e saidas)
    - interface de saida (falta)
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
│   └── tb_fsm_estacionamento.vhd
        - interface de saida (falta)
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
