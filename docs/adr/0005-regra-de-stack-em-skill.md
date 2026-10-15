# 0005 — Regra de stack mora em skill; o CLAUDE.md global fica enxuto

**Status:** Aceita · 15/10/2026

## Contexto

O `~/.claude/CLAUDE.md` global carrega em toda sessão os padrões de Python, Node e Go, mas nenhum de .NET ou Flutter, que são as stacks em uso. Regra que não se aplica gasta contexto; regra que falta faz a IA redescobrir o padrão (e os repos acabam com regras contraditórias, como XML doc no .NET).

## Decisão

- Regra de stack fica em skill, carregada só quando a tarefa pede: `feature-back`, `feature-front` e `padroes-codigo` (Python, Node, Go e os princípios comuns).
- O CLAUDE.md global guarda só o que vale para toda sessão: onde está o workflow, as regras absolutas de arquitetura em uma linha cada, e o que não pode ser logado. Modelo em [templates/CLAUDE.global.md](../../templates/CLAUDE.global.md).
- O CLAUDE.md do repo é índice de até ~2 KB.

## Alternativas descartadas

- **Tudo no global:** custo fixo em toda sessão e cresce a cada stack.
- **Tudo no CLAUDE.md de cada repo:** N cópias divergindo.

## Consequências

- A fonte oficial dos padrões continua sendo a página do Notion "Padronização de código"; a skill `padroes-codigo` é a versão que o agente lê, e muda junto.
