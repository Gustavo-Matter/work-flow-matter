# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## O que é este repositório

O workflow da Matter com o Claude Code, para back (.NET) e front (Flutter). Não tem código de aplicação, build nem testes: o produto é Markdown e JSON distribuído como **plugin do Claude Code** (`matter-workflow`, no marketplace `matter`). Mudança de processo da equipe se faz aqui e chega aos projetos pelo plugin.

Remoto: `git@<alias>:Gustavo-Matter/work-flow-matter.git`, com o alias SSH da conta `Gustavo-Matter` (`github-matterads` no Windows, `github-work` no Mac): pelo HTTPS o git autentica com a conta pessoal e o push dá 403.

## Como as peças se ligam

- Três camadas, cada uma num lugar: `docs/workflow.md` tem as **regras** (uma linha cada), `docs/adr/` tem o **porquê** e as skills em `plugins/matter-workflow/skills/` têm o **como**. Uma aponta para a outra; não copie conteúdo entre elas. Duplicar é o problema que este repo corrige.
- `docs/diagnosticos/<data>-<escopo>.md` são retratos datados dos projetos, feitos pela skill `diagnosticar-workflow`. Não se edita diagnóstico antigo: um novo é criado. `docs/adocao.md` é a tabela viva do que cada repo já adotou.
- Regra nova ou mudada: ADR (skill `registrar-decisao`, modelo `docs/adr/_template.md`), linha em `docs/workflow.md`, ajuste na skill e linha no índice `docs/README.md`.
- `templates/CLAUDE.global.md` é o modelo do `~/.claude/CLAUDE.md`: só o que vale em toda sessão. Regra de stack vai para skill (ADR-0005).
- Flutter tem quatro repos: os dois apps, o `matter-mobile-kit` e o `matter-flutter-template`. Mudança no kit ou no template é da skill `kit-flutter` (ADR-0011).
- As skills se chamam em cadeia: `planejar-feature` → `contrato-api` (quando back e front mudam juntos) → `feature-back` / `feature-front` → `pronto`, que roda o gate, o checklist da skill da stack e o agente `agents/revisor.md`. Se mudar um checklist em `feature-back` ou `feature-front`, confira se o `revisor` cobre o mesmo item.
- `linear-tarefa` é cópia versionada de `~/.claude/skills/linear-tarefa` e de `~/.claude/linear/DIRETRIZES.md`. A única divergência proposital é "um PR por sub-issue" no lugar de "um PR por plano".
- `templates/` tem os modelos de `CLAUDE.md` de back e de front e o template de PR que os projetos copiam.

## Ao alterar

- Skill: frontmatter com `name` igual ao nome da pasta e `description` que diga **quando** usar. Ela é carregada sob demanda, então pode trazer regras de uma stack só. É o motivo de essas regras não ficarem no `CLAUDE.md` global.
- Mantenha cada skill curta e verificável (checklist, comando, caminho). Regra que não muda o comportamento da IA não entra.
- Há três plugins em `plugins/` (`matter-workflow` core, `matter-flutter`, `matter-dotnet`), listados em `.claude-plugin/marketplace.json`; só o core tem skills, os outros entregam MCP e LSP (ADR-0009). Toda mudança num plugin sobe a `version` do `plugin.json` dele e ganha entrada no `CHANGELOG.md`. Skill ou agente novo também entra na tabela do `README.md` e na lista de `templates/CLAUDE.global.md`.
- Para testar localmente: `/plugin marketplace add $MATTER_HOME/work-flow-matter` (`~/Documents/matter` no Mac, `C:\Matter` no Windows), depois `/plugin install matter-workflow@matter`. As skills aparecem como `/matter-workflow:<skill>`.
- **Nunca versione chave ou segredo.** A chave da OpenRouter fica no `.env` da raiz (ignorado pelo `.gitignore`; só o `.env.example` é versionado) ou na variável de ambiente `OPENROUTER_API_KEY` do usuário; doc e skill citam o nome, nunca o valor.
- Docs e skills em português com acento. Commits em português, Conventional Commits.
