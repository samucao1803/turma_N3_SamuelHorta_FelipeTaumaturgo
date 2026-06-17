# Relatório de Simulações - Etapa 3

## Ambiente
- Simulador: GHDL (VHDL-2008)
- Componentes simulados individualmente
- Testes executados por testbench dedicado

## Cenários testados

### Registradores
- **reg_veiculos**: incremento/decremento, saturação em 15 e proteção contra underflow.
- **reg_capacidade**: carga síncrona e reset.
- **reg_vagas_livres**: carga síncrona e reset.
- **reg_historico**: carga condicionada por `load_historico` e reset.

### Blocos combinacionais
- **somador**: casos normais e overflow modular (4 bits).
- **subtrator**: casos normais e underflow modular (4 bits).
- **comparador**: estados vazio, intermediário, lotado e coerência com sinais de LED.
- **calculador_vagas**: subtração normal e saturação em zero.
- **decodificador_hex**: validação de padrões para 0, 9 e F.

### FSM
- Fluxo de entrada com vaga disponível.
- Fluxo de entrada com estacionamento lotado.
- Fluxo de saída com estacionamento não vazio.
- Condição excepcional de saída com estacionamento vazio.
- Retorno ao estado de espera via `atualiza_saidas_hex`.

## Formas de onda
As simulações podem gerar formas de onda utilizando:

```bash
ghdl -r --std=08 tb_nome --wave=sim/tb_nome.ghw
```

Os sinais monitorados em cada testbench cobrem entradas, saídas e transições relevantes para validação funcional de cada componente.

## Análise dos resultados
- Todos os componentes foram implementados como módulos independentes e sintetizáveis.
- Os testbenches validam casos normais, transições e condições excepcionais de acordo com o enunciado da Etapa 3.
- A FSM produz os sinais de controle (`inc_veiculos`, `dec_veiculos`, `load_historico`, `atualiza_saidas`, `reset_regs`) conforme o estado atual.
- Os sinais de status do caminho de dados são consumidos pela FSM para decidir os fluxos de entrada, saída e lotação.
