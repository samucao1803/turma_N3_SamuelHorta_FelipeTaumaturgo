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

## Resultado da simulação
------------------ calculador de vagas---------------
📌 Descrição dos casos de teste
Foram definidos três cenários de teste para o calculador_vagas. No primeiro cenário, foi testada uma situação normal, com 3 veículos e expectativa de 6 vagas livres. No segundo cenário, foi testado o limite do sistema com 9 veículos, onde se espera que não haja vagas disponíveis. No terceiro cenário, foi testada uma condição de erro acima da capacidade, para ver se o sistema realiza a saturação e retorna 0 vagas livres.

📊 Análise dos resultados
A partir da simulação o módulo apresentou comportamento correto em todos os cenários testados. Para a entrada de 3 veículos, a saída foi 6 vagas livres; para 9 veículos, a saída foi 0; e para 10 veículos, o sistema também retornou 0, confirmando o funcionamento da saturação.

---------------comparador-------------------------
📌 Descrição dos casos de teste
Foram definidos quatro cenários de teste para o comparador. No primeiro cenário, foi testada a condição de estacionamento vazio e verificando os sinais de disponibilidade e LEDs. No segundo cenário, foi avaliada uma condição intermediária onde ainda há vagas disponíveis. No terceiro foi analisado um estado próximo da capacidade máxima observando a mudança no comportamento dos LEDs. Por fim, no quarto cenário, foi testada a condição limite abaixo da lotação verificando se o sistema mantém coerência nos sinais de saída.

📊 Análise dos resultados
A partir da simulação o módulo apresentou comportamento correto em todos os cenários testados. Para 0 veículos, os sinais indicam corretamente estacionamento vazio e vagas disponíveis. Para 5 veículos, o sistema mantém a indicação de vagas disponíveis. Nos cenários de 8 e 9 veículos, a saída continua indicando disponibilidade de vagas, com alteração no comportamento dos LEDs mostrando o aumento da ocupação. Não foram observadas inconsistências ou falhas nos sinais.

-----------decodificador hex -------------------------
📌 Descrição dos casos de teste
Foram definidos diferentes cenários de teste para o módulo decodificador_hex. Inicialmente, foi testada a exibição dos valores 0 (veículos) e 9 (vagas). Em seguida, foi verificado se as saídas permanecem estáveis quando as entradas mudam sem nova atualização. Por fim, foi realizado um teste completo iterando todos os valores de 0 a 9 para veículos e valores complementares para vagas livres, garantindo a cobertura total dos possíveis estados de entrada.

📊 Análise dos resultados
Observa-se que o módulo apresentou comportamento correto em todos os cenários testados. Inicialmente, os displays exibem corretamente os valores 0 e 9 após o sinal de atualização. Quando as entradas são alteradas sem ativação do sinal atualiza_saida_hex, as saídas permanecem inalteradas, confirmando o funcionamento do mecanismo de controle. As transições ocorreram de forma estável, validando o funcionamento adequado do decodificador.

------------------fsm_estacionamento------------
📌 Descrição dos casos de teste
Foram definidos varios cenários de teste para o funcionamento da FSM do estacionamento. Inicialmente, foi testado o comportamento durante o reset, se os registradores são corretamente inicializados. Em seguida, foi avaliado o fluxo de entrada de veículos em condição normal. Também foi testado o comportamento em condição de estacionamento lotado. Depois, foram realizados testes de saída de veículos em condição normal e em condição de estacionamento vazio, para ver se o sistema evita decrementos inválidos. Por fim, foi testado o caso de requisições simultâneas de entrada e saída.

📊 Análise dos resultados
Observa-se que o módulo apresentou comportamento correto em todos os cenários testados. Durante o reset, o sinal reset_regs foi ativado corretamente. No fluxo de entrada, os sinais inc_veiculos e load_historico foram acionados conforme esperado. Na condição de estacionamento lotado, nenhuma entrada foi registrada. No fluxo de saída válida, o sinal dec_veiculos foi corretamente ativado. No cenário de requisições simultâneas, foi observada a prioridade da entrada sobre a saída, conforme definido no projeto.

----------------mux--------------------------------
📌 Descrição dos casos de teste
Foram definidos quatro cenários de teste para o módulo mux. Inicialmente, foi testada a condição sem operação, com ambos os sinais de controle desativados. Em seguida, foi testada a ativação do incremento de veículos. Posteriormente, foi avaliada a ativação do decremento de veículos, selecionando a saída do subtrator. Por fim, foi testado o caso de sinais de controle simultâneos, verificando o comportamento do sistema diante de uma condição inválida.

📊 Análise dos resultados
A partir da simulação observa-se que o módulo apresentou comportamento correto em todos os cenários testados. Na ausência de operação, a saída permaneceu em zero, conforme esperado. Quando o sinal de incremento foi ativado, o mux selecionou corretamente o valor do somador. Ao ativar o sinal de decremento, a saída passou a refletir o valor do subtrator. No caso de ativação simultânea dos sinais de controle, o sistema retornou zero.

--------------reg_capacidade---------------
📌 Descrição dos casos de teste
Foram definidos vários cenários de teste para o módulo reg_capacidade. Inicialmente, foi testado o comportamento do sistema após o reset, verificando a inicialização em zero. Em seguida, foram aplicadas diferentes combinações de chaves para representar valores válidos, como 3, 8 e 9 vagas. Posteriormente, foram testadas entradas acima do limite permitido (como 10 e 15). Por fim, foi avaliado o reset assíncrono, garantindo que a saída retorne imediatamente a zero independentemente do clock.

📊 Análise dos resultados
A partir da simulação observa-se que o módulo apresentou comportamento correto em todos os cenários testados. Após o reset, a saída foi corretamente inicializada em zero. Para entradas válidas, como 3, 8 e 9, o registrador armazenou corretamente os valores configurados pelas chaves. Nos casos em que os valores de entrada excederam o limite como 10 e 15, o sistema aplicou corretamente a saturação em 9 evitando valores inválidos. O reset assíncrono demonstrou funcionamento adequado, zerando imediatamente a saída independentemente do ciclo de clock.

------------reg_historico--------------
📌 Descrição dos casos de teste
Foram definidos varios cenários de teste para o módulo reg_historico. Inicialmente, foi testado o carregamento de um valor com o sinal load_historico ativo. Em seguida, foi avaliada a estabilidade do registrador quando a entrada é alterada sem ativação do sinal de carga. Depois, foi testado um novo carregamento com outro valor, para validar a atualização correta do conteúdo. Por fim, foi verificado o comportamento do reset.

📊 Análise dos resultados
A simulação demonstrou que o módulo apresentou comportamento correto em todos os cenários. O valor A5 foi corretamente armazenado após a ativação do sinal de carga e permaneceu estável mesmo com alterações. Após a reativação do sinal, o novo valor foi corretamente carregado. Por fim, ao acionar o reset, o registrador foi imediatamente zerado. As transições ocorreram de forma estável e sincronizada com o clock, sem inconsistências.

----------reg_vagas_livres------------
📌 Descrição dos casos de teste
Foram definidos três cenários de teste para o módulo reg_vagas_livres. Inicialmente, foi testado o comportamento após o reset. Em seguida, foi avaliada a carga de um valor inicial de vagas, verificando o armazenamento correto. Posteriormente, foi testada a atualização do valor de entrada para 2 vagas. Por fim, foi testado novamente o reset.

📊 Análise dos resultados
A simulação demonstrou que o módulo apresentou comportamento correto em todos os cenários testados. Após o reset, a saída foi corretamente inicializada em zero. Quando o valor de entrada foi alterado para 9, o registrador armazenou corretamente o valor, e posteriormente atualizou para 2 conforme a nova entrada. Por fim, ao acionar o reset, a saída foi imediatamente zerada, confirmando o funcionamento adequado do mecanismo de reinicialização.

---------reg_veiculos----------------
📌 Descrição dos casos de teste
Foram definidos diversos cenários de teste para o módulo reg_veiculos. Inicialmente, foi testado o comportamento após o reset. Em seguida, foi avaliado o incremento básico. Posteriormente, foi testado o decremento básico. Também foi verificado se o registrador permanece inalterado quando não há sinais de controle ativos. Em sequência, foram testados casos de valores limite, carregamento até o máximo permitido (9) e situações de saturação tanto no incremento quanto no decremento. Por fim, foi avaliado o comportamento diante de comandos simultâneos de incremento e decremento.

📊 Análise dos resultados
A simulação demonstrou que o módulo apresentou comportamento correto em todos os cenários testados. Após o reset, o valor foi corretamente inicializado em zero. O incremento e o decremento funcionaram conforme esperado. Na ausência de sinais de controle , o valor permaneceu estável. Nos testes de limite, manteu o valor máximo em 9 no incremento e evitando valores negativos. No caso de comandos simultâneos, nenhuma alteração indevida foi realizada.

-------------somador----------
📌 Descrição dos casos de teste
Foram definidos três cenários de teste o módulo somador. Inicialmente, foi testado o incremento a partir de zero, verificando a transição para 1. Em seguida, incrementando o valor 7 para 8. Por fim, foi testado o comportamento em condição de overflow, ao incrementar o valor máximo representável, verificando o retorno ao valor zero.

📊 Análise dos resultados
A simulação demonstrou que o módulo apresentou comportamento correto em todos os cenários testados. Para a entrada 0, a saída foi 1. Para o valor 7, o resultado observado foi 8, confirmando o funcionamento adequado em casos intermediários. No caso de entrada 9, a saída retornou para 0, mostrando o comportamento de overflow.

----------subtrador------------
📌 Descrição dos casos de teste
Foram definidos três cenários de teste para o módulo subtrator. Inicialmente, foi testado o decremento de 5 para 4. Em seguida, foi avaliado o comportamento no limite inferior. Por fim, foi testado o comportamento em condição de underflow, ao subtrair 1 do valor mínimo 0.

📊 Análise dos resultados
A simulação demonstrou que o módulo apresentou comportamento correto em todos os cenários testados. Para a entrada 5, a saída foi 4, confirmando o funcionamento do decremento. Para o valor 1, o resultado foi 0. No caso de entrada 0 a saída permaneceu 0.


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








