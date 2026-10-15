# Changelog — plugin matter-workflow

## 0.5.0 — 15/10/2026

- Orquestração (ADR-0010): skill `orquestrar` (executor, brief, OpenCode, revisão), `docs/modelos.md` com papéis, modelos gratuitos e limites da OpenRouter.
- Agentes `linear-haiku` e `docs-haiku` (modelo Haiku).
- `planejar-feature` define executor e brief por sub-issue.
- Comentário no código: no máximo 1 a 2 linhas (`padroes-codigo`, `feature-back`, `feature-front`, `revisor`).

## 0.4.0 — 15/10/2026

- `matter-workflow` 0.4.0: `iniciar-repo` passa a habilitar os plugins pelo `.claude/settings.json` do repo.
- Plugins novos `matter-flutter` 0.1.0 (Dart MCP e LSP do Dart via fvm) e `matter-dotnet` 0.1.0 (LSP de C#).
- ADR-0009; `templates/project-settings.json` no lugar de `templates/front.mcp.json`.

## 0.3.0 — 15/10/2026

- `docs/ferramentas.md` com as ferramentas de terceiros aprovadas e recusadas, ADR-0008 com o critério e regra 11 no workflow.
- `templates/front.mcp.json` (Dart MCP via fvm); `iniciar-repo` passa a configurar MCP e LSP.

## 0.2.0 — 15/10/2026

- Skills novas: `registrar-decisao` (critério e formato de ADR), `iniciar-repo` (criar ou alinhar repo), `padroes-codigo` (Python, Node, Go e princípios comuns, vindos do CLAUDE.md global).
- `pronto`: confere tamanho de doc, critério de ADR e se o CLAUDE.md do repo precisa mudar.
- `diagnosticar-workflow`: verifica branch padrão, branches mergeadas, worktrees, `.env` no histórico e decisões de tela; grava em `docs/diagnosticos/`.
- `feature-front`: tela com Figma exige link com node e a skill `figma:figma-design-to-code`.
- Docs: ADRs 0001–0007, diagnósticos por data, `adocao.md`, modelo `templates/CLAUDE.global.md`.

## 0.1.0 — 15/10/2026

- Plugin inicial: `planejar-feature`, `contrato-api`, `feature-back`, `feature-front`, `pronto`, `linear-tarefa`, `diagnosticar-workflow` e o agente `revisor`.
