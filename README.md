# Projeto Final, Laboratório de Sistemas Digitais

<p align="center">
Projeto desenvolvido para a disciplina de Laboratório de Sistemas Digitais da UFMG, contemplando todas as etapas do fluxo de desenvolvimento de um sistema digital em RTL utilizando VHDL e implementação em FPGA DE10-Lite.
</p>

## Sumário

| Etapa                  | Objetivo                                                                   | Entrega                                                                      | Data de Entrega |
| ---------------------- | -------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | ---------- |
| [Etapa 1](./Etapa%201/README.md) | Especificar completamente o sistema, seus requisitos e interfaces.         | Documento de Especificação Funcional e Documento de Interface do Sistema.    | 07/06/2026 |
| [Etapa 2](./Etapa%202/README.md) | Definir a arquitetura RTL e a organização interna do sistema.              | FSM de controle, arquitetura RTL e lista de componentes.                     | 11/06/2026 |
| [Etapa 3](./Etapa%203/README.md) | Implementar e validar individualmente cada componente do projeto.          | Código VHDL, testbenches e evidências de simulação.                          | 18/06/2026 |
| [Etapa 4](./Etapa%204/README.md) | Integrar todos os módulos e verificar o funcionamento completo do sistema. | Projeto integrado, testbench do sistema e relatório de integração.           | 25/06/2026 |
| [Etapa 5](./Etapa%205/README.md) | Implementar o projeto na FPGA e realizar a validação final em hardware.    | Projeto completo, arquivos Quartus, relatório final e vídeo de demonstração. | 01/07/2026 |

---

## Entregas

### Etapa 1: Especificação do Sistema

Nesta etapa é realizada a definição completa do sistema proposto, incluindo seu objetivo, funcionamento, requisitos funcionais, casos de uso, diagramas e interfaces de entrada e saída. O resultado desta fase serve como base para todas as decisões de projeto das etapas seguintes.

### Etapa 2: Arquitetura RTL

Nesta etapa é definida a arquitetura do sistema em nível RTL, contemplando a Máquina de Estados Finita (FSM), a separação entre Unidade de Controle e Caminho de Dados, os sinais de controle e status, além da especificação dos componentes internos.

### Etapa 3: Implementação dos Componentes

Nesta etapa são implementados os módulos VHDL sintetizáveis do sistema, juntamente com seus respectivos testbenches e evidências de simulação, garantindo a validação funcional individual de cada componente.

### Etapa 4: Integração e Verificação

Nesta etapa todos os módulos desenvolvidos devem ser integrados em um único sistema. Devem ser executados testes funcionais completos, incluindo cenários normais, extremos e excepcionais, além da documentação dos problemas encontrados e respectivas soluções.

### Etapa 5: Implementação em FPGA

Nesta etapa é realizada a síntese do projeto para a FPGA DE10-Lite, incluindo a configuração dos pinos, validação em hardware real, documentação dos resultados obtidos e gravação do vídeo final de demonstração.

---

## Estrutura do Repositório

```text
/
├── README.md
│
├── Etapa 1/
│   ├── Especificacao_Funcional.pdf
│   ├── Interface_do_Sistema.pdf
│   └── turma_N3_SamuelHorta_FelipeTaumaturgo.zip
│
│
├── Etapa 2/
│   ├── FSM_Controle.pdf
│   ├── Arquitetura_RTL.pdf
│   ├── Lista_Componentes.pdf
│   └── turma_N3_SamuelHorta_FelipeTaumaturgo.zip
│
├── Etapa 3/
│   ├── src/
│   ├── testbench/
│   ├── simulacoes/
│   └── turma_N3_SamuelHorta_FelipeTaumaturgo.zip
│
├── Etapa 4/
│   ├── sistema_integrado/
│   ├── testbench_sistema/
│   ├── simulacoes/
│   ├── relatorio_integracao.pdf
│   └── turma_N3_SamuelHorta_FelipeTaumaturgo.zip
│
└── Etapa 5/
    ├── quartus/
    ├── src/
    ├── testbench/
    ├── relatorio_final.pdf
    ├── video_demonstracao.mp4
    └── turma_N3_SamuelHorta_FelipeTaumaturgo.zip
```

---

## Informações do Projeto

**Disciplina:** Laboratório de Sistemas Digitais
**Universidade:** Universidade Federal de Minas Gerais (UFMG)
**Professor:** Tiago Coelho Magalhães
**Semestre:** 2026/1

### Integrantes

* Nome do Aluno 1
* Nome do Aluno 2

### Tema do Projeto

Sistema de Estacionamento Inteligente

### Recursos Utilizados

* FPGA DE10-Lite
* VHDL
* Quartus Prime
* ModelSim