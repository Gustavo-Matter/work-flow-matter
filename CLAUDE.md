# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## O que é este repositório

O workflow da Matter com o Claude Code, para back (.NET) e front (Flutter). Não tem código de aplicação, build nem testes: o produto é Markdown e JSON distribuído como **plugin do Claude Code** (`matter-workflow`, no marketplace `matter`). Mudança de processo da equipe se faz aqui e chega aos projetos pelo plugin.

Remoto: `git@github-matterads:Gustavo-Matter/work-flow-matter.git`. Use o alias SSH `github-matterads`: pelo HTTPS o git autentica com a conta pessoal e o push dá 403.

## Como as peças se ligam

- `docs/workflow.md` diz as regras e o **porquê**. As skills em `plugins/matter-workflow/skills/` dizem o **como**. Não copie o conteúdo de uma skill para a doc nem o contrário: a doc aponta para a skill. Duplicar é justamente o problema que este repo corrige (ver `docs/workflow-atual.md`).
- `docs/workflow-atual.md` é o diagnóstico com números do git dos projetos (`muma-fit-api`, `bencaodiaria-app-api`, `muma-fit` Flutter, `bencaodiaria-app-mobile`). Um projeto novo diagnosticado ganha uma seção aqui, pela skill `diagnosticar-workflow`.
- As skills se chamam em cadeia: `planejar-feature` → `contrato-api` (quando back e front mudam juntos) → `feature-back` / `feature-front` → `pronto`, que roda o gate, o checklist da skill da stack e o agente `agents/revisor.md`. Se mudar um checklist em `feature-back` ou `feature-front`, confira se o `revisor` cobre o mesmo item.
- `linear-tarefa` é cópia versionada de `~/.claude/skills/linear-tarefa` e de `~/.claude/linear/DIRETRIZES.md`. A única divergência proposital é "um PR por sub-issue" no lugar de "um PR por plano".
- `templates/` tem os modelos de `CLAUDE.md` de back e de front e o template de PR que os projetos copiam.

## Ao alterar

- Skill: frontmatter com `name` igual ao nome da pasta e `description` que diga **quando** usar. Ela é carregada sob demanda, então pode trazer regras de uma stack só. É o motivo de essas regras não ficarem no `CLAUDE.md` global.
- Mantenha cada skill curta e verificável (checklist, comando, caminho). Regra que não muda o comportamento da IA não entra.
- Toda mudança no plugin sobe a `version` em `plugins/matter-workflow/.claude-plugin/plugin.json`. Skill ou agente novo também entra na tabela do `README.md`.
- Para testar localmente: `/plugin marketplace add C:\Matter\ambiente-ia`, depois `/plugin install matter-workflow@matter`. As skills aparecem como `/matter-workflow:<skill>`.
- Docs e skills em português com acento. Commits em português, Conventional Commits.
