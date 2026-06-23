# Etapa 4 — Integração e Verificação

## Objetivo desta etapa
Nesta etapa, o foco é integrar todos os módulos RTL desenvolvidos anteriormente em um único sistema funcional, validando o comportamento global por simulação e preparando a implementação na FPGA DE10-Lite.

De acordo com o enunciado, esta etapa exige:

1. **Projeto RTL completo** com todos os módulos integrados;
2. **Testbench do sistema completo**;
3. **Evidências de simulação**, incluindo:
   - casos normais,
   - casos extremos,
   - condições excepcionais,
   - análise dos resultados.

---

## O que já existe no projeto
Os módulos identificados no repositório e que devem compor a integração são:

- `fsm_estacionamento.vhd`
- `reg_veiculos.vhd`
- `reg_capacidade.vhd`
- `reg_vagas_livres.vhd`
- `reg_historico.vhd`
- `somador.vhd`
- `subtrator.vhd`
- `mux.vhd`
- `comparador.vhd`
- `calculador_vagas.vhd`
- `decodificador_hex.vhd`

Esses módulos já cobrem a maior parte da arquitetura necessária para a Etapa 4. O principal trabalho agora é conectá-los corretamente em um módulo de topo (*top-level*), validar o fluxo completo e preparar os testes do sistema integrado.

---

## Arquitetura de integração recomendada

### Entradas da placa
- `CLOCK_50` → clock principal do sistema
- `SW(9)` → reset
- `KEY(0)` → requisição de entrada
- `KEY(1)` → requisição de saída
- `SW(3 downto 0)` → configuração da capacidade máxima

### Unidade de Controle
A unidade de controle é a FSM (`fsm_estacionamento`), responsável por:
- receber sinais de requisição e status;
- gerar sinais de controle para o caminho de dados.

#### Entradas da FSM
- `clk`
- `reset`
- `req_entrada`
- `req_saida`
- `vaga_disponivel`
- `estacionamento_lotado`
- `estacionamento_vazio`

#### Saídas da FSM
- `inc_veiculos`
- `dec_veiculos`
- `load_historico`
- `atualiza_saidas_hex`
- `reset_regs`
- `LEDR8`
- `LEDR9`

### Caminho de Dados
Os módulos do datapath devem ser conectados assim:

- `reg_capacidade` → armazena a capacidade configurada pelos switches;
- `reg_veiculos` → armazena o número atual de veículos;
- `somador` → calcula `veiculos + 1`;
- `subtrator` → calcula `veiculos - 1`;
- `mux` → escolhe entre soma e subtração;
- `comparador` → gera os sinais de status do estacionamento;
- `calculador_vagas` → calcula `capacidade - veiculos`;
- `reg_vagas_livres` → armazena o valor de vagas livres;
- `reg_historico` → armazena informações históricas do sistema;
- `decodificador_hex` → converte os valores binários para os displays.

---

## Ordem recomendada de integração
Para evitar erros e facilitar a depuração, a integração deve ser feita em etapas.

### Etapa A — integrar o datapath básico
1. `reg_capacidade`
2. `reg_veiculos`
3. `somador`
4. `subtrator`
5. `mux`

Objetivo: validar o caminho de atualização do contador de veículos.

### Etapa B — integrar os sinais de status
6. `comparador`
7. `calculador_vagas`
8. `reg_vagas_livres`

Objetivo: validar ocupação, vagas livres, lotação e condição de vazio.

### Etapa C — integrar a unidade de controle
9. `fsm_estacionamento`

Objetivo: validar se a FSM gera corretamente os sinais `inc_veiculos`, `dec_veiculos`, `load_historico`, `reset_regs` e `atualiza_saidas_hex`.

### Etapa D — integrar interface e apresentação
10. `decodificador_hex`
11. LEDs de status
12. `reg_historico`

Objetivo: mostrar o funcionamento do sistema completo na FPGA e na simulação.

---

## Ajustes importantes observados antes da integração

### 1. `decodificador_hex.vhd`
No estado atual, o módulo usa `atualiza_saida_hex` como se fosse um clock:

```vhdl
process (atualiza_saida_hex)
begin
    if rising_edge(atualiza_saida_hex) then
        segmentos_hex0 <= decodifica(veiculos_atual);
        segmentos_hex1 <= decodifica(vagas_livres);
    end if;
end process;
```

#### Observação
Para integração em FPGA, essa abordagem não é a mais adequada, pois `atualiza_saida_hex` é um sinal de controle vindo da FSM e não um clock real.

#### Recomendação
Simplificar o módulo para funcionamento combinacional, por exemplo:

```vhdl
segmentos_hex0 <= decodifica(veiculos_atual);
segmentos_hex1 <= decodifica(vagas_livres);
```

Isso facilita a síntese e a integração.

### 2. `reg_capacidade.vhd`
A saída do módulo está nomeada como `vagas_livres_entrada`, mas funcionalmente representa a **capacidade atual**.

#### Recomendação
Durante a integração, conectar essa saída a um sinal interno chamado `capacidade_atual`, mesmo que a porta mantenha o nome atual.

### 3. `reg_vagas_livres.vhd`
O módulo atual atualiza o registrador de vagas livres a cada borda de clock. Isso é aceitável para a Etapa 4, desde que o valor calculado esteja correto.

### 4. `reg_historico.vhd`
O registrador de histórico existe, mas é necessário definir o que será armazenado.

#### Sugestão simples
Usar os 8 bits da seguinte forma:
- `historico_entrada(7 downto 4)` = `veiculos_atual`
- `historico_entrada(3 downto 0)` = `vagas_livres`

Ou, alternativamente, registrar o último evento realizado.

---

## Estrutura sugerida para a Etapa 4

```text
Etapa 4/
├── Componentes/
├── Testbenches/
├── top_estacionamento.vhd
├── tb_sistema_completo.vhd
└── README.md
```

Sugere-se copiar os módulos da Etapa 3 para a pasta da Etapa 4 e desenvolver nesta nova organização.

---

## Passo a passo no Quartus Prime Lite

### 1. Criar o projeto
No Quartus Prime Lite:
- `File > New Project Wizard`
- selecionar a pasta da Etapa 4;
- nomear o projeto como `etapa4_estacionamento`;
- definir futuramente `top_estacionamento` como *top-level entity*;
- adicionar os arquivos `.vhd`;
- selecionar o dispositivo da placa DE10-Lite (família MAX 10).

### 2. Adicionar os arquivos do projeto
Adicionar ao projeto:
- `fsm_estacionamento.vhd`
- `reg_veiculos.vhd`
- `reg_capacidade.vhd`
- `reg_vagas_livres.vhd`
- `reg_historico.vhd`
- `somador.vhd`
- `subtrator.vhd`
- `mux.vhd`
- `comparador.vhd`
- `calculador_vagas.vhd`
- `decodificador_hex.vhd`
- `top_estacionamento.vhd`

Menu:
- `Project > Add/Remove Files in Project`

### 3. Criar o módulo top-level
Criar o arquivo `top_estacionamento.vhd`, que será responsável por:
- instanciar todos os módulos;
- declarar os sinais internos;
- conectar os módulos da unidade de controle ao caminho de dados;
- mapear entradas e saídas da FPGA.

### 4. Entradas e saídas sugeridas para o top-level
#### Entradas
- `CLOCK_50 : in std_logic`
- `KEY : in std_logic_vector(1 downto 0)`
- `SW : in std_logic_vector(9 downto 0)`

#### Saídas
- `LEDR : out std_logic_vector(9 downto 0)`
- `HEX0 : out std_logic_vector(6 downto 0)`
- `HEX1 : out std_logic_vector(6 downto 0)`

### 5. Adaptação dos sinais físicos da placa
Sugestão de mapeamento:
- `reset <= SW(9)`
- `req_entrada <= not KEY(0)`
- `req_saida <= not KEY(1)`

Observação: na DE10-Lite, os botões normalmente são ativos em nível baixo.

### 6. Sinais internos a declarar
Sugestão de sinais internos do `top_estacionamento`:
- `inc_veiculos`
- `dec_veiculos`
- `load_historico`
- `atualiza_saidas_hex`
- `reset_regs`
- `vaga_disponivel`
- `estacionamento_lotado`
- `estacionamento_vazio`
- `veiculos`
- `veiculos_atual`
- `veiculos_mais_um`
- `veiculos_menos_um`
- `atualiza_veiculos`
- `capacidade_atual`
- `vagas_livres_calc`
- `vagas_livres`
- `historico_entrada`
- `historico_atual`
- `led0_status`, `led1_status`, `led2_status`

---

## Ligações recomendadas entre os módulos

### Capacidade
`reg_capacidade`
- entradas: `SW(3 downto 0)`, `clk`, `reset`
- saída: `capacidade_atual`

### Veículos
`reg_veiculos`
- entradas: `inc_veiculos`, `dec_veiculos`, `atualiza_veiculos`, `clk`, `reset`
- saídas: `veiculos`, `veiculos_atual`

### Operações aritméticas
- `somador` recebe `veiculos` e gera `veiculos_mais_um`
- `subtrator` recebe `veiculos` e gera `veiculos_menos_um`

### Seleção da operação
`mux`
- recebe `veiculos_mais_um`, `veiculos_menos_um`, `inc_veiculos`, `dec_veiculos`
- gera `atualiza_veiculos`

### Comparação de status
`comparador`
- entradas: `veiculos_atual`, `capacidade_atual`
- saídas:
  - `vaga_disponivel`
  - `estacionamento_lotado`
  - `estacionamento_vazio`
  - sinais para LEDs

### Cálculo de vagas livres
`calculador_vagas`
- entradas: `capacidade_atual`, `veiculos_atual`
- saída: `vagas_livres_calc`

### Registro de vagas livres
`reg_vagas_livres`
- entrada: `vagas_livres_calc`
- saída: `vagas_livres`

### FSM
`fsm_estacionamento`
- recebe requisições e sinais de status
- gera sinais de controle

### Histórico
Sugestão:

```vhdl
historico_entrada <= veiculos_atual & vagas_livres;
```

### Displays
`decodificador_hex`
- entrada: `veiculos_atual`, `vagas_livres`
- saída: `HEX0`, `HEX1`

---

## Sugestão de uso dos LEDs
Mapeamento sugerido:
- `LEDR(0)` = vaga disponível
- `LEDR(1)` = quase lotado
- `LEDR(2)` = lotado
- `LEDR(8)` = entrada detectada pela FSM
- `LEDR(9)` = saída detectada pela FSM

Demais LEDs:
- `LEDR(7 downto 3) <= (others => '0')`

---

## Testbench do sistema completo
Deve ser criado um novo testbench, por exemplo:
- `tb_sistema_completo.vhd`

Esse testbench deve instanciar o `top_estacionamento` e verificar o funcionamento completo do sistema integrado.

---

## Casos de teste recomendados

### Casos normais
- entrada com vagas disponíveis;
- múltiplas entradas sucessivas;
- saída com veículos presentes.

### Casos extremos
- capacidade configurada em `0`;
- capacidade configurada em `9`;
- encher o estacionamento até lotar;
- esvaziar o estacionamento até zero.

### Condições excepcionais
- solicitar entrada quando o estacionamento estiver lotado;
- solicitar saída quando o estacionamento estiver vazio;
- solicitar entrada e saída ao mesmo tempo;
- aplicar reset durante a operação.

---

## Sequência recomendada de validação

### Teste 1 — reset
Verificar se após reset:
- `veiculos = 0`
- `historico = 0`
- FSM retorna ao estado inicial

### Teste 2 — configuração da capacidade
Ajustar `SW(3 downto 0)` e verificar se a capacidade é corretamente registrada.

### Teste 3 — entrada normal
Verificar se:
- a FSM gera `inc_veiculos`;
- o número de veículos incrementa;
- as vagas livres diminuem;
- os displays são atualizados.

### Teste 4 — saída normal
Verificar se:
- a FSM gera `dec_veiculos`;
- o número de veículos decrementa;
- as vagas livres aumentam.

### Teste 5 — lotação
Verificar se:
- o sinal `estacionamento_lotado` é ativado;
- LED de lotado acende;
- nova entrada não incrementa o contador.

### Teste 6 — estacionamento vazio
Verificar se:
- `estacionamento_vazio = 1`;
- nova saída não decrementa o contador.

### Teste 7 — entrada e saída simultâneas
Verificar o comportamento definido pela FSM. Pelos testes existentes, a prioridade atual parece ser da entrada.

---

## Como registrar as evidências de simulação
Capturar formas de onda (*waveforms*) mostrando:
- entrada bem-sucedida;
- saída bem-sucedida;
- condição de lotado;
- condição de vazio;
- tentativa de entrada quando lotado;
- tentativa de saída quando vazio;
- entrada e saída simultâneas.

Para cada evidência, registrar:
- estímulo aplicado;
- comportamento esperado;
- comportamento observado;
- análise do resultado.

---

## Sugestão de organização da entrega

```text
grupo.zip
├── Projeto_RTL/
│   ├── top_estacionamento.vhd
│   ├── fsm_estacionamento.vhd
│   ├── reg_veiculos.vhd
│   ├── reg_capacidade.vhd
│   ├── reg_vagas_livres.vhd
│   ├── reg_historico.vhd
│   ├── somador.vhd
│   ├── subtrator.vhd
│   ├── mux.vhd
│   ├── comparador.vhd
│   ├── calculador_vagas.vhd
│   └── decodificador_hex.vhd
├── Testbench/
│   └── tb_sistema_completo.vhd
├── Simulacoes/
│   ├── caso_normal_entrada.png
│   ├── caso_normal_saida.png
│   ├── caso_extremo_lotado.png
│   ├── caso_extremo_vazio.png
│   ├── caso_excepcional_simultaneo.png
│   └── analise_resultados.pdf
└── README.txt
```

---

## Próximos passos recomendados
1. Criar o arquivo `top_estacionamento.vhd`;
2. integrar primeiro o datapath básico;
3. compilar;
4. integrar os módulos de status;
5. compilar novamente;
6. ajustar o `decodificador_hex`, se necessário;
7. integrar displays e LEDs;
8. criar o `tb_sistema_completo.vhd`;
9. rodar as simulações;
10. organizar as evidências para entrega.

---

## Observação final
A Etapa 4 não consiste apenas em juntar arquivos, mas em demonstrar que o sistema completo funciona de maneira coerente e verificável. Por isso, a integração deve ser feita com atenção aos sinais de controle, sinais de status, atualização dos registradores e consistência dos testes.
