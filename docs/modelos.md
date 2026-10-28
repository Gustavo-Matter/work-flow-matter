# Roteamento de modelos

Quem faz o quê. Regra e porquê no [ADR-0010](adr/0010-opus-orquestra-modelos-gratuitos-executam.md); procedimento na skill `orquestrar`.

## Prioridade

**O modelo gratuito é sempre a primeira escolha.** Só sobe para o Haiku (e dele para o Sonnet) por um destes motivos, **registrado na sub-issue**: duas tentativas sem passar no gate ou na revisão; limites gratuitos do dia esgotados (o da OpenRouter e o do próprio OpenCode); segredo, `.env` ou dado de usuário; ferramenta que o OpenCode não tem (Linear).

## Papéis

| Trabalho | Executor | Revisão |
|---|---|---|
| Planejar, quebrar em tarefas, escrever os briefs, escolher o executor | **Opus** | — |
| Desenho de contrato, ADR com trade-off real, mudança de arquitetura | **Opus** | — |
| Código com brief fechado (arquivos, padrão a seguir, critério de pronto) | **Gratuito** → Haiku → Sonnet | Opus: gate + `revisor` |
| Teste para comportamento já definido | **Gratuito** → Haiku | Opus: gate + `revisor` |
| Doc em `docs/` (feature, contrato a partir do código, CHANGELOG) | **Gratuito** → Haiku | Opus: lê o diff |
| Escrever tarefa no Linear a partir do plano | **Haiku** (agente `linear-haiku`): o OpenCode não tem o Linear | Opus confere o plano antes |
| Controle de tarefas no Linear (status, PR, WIP) | **Haiku** (agente `linear-haiku`) | — |
| Revisão de diff | **Opus** (agente `revisor`) | — |

Escala: duas tentativas que não passam no gate ou na revisão sobem um degrau. Nunca suba direto para o Opus sem tentar o degrau abaixo, a não ser que a tarefa seja de desenho.

## Modelos gratuitos (OpenRouter, via OpenCode v2)

Exige o OpenCode **v2** (`npm i -g @opencode/cli`, ou `brew install anomalyco/tap/opencode-v2`). O pacote `opencode-ai` é a 1.x, sem `--standalone`.

Lista de 15/10/2026 (`GET /api/v1/models`, filtro `:free`, todos com ferramentas).

| Modelo | Contexto | Uso | Testado |
|---|---|---|---|
| `poolside/laguna-s-2.1:free` | 262k | Código: primeira escolha | ✓ Windows: bug de uma linha, 6 requisições, 56 s · Mac (v2.0.31): idem, 34 s |
| `cohere/north-mini-code:free` | 256k | Código: alternativa | — |
| `nvidia/nemotron-3-super-120b-a12b:free` | 262k | Código e doc mais longos | — |
| `thinkingmachines/inkling:free` | 1M | Leitura de muito contexto | — |
| `google/gemma-4-31b-it:free` | 262k | Doc e texto do Linear | — |

A lista muda. Antes de fixar um modelo novo, rode o teste de fumaça da skill `orquestrar` e registre aqui.

**28/10/2026:** `laguna-s-2.1` e `nemotron-3-super-120b` responderam `Model unavailable`. Confira o que existe com `opencode models | grep ':free'` antes de disparar; em 28/10 havia `cohere/north-mini-code`, `nvidia/nemotron-3-ultra-550b-a55b`, `thinkingmachines/inkling` e `google/gemma-4-31b-it`. No Mac não há `timeout`: rode o `opencode run` em segundo plano sem ele.

## Limite gratuito do próprio OpenCode

O OpenCode instalado traz provedores próprios com modelos gratuitos, e o limite deles não é o da OpenRouter. `opencode models` lista; em 22/10/2026: `opencode/big-pickle`, `opencode/deepseek-v4.1-flash-free`, `opencode/glm-5.3-flash-free`, `opencode/mimo-v2.6-flash-free`, `opencode/minimax-m3.1-flash-free`, `opencode/nemotron-3-ultra-free`, `opencode/flint-40b-free`, `opencode/beam-free` e `opencode-go/beam-free`. Quanto cada um permite por dia, confira no painel do OpenCode.

**Ainda não validado.** Em 22/10/2026 (Mac, v2.0.31), `opencode run --standalone --auto` com `opencode/big-pickle`, `opencode/deepseek-v4.1-flash-free` e `opencode-go/beam-free`, disparado pelo shell do agente, ficou 120 s sem resposta e sem erro no log (o servidor sobe e a execução não avança). Antes de contar com eles, rode o teste de fumaça com limite de tempo e registre aqui o resultado, a contagem de requisições e se pede login interativo (`opencode auth login`):

```bash
perl -e 'alarm 120; exec @ARGV' opencode run --standalone --auto --model 'opencode/<modelo>' 'Corrija o bug de soma.py.'
```

O macOS não tem `timeout`; o `perl` faz o papel dele.

## Chave

Variável `OPENROUTER_API_KEY` do usuário (Mac: `~/.zshrc`) ou `.env` na raiz deste repo (copie o `.env.example`). A skill `orquestrar` usa a variável e, sem ela, o `.env`. O `.env` é ignorado pelo git. A chave guardada por `opencode auth login` não funcionou com `opencode run` na v2.0.31.

## Limites

| | Sem créditos (hoje) | Com US$ 10 em créditos |
|---|---|---|
| Requisições `:free` por dia | **50** ← plano atual | 1.000 |
| Requisições por minuto | 20 | 20 |

- Cada passo do agente é uma requisição: uma edição trivial gastou 6. Requisição que falha também conta.
- Com 50/dia cabem poucas tarefas pequenas. Se o gratuito virar o executor principal, os US$ 10 se pagam.
- Acabou o limite da OpenRouter: tente os modelos gratuitos do próprio OpenCode (seção abaixo) antes de subir. Esgotados os dois, o próximo degrau é o Haiku, não o Opus.

## Privacidade

Provedor gratuito pode registrar prompts. Não mande para modelo gratuito: segredo, `.env`, dado de usuário, chave. Confira a política em openrouter.ai → Settings → Privacy.
