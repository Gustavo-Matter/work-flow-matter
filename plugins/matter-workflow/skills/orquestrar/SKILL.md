---
name: orquestrar
description: Use (no Opus) para executar um plano ou uma sub-issue delegando a modelos mais baratos — escolher o executor, escrever o brief, disparar no OpenCode (modelos gratuitos da OpenRouter) ou num subagente Haiku/Sonnet, e revisar o resultado antes do commit.
---

# orquestrar

O Opus pensa e revisa; quem digita é o modelo mais barato que dá conta. Tabela de papéis e limites: `docs/modelos.md` do work-flow-matter (`C:\Matter\ambiente-ia`).

## 1. Escolha o executor

Para cada tarefa do plano, na ordem: **gratuito → Haiku → Sonnet → Opus**.
- Desenho, contrato novo, ADR com trade-off, mudança de arquitetura: Opus faz.
- Código ou teste com brief fechado: gratuito.
- Linear: agente `linear-haiku`. Doc: agente `docs-haiku` ou gratuito.
- Envolve segredo, `.env` ou dado de usuário: **nunca** gratuito.
- Registre o executor na sub-issue do Linear (`Executor: <modelo>`).

## 2. Escreva o brief

Sem brief, não se delega. O executor não viu esta conversa.

```
## Objetivo
<o resultado, em uma ou duas frases>

## Contexto
- Repo e worktree: <caminho>
- Leia antes: <CLAUDE.md, doc do módulo, ADRs que se aplicam — caminhos exatos>
- Siga como modelo: <arquivo existente que já faz algo parecido>

## Regras que não podem ser quebradas
<decisões e ADRs aceitos, camadas, envelope, design system; comentário no código só com o porquê, 1 a 2 linhas>

## Faça
<passos, arquivos a criar/alterar>

## Não faça
<o que está fora do escopo; não crie arquivos fora da lista; não altere testes para passar>

## Pronto quando
<critério verificável + o comando do gate>

## Responda com
<lista dos arquivos alterados e uma linha por mudança>
```

Brief longo é sinal de tarefa grande: quebre antes.

## 3. Dispare

**Gratuito (OpenCode):** grave o brief num arquivo e rode no worktree da tarefa:

```powershell
$env:OPENROUTER_API_KEY = [Environment]::GetEnvironmentVariable('OPENROUTER_API_KEY','User')
Set-Location C:\Matter\.worktrees\<worktree>
opencode run --standalone --auto --model 'openrouter/poolside/laguna-s-2.1:free' -f <brief.md> 'Execute a tarefa do arquivo anexo.'
```

Rode em segundo plano quando passar de ~2 minutos. Limite: 50 requisições/dia sem créditos; cada passo do agente gasta uma.

**Haiku/Sonnet:** ferramenta Agent com `model: "haiku"` ou `"sonnet"` e o brief como prompt, ou os agentes `linear-haiku` e `docs-haiku`.

**Teste de fumaça de um modelo gratuito novo:** um arquivo descartável com um bug de uma linha, fora de qualquer repo; anote requisições e tempo em `docs/modelos.md`.

## 4. Revise (sempre no Opus)

1. `git diff` do worktree: só os arquivos do brief mudaram?
2. Gate do repo (skill `pronto`).
3. Agente `revisor` no diff.
4. Passou: commit (skill `pronto`). Não passou: devolva ao mesmo executor com o erro exato **uma vez**; falhou de novo, suba um degrau com o brief corrigido.

Nunca commite trabalho de outro modelo sem esta revisão.
