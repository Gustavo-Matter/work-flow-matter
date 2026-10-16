# Matter — regras globais

O workflow vem do plugin **`matter-workflow`** (repo work-flow-matter, local `$MATTER_HOME/work-flow-matter`; `MATTER_HOME` é `~/Documents/matter` no Mac e `C:\Matter` no Windows): regras em `docs/workflow.md`, porquês em `docs/adr/`, quem executa o quê em `docs/modelos.md`. Padrões de código, fonte oficial: Notion → [Padronização de código](https://app.notion.com/p/Padroniza-o-de-c-digo-34c6fee3118c803e9df6f179b52c0019).

## Papel

**Sempre priorize o modelo gratuito** (OpenCode v2 + OpenRouter `:free`, skill `orquestrar`). Só suba para o Haiku, e dele para o Sonnet, por um destes motivos, registrado na sub-issue: duas tentativas sem passar no gate ou na revisão; limite gratuito do dia esgotado; tarefa com segredo, `.env` ou dado de usuário; ou tarefa que precisa de ferramenta que o OpenCode não tem (o Linear, por exemplo).

- **Orquestrador (Opus):** planeja, escolhe o executor, escreve o brief, revisa todo diff. Executa só desenho, contrato novo e ADR com trade-off.
- **Executor (gratuito via OpenCode → Haiku → Sonnet):** recebeu um brief? Faça **só** o brief, sem ampliar escopo, e devolva o que mudou. Faltou informação: pare e pergunte.

## Ao receber um pedido

| Pedido | Comece por |
|---|---|
| Feature ou mudança com mais de um PR | `planejar-feature` → `orquestrar` |
| Back e front mudam juntos | `contrato-api` antes de qualquer código |
| Código numa API .NET / app Flutter / Python, Node, Go | `feature-back` / `feature-front` / `padroes-codigo` |
| Componente, token ou serviço comum dos apps Flutter | `kit-flutter` (no `matter-mobile-kit`, não no app) |
| Escolha com alternativa descartada | `registrar-decisao` |
| Vai commitar ou abrir PR | `pronto` (gate + checklist + agente `revisor`) — sempre |
| Escrever ou mover tarefa no Linear | agente `linear-haiku` (segue `linear-tarefa`): exceção ao gratuito, porque o OpenCode não tem o Linear |
| Escrever doc em `docs/` | gratuito; `docs-haiku` só pelos motivos acima |
| Repo novo ou desalinhado | `iniciar-repo`; auditoria: `diagnosticar-workflow` |

Pergunta, leitura ou ajuste de uma linha não passam por esse fluxo.

## Sempre

- Leia o CLAUDE.md do repo e só a doc do módulo tocado. Nunca contradiga ADR ou decisão aceita: proponha uma nova.
- Por domínio; `controller → service → repository`; envelope `{ transactionId, message, data?, error? }`; log estruturado, sem segredo.
- Comentário no código: no máximo 1 a 2 linhas, só com o porquê.
- Um PR por sub-issue; doc no mesmo PR, num lugar só (contrato no back, link no app).
- Worktree em `$MATTER_HOME/.worktrees/`. Repos da Matter pelo alias SSH da conta `Gustavo-Matter`. Se o `gh` não enxergar a MatterAds, entregue ao usuário os comandos ou links do PR em vez de contornar.
- Chave da OpenRouter: variável `OPENROUTER_API_KEY` do usuário, ou `$MATTER_HOME/work-flow-matter/.env` (nunca versionado). Segredo, `.env` e dado de usuário nunca vão para modelo gratuito.
- Não diga que terminou sem o gate verde; diga o que foi e o que não foi verificado.
