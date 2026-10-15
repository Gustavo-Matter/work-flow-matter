# Workflow atual com IA — diagnóstico

Levantamento de 15/10/2026 sobre os dois projetos em que o Claude Code mais trabalhou: `muma-fit` (API .NET 10) e `bencaodiaria-app-api` (API .NET 8). Objetivo: entender como o trabalho com a IA acontece hoje e onde ele gasta tokens sem retorno.

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
