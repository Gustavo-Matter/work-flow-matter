# Workflow atual com IA — diagnóstico

Levantamento de 15/10/2026 sobre os projetos em que o Claude Code mais trabalhou. Back: `muma-fit-api` (.NET 10, pasta local `muma-fit`) e `bencaodiaria-app-api` (.NET 8). Front: `muma-fit` (Flutter, pasta local `muma-fit-app`) e `bencaodiaria-app-mobile` (Flutter). Objetivo: entender como o trabalho com a IA acontece hoje e onde ele gasta tokens sem retorno. O workflow que corrige isso está em [workflow.md](workflow.md).

As seções "Como o workflow funciona hoje" e "Onde estão o desperdício" tratam do back; o front tem a seção própria [Front (Flutter)](#front-flutter).

## Como o workflow funciona hoje

### Contexto que a IA carrega em toda sessão

| Camada | O que tem | Observação |
|---|---|---|
| `~/.claude/CLAUDE.md` (global) | Padrões Matter para Python, Node e Go; Linear | Não tem regra nenhuma de .NET, que é a stack dos dois projetos. |
| `CLAUDE.md` do repo | muma-fit: 1,7 KB, enxuto, aponta para `docs/`. bencao: 6,9 KB, repete a arquitetura inteira. | O do bencao está **desatualizado na `main`** (ver problemas). |
| Memória (`MEMORY.md` + claude-mem) | Notas de projeto + injeção automática de observações | Duas memórias paralelas fazendo a mesma coisa. |
| Plugins / MCP | claude-mem, Figma, Canva, Notion, Linear, design, pdf… | Cada servidor soma definições de ferramenta ao contexto, mesmo sem uso. |
| `.claude/settings.local.json` | Permissões aprovadas uma a uma | Viraram lista de comandos únicos (curl com payload, caminhos de scratchpad de sessões antigas). |

### Ciclo de uma feature (padrão observado no git)

```
planejamento em docs/ (+ tarefa central no Linear)
  → feat(...)                       código + testes
  → fix(...): ajustes da revisão     a própria IA revisa e corrige
  → docs(...): ADR + api + flow + handoff + domain + roadmap + README
  → docs(...): align / clarify       corrige a doc que acabou de escrever
  → um PR por plano
```

Exemplos reais no muma-fit (feature de stories, feed e conquistas da 0.14):

- `feat(feed)` → `fix(feed): harden…` → `docs(feed)` → `docs(feed): align… with the hardening`
- `feat(groups): achievements` → `docs(groups): ADR-0040…` → `fix(groups)` → `docs(groups): document EndsOn…` → `docs(flutter): clarify 0.14 handoff`

No bencao, o plano de features inteiro (MAT-1511 a MAT-1531) está numa branch chamada `docs/planejamento-features`: **33 commits, 214 arquivos, ~18 mil linhas** num único PR. Cada bloco de feat tem seu `fix(api): ajustes da revisão…` logo depois.

### Documentação gerada

| | muma-fit | bencao |
|---|---|---|
| ADRs | 40 | 9 |
| `docs/` em Markdown | ~14 mil linhas (~900 KB) | ~2,5 mil linhas |
| Maiores arquivos | `api.md` 108 KB, `domain.md` 58 KB, `flutter/grupos-e-gamificacao.md` 47 KB, `CHANGELOG.md` 45 KB | — |
| Código de produção (sem testes) | ~83 mil linhas `.cs` (boa parte migrations do EF) | — |

Uma feature média do muma-fit toca **7–8 arquivos de doc**: ADR, `api.md`, `flows/*.md`, `flutter/handoff-x.md`, `flutter/README.md`, `domain.md`, `roadmap.md`, `docs/README.md`, e depois o `CHANGELOG.md`. A mesma informação (rota, regra, payload) é escrita 3–4 vezes em lugares diferentes.

## Onde estão o desperdício e a má execução

1. **Documentação em leque.** Cada mudança vira ~250–480 linhas de doc espalhadas. Escrever custa tokens, e cada cópia precisa ser lida e mantida depois — daí os commits `docs: align/clarify` que só consertam divergência entre cópias. `api.md` com 108 KB é grande demais para a IA ler inteiro, então ela lê pedaços e escreve inconsistências.
2. **Retrabalho embutido no ciclo.** Quase todo `feat` tem um `fix` de revisão logo atrás. O código sai incompleto (contadores não atômicos, regras de membro, fuso, `EndsOn`) e a correção custa uma segunda rodada inteira: reler código, corrigir, reescrever doc.
3. **PR gigante por plano.** "Um PR por plano" + tudo na mesma branch gera PRs de 200+ arquivos que ninguém revisa de verdade e que a IA não consegue segurar no contexto. Nome de branch (`docs/…`) não bate com o conteúdo (código de produção).
4. **Contexto errado na `main` do bencao.** O `CLAUDE.md` da `main` diz Bitbucket → DigitalOcean, MySQL e PRs para `develop`; o deploy real (`.github/workflows/deploy.yml`) é GitHub Actions → ECR → EC2 arm64. A correção existe, mas só na branch de docs. A IA lê instrução errada em toda sessão.
5. **Regras contraditórias entre projetos.** muma-fit proíbe XML doc (`///`); bencao liga `GenerateDocumentationFile` e espera XML doc. Como o global não fala de .NET, a IA não tem um padrão único e gasta tokens descobrindo (e já houve script de remoção de XML doc em massa no muma-fit).
6. **Worktrees em pasta temporária.** As branches `docs/diretrizes-linear` e `docs/planejamento-features` estão em worktrees dentro de `AppData\Local\Temp\claude\…\scratchpad`. Uma limpeza do Temp some com o diretório e deixa worktree órfão.
7. **Trabalho de processo duplicado por repo.** As "diretrizes do Linear" viraram uma branch `docs/diretrizes-linear` em **cada** repositório (o bencao ganhou um `docs/linear.md` de 175 linhas), embora já existam em `~/.claude/linear/DIRETRIZES.md` e na skill `linear-tarefa`.
8. **Ruído fixo no contexto.** Muitos MCPs ligados sem relação com backend .NET (Figma, Canva…), duas memórias paralelas e `settings.local.json` com dezenas de permissões descartáveis.

## Front (Flutter)

| | muma-fit (app) | bencaodiaria-app-mobile |
|---|---|---|
| Arquitetura | Riverpod + codegen, go_router, `fpdart`, `matter_core`/`matter_design_system` | Cubit/Bloc + get_it, rotas nomeadas, `AppFailure`, mocktail |
| Branch ativa | `main` (338 commits, 46 merges) | `main` (163 commits); `master` e `develop` paradas desde 2024 |
| Gate | `make check` + `tool/check_architecture.dart` (11 regras: ARCH, DS, MEDIA…). **Sem CI**: só o gate local | CI no GitHub Actions (format, analyze, test, build apk e ios) |
| `CLAUDE.md` | ~8 KB, bom como índice e com regras verificáveis | ~11,6 KB, em inglês, repete a arquitetura inteira |
| Docs | ~1 MB: 60 decisões, `features/groups.md` 86 KB, `stories.md` 38 KB, `day.md` 35 KB, `docs/back/` com 14 pedidos ao back + `HANDOFF.md` | `docs/melhorias/` (auditoria de ~120 KB em 7 arquivos) + `docs/linear.md` |
| Commits | 110 `feat`, **84 `fix`**, 52 `docs` | 39 `feat`, **64 `fix`**, 13 `chore` |

### O que acontece

- **Fidelidade ao Figma em várias rodadas.** Nos stories do muma-fit, um `feat` puxou oito `fix` seguidos: "fiel ao Figma", "cabeçalho como no Figma", "marca sem fundo branco", "legenda com uma linha", "galeria relê a permissão"… A tela é codada sem o frame exato e sem os estados de borda (permissão negada, toque duplo, retry), e cada ajuste vira uma rodada nova.
- **Retrabalho de revisão também no front.** No bencao mobile, os itens da auditoria entram como `feat`/`fix` e voltam como `fix(review): …` (P6, P7, U8, U10, S4).
- **Handoff duplicado entre back e front.** A API escreve `docs/flutter/handoff-0.1x.md` com código Dart; o app escreve `docs/back/*.md` e `HANDOFF.md` com os pedidos. O mesmo payload existe nos dois repos e precisa ser alinhado à mão a cada versão.
- **CLAUDE.md desatualizado no muma-fit app.** Ele diz "hoje existe só o fluxo de entrada, nada de domínio foi escrito", mas o app já tem refeições, água, treino, grupos, stories, metas e saúde. Toda sessão começa com o contexto errado sobre a fase do produto.
- **Doc de feature gigante.** `groups.md` com 86 KB não cabe numa leitura; a regra `DOC-01` obriga a existir, mas não limita o tamanho.
- **Dois apps, dois padrões.** Riverpod × Bloc, `fpdart` × exceções, design system do kit × tokens locais. Sem uma skill por stack, a IA descobre o padrão a cada sessão.
- **Mesma branch de processo em todo repo.** `docs/mat-1508-diretrizes-linear` existe nos dois apps também.
- **`.env` versionado nas branches antigas** (`master`/`develop`) do bencao mobile. A `main` já não versiona, mas o histórico ainda tem o arquivo.

## Ajustes propostos (para decidir)

| # | Ajuste | Efeito esperado |
|---|---|---|
| 1 | **Uma fonte por informação.** Contrato de rota só no OpenAPI/`api.md`; ADR só para decisão (curto, sem repetir payload); handoff do Flutter aponta para `api.md` em vez de copiar; `domain.md`/`roadmap`/`README` só mudam quando a coisa muda de fato. | Corta a maior parte do volume de doc e acaba com os `docs: align`. |
| 2 | **Quebrar `api.md` e `domain.md` por módulo** (`docs/api/groups.md`…). | A IA lê só o módulo da tarefa. |
| 3 | **Checklist de "pronto" antes do commit** no CLAUDE.md do repo (concorrência/atomicidade, autorização de membro, fuso, exclusão de conta, testes de borda). | O `fix` de revisão passa a acontecer antes do `feat`, numa rodada só. |
| 4 | **PR por sub-issue** (ou por fase), não por plano inteiro; branch com o nome do que contém. | PRs revisáveis e contexto que cabe. |
| 5 | **Seção .NET no CLAUDE.md global** (comentários/XML doc, envelope, camadas, logs com Serilog) e alinhar os dois repos a ela. | Fim das regras contraditórias. |
| 6 | **Mergear a correção do CLAUDE.md do bencao** e enxugá-lo para o formato do muma-fit (apontar para `docs/`, sem repetir arquitetura). | Contexto correto e menor em toda sessão. |
| 7 | **Diretrizes de processo só no global** (`~/.claude/linear`, skills); repos só guardam o projeto e a label do Linear. Fechar as branches `docs/diretrizes-linear`. | Sem cópia de processo por repo. |
| 8 | **Higiene do ambiente:** worktrees em `C:\Matter\.worktrees`, limpar `settings.local.json` trocando comandos únicos por padrões (`Bash(curl -s *localhost*)`), desligar MCPs que não são usados no dia a dia, escolher uma memória (arquivo **ou** claude-mem). | Menos contexto fixo por sessão e nada se perde no Temp. |
