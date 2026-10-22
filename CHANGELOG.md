# Changelog — plugin matter-workflow

## Não lançado

- Os modelos gratuitos do próprio OpenCode entram na escada, com limite à parte do da OpenRouter: esgotou a OpenRouter, tente o OpenCode antes do Haiku. Ainda não validados (execução pendurada em 22/10/2026); `docs/modelos.md` traz o teste de fumaça com limite de tempo.

## 0.6.0 — 16/10/2026

- Flutter mapeado por inteiro ([diagnóstico de 16/10](docs/diagnosticos/2026-10-16-flutter-e-mac.md)): kit, template e os dois apps.
- `feature-front` reescrita: perfil por app (template/muma × bencao), scaffold pelo brick `matterads_feature`, checagem de Figma explícita, checklist com os defeitos reais dos dois apps e itens condicionais (l10n, tema escuro, push, ads, plataforma).
- Skill nova `kit-flutter`: mudança no `matter-mobile-kit` e no `matter-flutter-template` (componente, token, release-please, consumo por tag, bricks). ADR-0011.
- Testes Flutter com `mocktail`, sem fake escrito à mão (ADR-0012); `revisor` cobra.
- `orquestrar`: OpenCode v2 obrigatório, comando em bash e em PowerShell, raiz `$MATTER_HOME`, chave pela variável `OPENROUTER_API_KEY` primeiro.
- Caminhos do Windows trocados por `$MATTER_HOME` (Mac `~/Documents/matter`, Windows `C:\Matter`); a pasta do repo passa a ser `work-flow-matter` (no Windows, renomeie `ambiente-ia`).
- O agente que planejou a tarefa é sempre o orquestrador dela (global, `orquestrar`).
- `matter-flutter` 0.1.1: só documentação; instalação no escopo local.

## 0.5.3 — 15/10/2026

- Prioridade do modelo gratuito explícita: outro executor só com motivo registrado na sub-issue (global, `orquestrar`, `planejar-feature`, `modelos.md`, ADR-0010). Doc passa a ser gratuito primeiro; Linear segue no Haiku porque o OpenCode não tem o Linear.

## 0.5.2 — 15/10/2026

- `templates/CLAUDE.global.md`: papel de orquestrador × executor, tabela "ao receber um pedido" com a skill ou agente de entrada, agentes `linear-haiku`/`docs-haiku` nomeados, local da chave e regra do `gh` sem acesso à MatterAds.

## 0.5.1 — 15/10/2026

- Chave da OpenRouter no `.env` da raiz (`.env.example` versionado, `.env` no `.gitignore`); a skill `orquestrar` lê dele, com a variável de ambiente do usuário como alternativa.

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
