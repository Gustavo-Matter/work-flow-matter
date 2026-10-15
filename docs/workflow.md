# Workflow com IA — Matter

O jeito de trabalhar com o Claude Code nos projetos da Matter, para back (.NET) e front (Flutter). Aqui estão as regras; o **porquê** de cada uma está nos [ADRs](adr/) e o **como** nas skills do plugin [`matter-workflow`](../plugins/matter-workflow/), que o Claude carrega só quando a tarefa pede.

## O ciclo

```
0. repo       /matter-workflow:iniciar-repo        repo novo, ou alinhar um existente
1. planejar   /matter-workflow:planejar-feature    tarefa central + sub-issues; plano na descrição da central
2. contrato   /matter-workflow:contrato-api        só quando back e front mudam juntos
3. codar      /matter-workflow:feature-back        ou   feature-front   (princípios comuns: padroes-codigo)
   decidir    /matter-workflow:registrar-decisao   quando uma escolha pode virar ADR
4. pronto     /matter-workflow:pronto              gate + checklist + agente revisor, ANTES do commit
5. PR         um por sub-issue, com a doc daquela sub-issue dentro
```

Escrita no Linear, em qualquer etapa: `/matter-workflow:linear-tarefa`.

## Regras

| # | Regra | Detalhe |
|---|---|---|
| 1 | **Um PR por sub-issue**, branch `tipo/mat-<n>-descricao`, até ~15 arquivos de código | [ADR-0002](adr/0002-pr-por-sub-issue.md) |
| 2 | **Revisão antes do commit** (`pronto` + `revisor`); nada de `fix(review)` logo depois do `feat` | [ADR-0006](adr/0006-revisao-antes-do-commit.md) |
| 3 | **Fonte única** para cada informação (tabela abaixo) e doc com no máximo ~25 KB | [ADR-0003](adr/0003-fonte-unica-de-doc.md) |
| 4 | **Back e front conversam por contrato** no repo do back e por sub-issue no Linear; sem handoff em Markdown | [ADR-0004](adr/0004-contrato-back-front.md) |
| 5 | **ADR só para decisão** com alternativa descartada; detalhe de tela vai para o doc da feature | [ADR-0007](adr/0007-criterio-de-adr.md) |
| 6 | **CLAUDE.md do repo é índice** de até ~2 KB e muda no mesmo PR que muda o que ele afirma (stack, deploy, banco, fase do produto) | `pronto`, `iniciar-repo` |
| 7 | **Regra de stack em skill**, não no CLAUDE.md global | [ADR-0005](adr/0005-regra-de-stack-em-skill.md) |
| 8 | **Processo vive neste repo** e chega pelo plugin; nada de diretrizes copiadas em cada projeto | [ADR-0001](adr/0001-plugin-distribui-o-workflow.md) |
| 9 | **Tela com Figma** só começa com o link e o node na sub-issue, lida pela skill do Figma | `feature-front` |
| 10 | **Higiene:** worktree em `C:\Matter\.worktrees\`; branch padrão = branch ativa; branches mergeadas apagadas; segredo fora do git; `settings.local.json` com padrões; uma memória só; MCP ligado só quando o trabalho do dia precisa | `iniciar-repo`, `diagnosticar-workflow` |
| 11 | **Ferramenta de terceiros** só entra com problema medido, hooks lidos e custo de contexto baixo; a lista aprovada está em [ferramentas.md](ferramentas.md) | [ADR-0008](adr/0008-criterio-para-ferramentas-de-terceiros.md) |

### Onde vive cada informação

| Informação | Vive em | Não copie em |
|---|---|---|
| Contrato de rota (método, payload, erros) | back: `docs/api/<modulo>.md` | ADR, handoff, doc de feature do app |
| Por que uma escolha foi feita | ADR (back) ou `docs/decisions/` (front) | api, flow, README |
| O que mudou numa versão | `CHANGELOG.md` do back | handoff com payload copiado |
| Como o app usa a rota | `docs/features/<feature>.md`, **com link** para o contrato | — |
| Detalhe de tela | `docs/features/<feature>.md` | ADR |
| Pedido do app para o back | sub-issue no Linear | `docs/back/*.md` no app |
| Plano | descrição da tarefa central no Linear | `docs/planejamento-*.md` |
| Processo (Linear, PR, pronto) | este repo | `docs/linear.md` em cada projeto |

## Stacks

| | Back | Front |
|---|---|---|
| Padrão | .NET 8+/10, módulos por domínio, `controller → service → repository`, envelope `ApiResponse` | Flutter via FVM, features por domínio, Riverpod + go_router + fpdart + `matter_core`/`matter_design_system` (`matter-flutter-template`) |
| Gate | `dotnet build` sem aviso + `dotnet test` | `make check` (format + analyze + arquitetura + testes) |
| Skill | `feature-back` | `feature-front` |
| Repos | `muma-fit-api`, `bencaodiaria-app-api` | `muma-fit`, `bencaodiaria-app-mobile` (legado em Bloc/get_it: segue o padrão do próprio repo) |

Python, Node e Go: skill `padroes-codigo`.

## Estado dos projetos

Diagnósticos datados em [diagnosticos/](diagnosticos/) e o que cada repo já adotou em [adocao.md](adocao.md).
