# Adoção do workflow por repositório

Atualizada pela skill `iniciar-repo` ou `diagnosticar-workflow` a cada mudança. `✓` feito · `—` falta · `~` em andamento.

| Repo | Plugin instalado | CLAUDE.md índice e atual | Template de PR | CI | Contrato fora de handoff | Processo fora do repo | Branches limpas |
|---|---|---|---|---|---|---|---|
| muma-fit-api | — | ✓ | — | — (só deploy, sem teste) | — (`docs/flutter/handoff-*`) | — (`docs/diretrizes-linear`) | — |
| bencaodiaria-app-api | — | — (desatualizado na `main`) | — | ✓ | ✓ | — (`docs/linear.md` na branch) | — |
| muma-fit (app) | — | ~ | ✓ | ~ | — (`docs/back/`) | — (`docs/mat-1508-diretrizes-linear`) | — |
| bencaodiaria-app-mobile | — | ~ | ~ | ✓ | ✓ | ~ (`docs/linear.md`) | — (`master` como padrão) |

`~` nos apps: em andamento nas sessões de 15/10/2026 que aplicam as melhorias.

## Rollout nos projetos

Um PR por projeto, depois que o workflow fechar. Cada PR leva tudo junto (ADR-0002 vale para o trabalho do dia a dia; adoção do workflow é uma entrega só):

| Projeto | Conteúdo do PR |
|---|---|
| muma-fit (app) | `.claude/settings.json` (workflow + flutter), linha do LSP no CLAUDE.md, ajustes do diagnóstico que ainda faltarem |
| bencaodiaria-app-mobile | idem |
| muma-fit-api | `.claude/settings.json` (workflow + dotnet), CLAUDE.md índice, template de PR, contrato em `docs/api/` |
| bencaodiaria-app-api | idem, mais o CLAUDE.md atualizado (deploy GitHub Actions → ECR → EC2) |

Status: **não iniciado**. As branches `chore/mat-dart-mcp` dos dois apps ficaram obsoletas (o Dart MCP vem do plugin) e entram no PR do rollout ou são apagadas.

Plugin `matter-workflow`: registrado no `~/.claude/settings.json` da máquina de Gustavo em 15/10/2026 (marketplace `matter` por diretório).
