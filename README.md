# work-flow-matter

O workflow da Matter com o Claude Code, para back (.NET) e front (Flutter). As correções no processo são feitas aqui e chegam aos projetos pelo plugin.

| Quero… | Vá para |
|---|---|
| Entender as regras do workflow | [docs/workflow.md](docs/workflow.md) |
| Saber o porquê de uma regra | [docs/adr/](docs/adr/) |
| Ver como cada projeto está | [docs/diagnosticos/](docs/diagnosticos/) e [docs/adocao.md](docs/adocao.md) |
| Saber quais plugins, skills e MCPs de terceiros usar | [docs/ferramentas.md](docs/ferramentas.md) |
| Ver o que mudou no plugin | [CHANGELOG.md](CHANGELOG.md) |
| Ver/alterar as skills e o agente | [plugins/matter-workflow/](plugins/matter-workflow/) |
| Começar o CLAUDE.md ou o template de PR de um repo | [templates/](templates/) |

## O plugin `matter-workflow`

| Skill / agente | Quando |
|---|---|
| `planejar-feature` | Antes de trabalho com mais de um PR: sub-issues pequenas, plano na tarefa central |
| `contrato-api` | Back e front mudam juntos, ou o app precisa de algo que a API não tem |
| `feature-back` | Rota, regra ou persistência numa API .NET |
| `feature-front` | Tela, estado ou integração num app Flutter |
| `padroes-codigo` | Código em Python, Node ou Go; princípios comuns (estrutura, fluxo, envelope, logs) |
| `registrar-decisao` | Uma escolha pode virar ADR: critério e formato |
| `pronto` | Antes do commit e do PR: gate + checklist + revisor |
| `iniciar-repo` | Repo novo, ou alinhar um existente ao workflow |
| `linear-tarefa` | Qualquer escrita no Linear (traz as `DIRETRIZES.md` do time) |
| `diagnosticar-workflow` | Auditar o workflow de IA de um repositório |
| agente `revisor` | Chamado pelo `pronto`; revisa o diff antes do commit |

## Instalação

Num terminal `claude` interativo:

```
/plugin marketplace add C:\Matter\ambiente-ia
/plugin install matter-workflow@matter
```

Ou direto do GitHub (exige acesso ao repo pela chave da Matter):

```
/plugin marketplace add git@github-matterads:Gustavo-Matter/work-flow-matter.git
```

Depois de instalar, apague as cópias antigas que o plugin substitui (`~/.claude/skills/linear-tarefa/` e `~/.claude/linear/`) e troque o `~/.claude/CLAUDE.md` pelo modelo [templates/CLAUDE.global.md](templates/CLAUDE.global.md).

## Como alterar

1. Mude a skill ou a doc aqui, num PR.
2. Suba a `version` em `plugins/matter-workflow/.claude-plugin/plugin.json`.
3. Nos projetos: `/plugin marketplace update matter`.
