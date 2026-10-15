# 0001 — O workflow é distribuído como plugin do Claude Code

**Status:** Aceita · 15/10/2026

## Contexto

As regras de processo estavam espalhadas: `~/.claude/CLAUDE.md`, `~/.claude/skills`, `~/.claude/linear` e uma branch `docs/diretrizes-linear` em cada repositório. Nada versionado num lugar só, e cada cópia divergia.

## Decisão

Este repositório é um marketplace (`matter`) com um plugin (`matter-workflow`). Skills, agente, diretrizes do Linear e templates vivem aqui. Os projetos instalam o plugin; o repo do projeto guarda só o que é dele.

## Alternativas descartadas

- **Pasta `.claude/` copiada em cada repo:** volta a ter N cópias divergindo.
- **Só `~/.claude` da máquina:** não versiona e não chega a outra pessoa da equipe.

## Consequências

- Mudança de processo é PR aqui, com `version` nova no `plugin.json`.
- As cópias em `~/.claude/skills/linear-tarefa` e `~/.claude/linear` devem ser apagadas depois de instalar o plugin.
