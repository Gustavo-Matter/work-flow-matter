# Documentação — work-flow-matter

| Quero… | Leia |
|---|---|
| As regras do workflow | [workflow.md](workflow.md) |
| O porquê de uma regra | [adr/](adr/) |
| Como está cada projeto hoje | [diagnosticos/](diagnosticos/) e [adocao.md](adocao.md) |
| Quais plugins, skills e MCPs de terceiros usar | [ferramentas.md](ferramentas.md) |
| O passo a passo de uma tarefa | as skills em [plugins/matter-workflow/skills/](../plugins/matter-workflow/skills/) |

## ADRs

| # | Decisão |
|---|---|
| [0001](adr/0001-plugin-distribui-o-workflow.md) | O workflow é distribuído como plugin do Claude Code |
| [0002](adr/0002-pr-por-sub-issue.md) | Um PR por sub-issue (substitui "um PR por plano") |
| [0003](adr/0003-fonte-unica-de-doc.md) | Fonte única para cada informação, e doc com tamanho máximo |
| [0004](adr/0004-contrato-back-front.md) | Back e front conversam por contrato e por sub-issue |
| [0005](adr/0005-regra-de-stack-em-skill.md) | Regra de stack mora em skill; o CLAUDE.md global fica enxuto |
| [0006](adr/0006-revisao-antes-do-commit.md) | A revisão acontece antes do commit |
| [0007](adr/0007-criterio-de-adr.md) | ADR só para decisão com alternativa descartada |
| [0008](adr/0008-criterio-para-ferramentas-de-terceiros.md) | Critério para plugins, skills e MCPs de terceiros |
| [0009](adr/0009-ferramentas-de-stack-em-plugins-separados.md) | Ferramentas de stack são plugins separados do core |

## Diagnósticos

- [2026-10-15 — ambiente](diagnosticos/2026-10-15-ambiente.md)
- [2026-10-15 — APIs .NET](diagnosticos/2026-10-15-apis-dotnet.md)
- [2026-10-15 — apps Flutter](diagnosticos/2026-10-15-apps-flutter.md)
