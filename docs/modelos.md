# Roteamento de modelos

Quem faz o quê. Regra e porquê no [ADR-0010](adr/0010-opus-orquestra-modelos-gratuitos-executam.md); procedimento na skill `orquestrar`.

## Papéis

| Trabalho | Executor | Revisão |
|---|---|---|
| Planejar, quebrar em tarefas, escrever os briefs, escolher o executor | **Opus** | — |
| Desenho de contrato, ADR com trade-off real, mudança de arquitetura | **Opus** | — |
| Código com brief fechado (arquivos, padrão a seguir, critério de pronto) | **Gratuito** → Haiku → Sonnet | Opus: gate + `revisor` |
| Teste para comportamento já definido | **Gratuito** → Haiku | Opus: gate + `revisor` |
| Doc em `docs/` (feature, contrato a partir do código, CHANGELOG) | **Haiku** ou gratuito | Opus: lê o diff |
| Escrever tarefa no Linear a partir do plano | **Haiku** (agente `linear-haiku`) ou gratuito | Opus confere o plano antes |
| Controle de tarefas no Linear (status, PR, WIP) | **Haiku** (agente `linear-haiku`) | — |
| Revisão de diff | **Opus** (agente `revisor`) | — |

Escala: duas tentativas que não passam no gate ou na revisão sobem um degrau. Nunca suba direto para o Opus sem tentar o degrau abaixo, a não ser que a tarefa seja de desenho.

## Modelos gratuitos (OpenRouter, via OpenCode)

Lista de 15/10/2026 (`GET /api/v1/models`, filtro `:free`, todos com ferramentas).

| Modelo | Contexto | Uso | Testado |
|---|---|---|---|
| `poolside/laguna-s-2.1:free` | 262k | Código: primeira escolha | ✓ corrigiu bug de uma linha, 6 requisições, 56 s |
| `cohere/north-mini-code:free` | 256k | Código: alternativa | — |
| `nvidia/nemotron-3-super-120b-a12b:free` | 262k | Código e doc mais longos | — |
| `thinkingmachines/inkling:free` | 1M | Leitura de muito contexto | — |
| `google/gemma-4-31b-it:free` | 262k | Doc e texto do Linear | — |

A lista muda. Antes de fixar um modelo novo, rode o teste de fumaça da skill `orquestrar` e registre aqui.

## Limites

| | Sem créditos (hoje) | Com US$ 10 em créditos |
|---|---|---|
| Requisições `:free` por dia | **50** | 1.000 |
| Requisições por minuto | 20 | 20 |

- Cada passo do agente é uma requisição: uma edição trivial gastou 6. Requisição que falha também conta.
- Com 50/dia cabem poucas tarefas pequenas. Se o gratuito virar o executor principal, os US$ 10 se pagam.
- Acabou o limite do dia: o próximo degrau é o Haiku, não o Opus.

## Privacidade

Provedor gratuito pode registrar prompts. Não mande para modelo gratuito: segredo, `.env`, dado de usuário, chave. Confira a política em openrouter.ai → Settings → Privacy.
