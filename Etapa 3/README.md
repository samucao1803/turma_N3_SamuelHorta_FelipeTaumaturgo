# Etapa 3: Implementação dos Componentes

Esta etapa contém os **10 componentes individuais** do sistema Smart Parking Management System, seus **testbenches** e o **relatório de simulações**.

## Estrutura

```text
Etapa 3/
├── src/
│   ├── reg_veiculos.vhd
│   ├── reg_capacidade.vhd
│   ├── reg_vagas_livres.vhd
│   ├── reg_historico.vhd
│   ├── somador.vhd
│   ├── subtrator.vhd
│   ├── comparador.vhd
│   ├── calculador_vagas.vhd
│   ├── decodificador_hex.vhd
│   └── fsm_estacionamento.vhd
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
