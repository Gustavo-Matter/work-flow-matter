# Diagnóstico do Flutter e do ambiente Mac — 16/10/2026

Feito no Mac do Gustavo (`~/Documents/matter`), complementa o [diagnóstico dos apps de 15/10](2026-10-15-apps-flutter.md). Só leitura nos repos.

## O Flutter da Matter tem 4 repos, o workflow conhece 2

| Repo | Papel | O workflow cita? |
|---|---|---|
| `matter-mobile-kit` | `matter_core` (Dio, interceptors, `Failure`, token, ads, login social) e `matter_design_system` (tokens, tema, 33 componentes); bricks Mason `matterads_app` e `matterads_feature`; release-please por componente | Só o nome dos pacotes |
| `matter-flutter-template` | Base dos apps novos: Riverpod 3, go_router, fpdart, `make check`, `tool/check_architecture.dart` (8 regras), fakes à mão, `--dart-define-from-file` | Só o nome |
| `muma-fit` | Template + 3 regras (ARCH-04, ASYNC-01, MEDIA-01), 13 features, 59 decisões | Sim |
| `bencaodiaria-app-mobile` | Legado Bloc/get_it, l10n pt/en/es, tema escuro, Firebase push, ads, mocktail | Sim |

## Kit e template

- **Consumo por tag está suspenso na prática.** Tags só `core-v0.1.0` e `design_system-v0.2.0`; os PRs do release-please (core 0.2.0, DS 0.3.0) não foram mergeados. muma-fit e a branch do template fixam o kit por **SHA**. O `pubspec` do core já diz 0.2.0 e o manifest diz 0.1.0.
- **CI pausado** no kit (desde 02/09) e no template: falta o GitHub App com acesso ao kit privado (`MATTER_KIT_APP_*`). `make check` é o único gate em todo o Flutter novo.
- **Flutter divergente:** kit 3.47.1, template e muma 3.47.2, bencao 3.47.6.
- **Bricks já fazem o scaffold de feature** (camadas, fakes, testes, `docs/features/<x>.md` do DOC-01). A skill `feature-front` não os usa.
- **Sem Code Connect.** Figma só aparece como node id em comentário de alguns componentes.
- Mudança no kit tem regras próprias (`Release-As:` para aparência/token, `contrast_test`, componente só quando se repete em 2 apps, galeria + `DESIGN_SYSTEM.md` do template) que nenhuma skill cobre.
- 18 branches no kit, várias já mergeadas; `main` local 33 commits atrás.

## Defeitos que se repetem (últimos 80 commits)

| Tema | muma (38 fix) | bencao (29 fix, 16 `fix(review)`) |
|---|---|---|
| Fidelidade ao Figma (cor de CTA, posição de controle, CTA fixo × rolando, variante do kit) | 13 | 0 |
| Concorrência / ciclo de vida (toque duplo, retry, voltar no meio, emitir após `close`, `mounted`) | 8 | 6 |
| Contrato e sincronização (reler após salvar, PUT só se mudou, DTO tolerante, `toLocal`) | 7 | 4 |
| Mídia, permissão, plataforma (iCloud, temporários, `PrivacyInfo`, `targetSdk`, ATT × push) | 4 | 6 |
| Layout extremo e acessibilidade | 3 | 4 |
| l10n | — | 3 |

## Onde a skill `feature-front` erra

- Pede tema escuro: muma só tem claro. Não fala de l10n: bencao tem 3 idiomas.
- Pede `domain/data/providers/presentation`, design system e "componente com cache do kit": bencao não tem nada disso (página + cubit + state, `AppNetworkImage`).
- Pede `docs/features/`: bencao não tem a pasta nem decisões.
- Não cita mocktail proibido no muma/template (decisão 010) nem permitido no bencao.
- Não cobre push, ads (UMP/ATT), release para loja, mudança no kit.

## Lacunas de release

Nenhum app tem fastlane/codemagic nem Crashlytics. muma: release assina com a chave de debug, bundle id iOS (`com.matterads.mumaFit`) ≠ Android (`com.matterads.muma_fit`), nunca publicado. bencao: release manual pelo README, `.env` empacotado como asset (público no binário), CI só dispara push em `master`.

## Ambiente Mac

| Item | Estado |
|---|---|
| OpenCode | **Não estava instalado.** Instalado v2.0.31 (`npm i -g @opencode/cli`; o `brew install anomalyco/tap/opencode-v2` falha pelo Xcode, abaixo). O comando da skill `orquestrar` (`--standalone --auto --model … -f brief.md`) passou na fumaça com `poolside/laguna-s-2.1:free` em ~34 s |
| Versão do OpenCode | A skill exige a **v2**: o pacote antigo `opencode-ai` (1.x) não tem `--standalone`. O workflow não diz qual instalar |
| Xcode 26.5 | `xcodebuild -sdk … -find clang` dá *Bus error* (fora do sandbox também): o brew não compila e o Dart MCP não sobe. Corrige com Xcode 26.6 ou `sudo xcode-select -s /Library/Developer/CommandLineTools` |
| `--auto` no OpenCode | Aprova leitura de qualquer arquivo, inclusive `.env` do worktree: contradiz "segredo nunca vai para modelo gratuito" |
| Dart MCP (`fvm dart mcp-server`) | **Conecta** pelo plugin `matter-flutter` (`claude mcp list` no muma). Recompila o servidor a cada início |
| Plugins | Marketplace `matter` não estava registrado. Instalados: `matter-workflow` (user) e `matter-flutter` (local, em muma_fit e bencaodiaria-app-mobile; no escopo user o MCP subiria em todo projeto, ADR-0009) |
| Chave no OpenCode v2 | `opencode auth login openrouter` só aceita a chave em terminal interativo |
| `csharp-ls`, Docker | Ausentes. Repos .NET não clonados no Mac |
| Alias SSH | Mac usa `github-work`; o workflow manda `github-matterads` |
| Pasta dos repos | `~/Documents/matter/`; o work-flow-matter está em `work-flow-matter/`, não `ambiente-ia/` |
| `~/.claude/CLAUDE.md` | Não é o modelo do workflow (só graphify) |
| Skills globais | ~80 skills GSD + graphify + claude-mem: sobrepõem `planejar-feature`/`code-review` e somam contexto fixo (ADR-0008) |

## Erros no diagnóstico de 15/10

Pedidos ao back: 13 + `HANDOFF.md` (não 14). Decisões do muma: 59 (sem a 039). CI do bencao roda em PR, mas push só em `master`.
