# Diagnóstico dos apps Flutter — 15/10/2026

`muma-fit` (pasta local `C:\Matter\muma-fit-app`) e `bencaodiaria-app-mobile`.

| | muma-fit (app) | bencaodiaria-app-mobile |
|---|---|---|
| Arquitetura | Riverpod + codegen, go_router, `fpdart`, `matter_core`/`matter_design_system` | Cubit/Bloc + get_it, rotas nomeadas, `AppFailure`, mocktail |
| Branch ativa | `main` (338 commits, 46 merges) | `main` (163 commits); `master` (padrão do GitHub) e `develop` paradas desde 2024 |
| Gate | `make check` + `tool/check_architecture.dart` (11 regras). **Sem CI** | CI no GitHub Actions (format, analyze, test, build apk e ios) |
| `CLAUDE.md` | ~8 KB, bom índice, mas desatualizado sobre a fase do produto | ~11,6 KB, em inglês, repete a arquitetura inteira |
| Docs | ~1 MB: 60 decisões, `features/groups.md` 86 KB, `stories.md` 38 KB, `day.md` 35 KB, `docs/back/` com 14 pedidos + `HANDOFF.md` | `docs/melhorias/` (auditoria de ~120 KB) + `docs/linear.md` |
| Commits | 110 `feat`, **84 `fix`**, 52 `docs` | 39 `feat`, **64 `fix`**, 13 `chore` |

## Problemas

1. **Figma em várias rodadas.** Nos stories do muma-fit, um `feat` puxou oito `fix` seguidos ("fiel ao Figma", "cabeçalho como no Figma", "galeria relê a permissão"…). A tela é codada sem o frame exato e sem os estados de borda.
2. **Retrabalho de revisão.** No bencao mobile, itens da auditoria voltam como `fix(review): …` (P6, P7, U8, U10, S4).
3. **Handoff duplicado.** O app escreve `docs/back/*.md` e `HANDOFF.md`; a API escreve `docs/flutter/handoff-*.md`. O mesmo payload nos dois repos.
4. **CLAUDE.md desatualizado no muma-fit app.** Diz "nada de domínio foi escrito", mas o app já tem refeições, água, treino, grupos, stories, metas e saúde.
5. **Doc de feature gigante.** `groups.md` com 86 KB; a regra `DOC-01` obriga o arquivo a existir, mas não limita o tamanho.
6. **Decisões que não são decisão.** Parte das 60 do muma-fit é detalhe de tela ("CTA do formulário no fim", "cartão do desafio leva ao feed").
7. **Dois padrões de arquitetura** sem skill por stack: a IA redescobre o padrão a cada sessão.
8. **Higiene:** branch `docs/mat-1508-diretrizes-linear` nos dois apps; branch padrão do bencao mobile é a `master` de 2023; `.env` versionado em `master`/`develop`.

Correções: ADRs [0003](../adr/0003-fonte-unica-de-doc.md), [0004](../adr/0004-contrato-back-front.md), [0006](../adr/0006-revisao-antes-do-commit.md) e [0007](../adr/0007-criterio-de-adr.md); skills `feature-front`, `registrar-decisao` e `iniciar-repo`.
