# work-flow-matter

O workflow da Matter com o Claude Code, para back (.NET) e front (Flutter). As correções no processo são feitas aqui e chegam aos projetos pelo plugin.

| Quero… | Vá para |
|---|---|
| Entender as regras do workflow | [docs/workflow.md](docs/workflow.md) |
| Saber o porquê de uma regra | [docs/adr/](docs/adr/) |
| Ver como cada projeto está | [docs/diagnosticos/](docs/diagnosticos/) e [docs/adocao.md](docs/adocao.md) |
| Saber quais plugins, skills e MCPs de terceiros usar | [docs/ferramentas.md](docs/ferramentas.md) |
| Saber qual modelo executa cada tarefa | [docs/modelos.md](docs/modelos.md) |
| Ver o que mudou no plugin | [CHANGELOG.md](CHANGELOG.md) |
| Ver/alterar as skills e o agente | [plugins/matter-workflow/](plugins/matter-workflow/) |
| Começar o CLAUDE.md ou o template de PR de um repo | [templates/](templates/) |

## Plugins do marketplace `matter`

| Plugin | Entrega | Habilitar em |
|---|---|---|
| `matter-workflow` | Skills e agente abaixo | Todos os repos |
| `matter-flutter` | Dart MCP e LSP do Dart (via `fvm`) | Apps Flutter |
| `matter-dotnet` | LSP de C# (`csharp-ls`) | APIs .NET |

Cada repo habilita o que usa no próprio `.claude/settings.json` ([modelo](templates/project-settings.json)). Plugins de terceiros recomendados: [docs/ferramentas.md](docs/ferramentas.md).

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
| `orquestrar` | No Opus: escolher o executor, escrever o brief, disparar no OpenCode ou num subagente e revisar |
| agente `linear-haiku` | Escreve e controla tarefas no Linear a partir de um plano aprovado |
| agente `docs-haiku` | Escreve doc em `docs/` a partir de um diff ou brief |
| `linear-tarefa` | Qualquer escrita no Linear (traz as `DIRETRIZES.md` do time) |
| `diagnosticar-workflow` | Auditar o workflow de IA de um repositório |
| agente `revisor` | Chamado pelo `pronto`; revisa o diff antes do commit |

## Instalação

Num terminal `claude` interativo:

```
/plugin marketplace add C:\Matter\ambiente-ia
/plugin install matter-workflow@matter
/plugin install matter-flutter@matter   # só em máquina/projeto Flutter
/plugin install matter-dotnet@matter    # só em máquina/projeto .NET
```

Ou direto do GitHub (exige acesso ao repo pela chave da Matter):

```
/plugin marketplace add git@github-matterads:Gustavo-Matter/work-flow-matter.git
```

Depois de instalar, apague as cópias antigas que o plugin substitui (`~/.claude/skills/linear-tarefa/` e `~/.claude/linear/`) e troque o `~/.claude/CLAUDE.md` pelo modelo [templates/CLAUDE.global.md](templates/CLAUDE.global.md).

## Configuração local

```bash
cp .env.example .env
```

Preencha `OPENROUTER_API_KEY` no `.env` (modelos gratuitos via OpenCode, ver [docs/modelos.md](docs/modelos.md)). O `.env` não é versionado.

## Como alterar

1. Mude a skill ou a doc aqui, num PR.
2. Suba a `version` em `plugins/matter-workflow/.claude-plugin/plugin.json`.
3. Nos projetos: `/plugin marketplace update matter`.
