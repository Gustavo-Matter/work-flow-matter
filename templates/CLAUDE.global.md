# Matter — regras globais

Workflow, processo e padrões por stack vêm do plugin **`matter-workflow`** (repo work-flow-matter, local `C:\Matter\ambiente-ia`). As skills carregam só quando a tarefa pede:
`orquestrar` · `planejar-feature` · `contrato-api` · `feature-back` · `feature-front` · `padroes-codigo` · `registrar-decisao` · `pronto` · `linear-tarefa` · `iniciar-repo` · `diagnosticar-workflow`.

Padrões de código, fonte oficial: Notion → [Padronização de código](https://app.notion.com/p/Padroniza-o-de-c-digo-34c6fee3118c803e9df6f179b52c0019).

## Sempre

- Estrutura por domínio; `controller → service → repository`. Router nunca chama repository, service nunca conhece HTTP, repository nunca tem regra.
- Toda rota devolve o envelope `{ transactionId, message, data?, error? }`.
- Log estruturado; nunca `print`/`console`; nunca logar senha, token ou dado sensível.
- **Opus orquestra e revisa; executa o modelo mais barato que dá conta** (gratuito via OpenCode → Haiku → Sonnet), sempre com brief completo (skill `orquestrar`). Linear e `docs/`: Haiku ou gratuito.
- Comentário no código: no máximo 1 a 2 linhas, só com o porquê.
- Antes de commitar: skill `pronto`. Antes de qualquer escrita no Linear: skill `linear-tarefa`.
- Um PR por sub-issue. Worktree em `C:\Matter\.worktrees\`. Repos da Matter pelo alias SSH `github-matterads`.
