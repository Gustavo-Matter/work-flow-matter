---
name: diagnosticar-workflow
description: Use para auditar como o trabalho com IA está acontecendo num repositório (CLAUDE.md, docs, padrão de commits, tamanho de PR, retrabalho, configuração do .claude) e comparar com o workflow da Matter. Gera um diagnóstico curto com números do git.
---

# diagnosticar-workflow

Medir antes de opinar. Tudo com comando, sem ler o repositório inteiro.

## Coleta

1. **Contexto fixo:** tamanho e data do `CLAUDE.md`; ele bate com o código (stack, deploy, fase do produto)? Confira uma ou duas afirmações no código.
2. **`.claude/`:** `settings.local.json` tem padrões ou comandos únicos? Há skills/agents locais duplicando o plugin?
3. **Commits:** tipos (`git log --no-merges --format=%s | sed -E 's/^([a-z]+).*/\1/' | sort | uniq -c`), razão `fix:feat`, e a sequência `feat` → `fix(review)` → `docs(align)` nos últimos 30.
4. **Volume:** linhas adicionadas por área nos últimos 60–80 commits (`git log --numstat`): docs, código, testes, gerado/migrations.
5. **Doc:** maiores arquivos de `docs/` (acima de ~25 KB) e quantos arquivos de doc um commit de feature toca (`git show --stat`).
6. **PRs e branches:** tamanho das branches abertas (`git diff --stat main...<branch>`), nome da branch × conteúdo, branches já mergeadas ainda no remoto, branch padrão do GitHub × branch ativa, worktrees fora de `$MATTER_HOME/.worktrees` (`git worktree list`).
7. **Gate:** existe CI? Qual comando é o gate local?
8. **Segredos:** `.env` ou credencial versionada em qualquer branch (`git log --all --format=%h -- .env`). Só os nomes das chaves; nunca imprima valores.
9. **Decisões:** quantos ADRs/decisions, e quantos são detalhe de tela pelo critério da skill `registrar-decisao`.

## Saída

Crie `docs/diagnosticos/<AAAA-MM-DD>-<repo>.md` no work-flow-matter (local: `$MATTER_HOME/work-flow-matter`) com: como o trabalho acontece hoje, os números, os desvios do `docs/workflow.md` e a correção proposta para cada um (link para o ADR ou a skill que corrige). Atualize a linha do repo em `docs/adocao.md`. Não edite diagnóstico antigo: ele é o retrato daquela data.
