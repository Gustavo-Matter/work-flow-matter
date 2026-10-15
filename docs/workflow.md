# Workflow com IA — Matter

O jeito de trabalhar com o Claude Code nos projetos da Matter, para back (.NET) e front (Flutter). O diagnóstico que motivou cada regra está em [workflow-atual.md](workflow-atual.md).

As regras abaixo são o **porquê**. O **como** está nas skills do plugin [`matter-workflow`](../plugins/matter-workflow/), que o Claude carrega só quando a tarefa pede. Assim a regra de .NET não ocupa contexto numa sessão de Flutter, e vice-versa.

## O ciclo

```
1. planejar   /matter-workflow:planejar-feature   tarefa central + sub-issues no Linear; o plano fica na descrição da central
2. contrato   /matter-workflow:contrato-api       só quando back e front mudam juntos: contrato antes do código
3. codar      /matter-workflow:feature-back       ou   /matter-workflow:feature-front
4. pronto     /matter-workflow:pronto             checklist + agente revisor ANTES do commit
5. PR         um PR por sub-issue, com a doc daquela sub-issue dentro
```

## Regras

### 1. Um PR por sub-issue, não por plano

PR com 200 arquivos não é revisado por ninguém e não cabe no contexto da IA. Cada sub-issue vira uma branch `tipo/mat-<n>-descricao` e um PR pequeno que leva o código, os testes e a doc daquela sub-issue. A tarefa central junta os PRs.

*Substitui* o "um PR por plano" da convenção anterior.

### 2. A revisão acontece antes do commit

Hoje quase todo `feat` tem um `fix(review)` logo atrás (muma-fit API, muma-fit app, bencao API, bencao mobile). Cada `fix` custa uma segunda rodada inteira: reler código, corrigir, reescrever doc. A skill `pronto` roda o checklist da stack e chama o agente `revisor` **antes** do primeiro commit da feature. O que ele achar entra no mesmo commit.

### 3. Fonte única para cada informação

| Informação | Vive em | Não copie em |
|---|---|---|
| Contrato de rota (método, payload, erros) | back: `docs/api/<modulo>.md` (ou OpenAPI) | ADR, handoff, doc de feature do app |
| Por que uma escolha foi feita | ADR (back) ou `docs/decisions/` (front), curto | api, flow, README |
| O que mudou numa versão | `CHANGELOG.md` do back | handoff com payload copiado |
| Como o app usa a rota | `docs/features/<feature>.md` do app, **com link** para o contrato do back | — |
| Pedido do app para o back | sub-issue no Linear | `docs/back/*.md` no app |
| Plano | descrição da tarefa central no Linear | `docs/planejamento-*.md` |

Doc com mais de ~25 KB é quebrada por módulo. A IA lê o arquivo inteiro ou erra; com 100 KB ela lê pedaços e escreve inconsistências.

Um ADR é **decisão**: contexto, decisão, alternativas, consequências. Sem payload e sem passo a passo de tela.

### 4. CLAUDE.md do repo é índice, não documentação

Até ~2 KB: stack, comandos, gate (`make check`/`dotnet test`), onde está a doc e as armadilhas que a inferência erraria. A arquitetura vive em `docs/`. Modelos em [`templates/`](../templates/). Quando o projeto muda (deploy, banco, fase do produto), o CLAUDE.md muda **no mesmo PR**.

### 5. Processo vive aqui, não em cada repo

Diretrizes do Linear, padrão de tarefa, checklist de pronto e padrão de PR ficam neste repositório. O repo do projeto guarda só o que é dele: projeto e label do Linear, comandos, armadilhas. Nada de branch `docs/diretrizes-linear` por repositório.

### 6. Back e front conversam por contrato, não por handoff

Hoje o back escreve `docs/flutter/handoff-x.md` com código Dart, e o app escreve `docs/back/HANDOFF.md` com os pedidos. As duas pontas copiam o mesmo payload. Pelo novo fluxo:

- o app pede mudança abrindo sub-issue no Linear (skill `contrato-api`);
- o back responde atualizando o contrato do módulo e o CHANGELOG;
- o app lê o contrato e escreve só o que é dele (estado, tela, cache).

### 7. Ambiente enxuto

- Worktree em `C:\Matter\.worktrees\<repo>-<branch>`, nunca no Temp.
- `settings.local.json` com padrões (`Bash(dotnet test *)`), não comandos únicos com payload.
- Uma memória só (arquivo **ou** claude-mem).
- MCP ligado só quando o trabalho do dia precisa dele.

## Stacks

| | Back | Front |
|---|---|---|
| Padrão | .NET 8+/10, módulos por domínio, `controller → service → repository`, envelope `ApiResponse` | Flutter via FVM, features por domínio, Riverpod + go_router + fpdart + `matter_core`/`matter_design_system` (padrão do `matter-flutter-template`) |
| Gate | `dotnet build` sem aviso + `dotnet test` | `make check` (format + analyze + arquitetura + testes) |
| Skill | `feature-back` | `feature-front` |
| Repos | `muma-fit-api`, `bencaodiaria-app-api` | `muma-fit`, `bencaodiaria-app-mobile` (legado em Bloc/get_it: segue o padrão do próprio repo até migrar) |

## Instalação num projeto

Ver [README](../README.md#instalação).
