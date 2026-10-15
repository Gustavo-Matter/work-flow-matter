# Adoção do workflow por repositório

Atualizada pela skill `iniciar-repo` ou `diagnosticar-workflow` a cada mudança. `✓` feito · `—` falta · `~` em andamento.

| Repo | Plugin instalado | CLAUDE.md índice e atual | Template de PR | CI | Contrato fora de handoff | Processo fora do repo | Branches limpas |
|---|---|---|---|---|---|---|---|
| muma-fit-api | — | ✓ | — | — (só deploy, sem teste) | — (`docs/flutter/handoff-*`) | — (`docs/diretrizes-linear`) | — |
| bencaodiaria-app-api | — | — (desatualizado na `main`) | — | ✓ | ✓ | — (`docs/linear.md` na branch) | — |
| muma-fit (app) | — | ~ | ✓ | ~ | — (`docs/back/`) | — (`docs/mat-1508-diretrizes-linear`) | — |
| bencaodiaria-app-mobile | — | ~ | ~ | ✓ | ✓ | ~ (`docs/linear.md`) | — (`master` como padrão) |

`~` nos apps: em andamento nas sessões de 15/10/2026 que aplicam as melhorias.

## Ferramentas (docs/ferramentas.md)

| Repo | Dart MCP (`.mcp.json`) | LSP no CLAUDE.md |
|---|---|---|
| muma-fit (app) | ~ branch `chore/mat-dart-mcp` enviada, PR pendente | — (esperar o PR do CLAUDE.md) |
| bencaodiaria-app-mobile | ~ branch `chore/mat-dart-mcp` enviada, PR pendente | — (esperar o PR do CLAUDE.md) |
| APIs .NET | n/a | — |

Plugin `matter-workflow`: registrado no `~/.claude/settings.json` da máquina de Gustavo em 15/10/2026 (marketplace `matter` por diretório).
