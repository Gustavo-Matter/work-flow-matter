# 0010 — Opus orquestra e revisa; modelos gratuitos e Haiku executam

**Status:** Aceita · 15/10/2026

## Contexto

Todo o trabalho rodava no modelo mais caro, inclusive tarefas mecânicas: escrever no Linear, gerar doc, editar arquivo com instrução fechada. A qualidade que importa (desenho, decisão, revisão) é uma fração pequena dos tokens. A OpenRouter oferece modelos `:free` com ferramentas, e o OpenCode está instalado na máquina para rodá-los.

## Decisão

- **Opus é o orquestrador.** Planeja, quebra em tarefas e sub-tarefas (no Linear e para os agentes), escreve o brief de cada uma, escolhe o modelo que executa e **revisa todo diff** antes do commit (gate + agente `revisor`).
- **Executa o mais barato que dá conta**, nesta ordem: modelo gratuito (OpenCode + OpenRouter) → Haiku → Sonnet → Opus. Tabela em [modelos.md](../modelos.md).
- **Linear e `docs/`:** Haiku ou gratuito. Controle de tarefas no Linear: Haiku.
- **Todo executor recebe brief completo** (skill `orquestrar`): objetivo, contexto e arquivos, decisões e ADRs a respeitar, critério de pronto, o que não fazer. Sem brief, não se delega.
- **Escala depois de duas tentativas** que não passam no gate ou na revisão: sobe um degrau.
- **A chave da OpenRouter fica no `.env` da raiz do work-flow-matter** (ignorado pelo git; o modelo é o `.env.example`), com a variável de ambiente `OPENROUTER_API_KEY` do usuário como alternativa. Nunca em arquivo versionado.

## Alternativas descartadas

- **Tudo no Opus:** é o custo de hoje.
- **Tudo no gratuito, sem revisão:** troca tokens por bugs e `fix(review)`, o oposto do objetivo (ADR-0006).
- **Chave no repositório:** o repo está no GitHub; chave versionada vaza com o histórico.

## Consequências

- O limite gratuito é pequeno: 50 requisições/dia e 20/minuto sem créditos; 1.000/dia com US$ 10 em créditos. Uma edição trivial gastou 6 requisições no teste. Sem créditos, o gratuito serve para poucas tarefas pequenas por dia.
- Provedor gratuito pode registrar prompts. Código sensível (segredos, dados de usuário) não vai para modelo gratuito.
- Cada tarefa no Linear registra o executor; o histórico mostra que modelo dá conta de quê.
