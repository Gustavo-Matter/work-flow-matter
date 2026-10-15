# Handoff — continuar no Mac

Sessão de 15/10/2026 no Windows (`C:\Matter`), com o Gustavo. Este arquivo passa o contexto para o Claude Code do Mac. Leia inteiro antes de agir; depois leia `CLAUDE.md`, `docs/workflow.md` e `docs/modelos.md` deste repo.

## Objetivo

Reduzir tokens gastos e retrabalho com IA nos projetos da Matter, sem perder qualidade: menos `fix(review)`, menos doc duplicada, padrões de código e de design respeitados. Este repo (`Gustavo-Matter/work-flow-matter`) é o workflow da equipe; mudança de processo se faz aqui e chega aos projetos por plugin.

## O que foi feito

1. **Diagnóstico** de 4 repos (`docs/diagnosticos/2026-10-15-*.md`): doc em leque (7–8 arquivos por feature), `feat` seguido de `fix(review)`, PR de 214 arquivos, CLAUDE.md desatualizado, handoff back↔front duplicado, Figma em várias rodadas de `fix`.
2. **Regras e porquês:** `docs/workflow.md` (13 regras) e ADRs 0001–0010.
3. **Marketplace `matter` com 3 plugins:**
   - `matter-workflow` 0.5.3 (core): skills `orquestrar`, `planejar-feature`, `contrato-api`, `feature-back`, `feature-front`, `padroes-codigo`, `registrar-decisao`, `pronto`, `linear-tarefa`, `iniciar-repo`, `diagnosticar-workflow`; agentes `revisor`, `linear-haiku`, `docs-haiku`.
   - `matter-flutter` 0.1.0: Dart MCP + LSP do Dart via `fvm`.
   - `matter-dotnet` 0.1.0: LSP de C# (`csharp-ls`).
4. **Orquestração (ADR-0010):** Opus planeja, escreve o brief, escolhe o executor e revisa todo diff. **O modelo gratuito é sempre a primeira escolha** (OpenCode + OpenRouter); Haiku e depois Sonnet só com motivo registrado na sub-issue. Linear fica no Haiku porque o OpenCode não tem o Linear.
5. **CLAUDE.md global enxuto** (modelo em `templates/CLAUDE.global.md`): papel, tabela "ao receber um pedido", regras sempre válidas. Comentário no código: no máximo 1 a 2 linhas.
6. **Ferramentas de terceiros:** aprovadas e recusadas em `docs/ferramentas.md` (ADR-0008).

## Decisões do Gustavo que valem

- Um PR por sub-issue (substituiu "um PR por plano").
- Ficar no limite gratuito da OpenRouter (**50 requisições/dia**) por enquanto; vai comprar os US$ 10 (1.000/dia) depois.
- Chave da OpenRouter só no `.env` (nunca versionado); só o `.env.example` vai para o git.
- Rollout nos 4 projetos: **um PR por projeto, só quando o workflow for dado como fechado** (plano em `docs/adocao.md`).
- Plugins do catálogo (Very Good AI Flutter, Token Inspector, AI Ready Design System) não entram nos nossos plugins; cada pessoa instala pelo catálogo.

## Configurar o Mac

1. **SSH:** a org MatterAds só aceita a chave da conta `Gustavo-Matter`. No `~/.ssh/config` do Mac:
   ```
   Host github-matterads
       HostName github.com
       User git
       IdentityFile ~/.ssh/<chave da conta Gustavo-Matter>
       IdentitiesOnly yes
   ```
   Clone sempre por `git@github-matterads:<org>/<repo>.git`.
2. **Repos:** clone em `~/Matter` (sugestão):
   - `git@github-matterads:Gustavo-Matter/work-flow-matter.git` → `~/Matter/ambiente-ia`
   - `MatterAds/muma-fit-api` → `~/Matter/muma-fit` (API .NET 10)
   - `MatterAds/muma-fit` → `~/Matter/muma-fit-app` (Flutter)
   - `MatterAds/bencaodiaria-app-api` (API .NET 8) e `MatterAds/bencaodiaria-app-mobile` (Flutter)
3. **`.env`:** `cp .env.example .env` na raiz deste repo e preencha `OPENROUTER_API_KEY`. A chave **não** está em nenhum arquivo do git: o Gustavo passa por canal seguro, ou gera outra em openrouter.ai/settings/keys (recomendado, porque a atual passou em texto pela conversa).
4. **OpenCode:** instalar no Mac e testar com a skill `orquestrar` (teste de fumaça). Funcionou no Windows com `openrouter/poolside/laguna-s-2.1:free`.
5. **Plugins:** num terminal `claude`: `/plugin marketplace add ~/Matter/ambiente-ia`, depois `/plugin install matter-workflow@matter` (e `matter-flutter` / `matter-dotnet` conforme o projeto).
6. **CLAUDE.md global:** copiar `templates/CLAUDE.global.md` para `~/.claude/CLAUDE.md`.
7. **`gh`:** logar com a conta `Gustavo-Matter` (`gh auth login`). No Windows o `gh` ficou preso na conta pessoal `Gustavo-N5`, que não enxerga a MatterAds, e por isso nenhum PR foi aberto por ele.

### Primeira tarefa no Mac: tirar os caminhos do Windows

O workflow cita caminhos e comandos do Windows: `C:\Matter\ambiente-ia`, `C:\Matter\.worktrees\`, e o bloco PowerShell da skill `orquestrar` (leitura do `.env` e `opencode run`). Arquivos a ajustar: `templates/CLAUDE.global.md`, `plugins/matter-workflow/skills/orquestrar/SKILL.md`, `iniciar-repo`, `diagnosticar-workflow`, `docs/modelos.md`, `docs/workflow.md`, `CLAUDE.md`, `README.md`. Proposta: raiz configurável (ex.: variável `MATTER_HOME`, padrão `~/Matter` no Mac e `C:\Matter` no Windows) e o comando do OpenCode em bash e em PowerShell. Faça num PR deste repo, subindo a versão e registrando no `CHANGELOG.md`.

## Pendências

| # | Pendência | Onde |
|---|---|---|
| 1 | **6 PRs por abrir** (branches já no remoto, gate verde) | muma-fit app: `docs/mat-claude-md-indice` → `chore/mat-religa-ci` → `docs/mat-features-por-subfluxo` (empilhadas, nessa ordem). bencao mobile: `docs/claude-md-indice`, `docs/remove-linear-md`, `chore/pr-template` (todas contra `main`) |
| 2 | Decidir os itens que as sessões deixaram como nota: pedidos abertos de `docs/back/HANDOFF.md` (muma-fit app) e itens de `docs/melhorias/` (bencao mobile) viram sub-issues no Linear; nada foi criado no Linear | Linear (agente `linear-haiku`) |
| 3 | Higiene do bencao mobile, sem executar sem confirmação: branch padrão do GitHub é a `master` de 2023 (trocar para `main`), apagar `master`/`develop`, verificar se o `.env` versionado nelas tem segredo a trocar | GitHub |
| 4 | **Verificar os plugins `matter-flutter` e `matter-dotnet`:** os campos `lspServers` e `.mcp.json` foram escritos pela documentação e nunca exercitados. Passos em `docs/ferramentas.md` → "Verificação". `csharp-ls` precisa de `dotnet tool install -g csharp-ls` | Este repo |
| 5 | Adaptar caminhos para o Mac (acima) | Este repo |
| 6 | Rollout: um PR por projeto, quando o Gustavo der o workflow por fechado | 4 projetos |
| 7 | Exercitar o fluxo completo numa feature pequena real (planejar → orquestrar com gratuito → pronto → PR) e corrigir onde falhar | Um projeto |

## Contexto dos projetos

- **muma-fit-api:** .NET 10, PostgreSQL + EF Core, Identity + JWT. 40 ADRs. No Windows, Postgres local na porta 5433 (container `mumafit-db`); testes de integração usam Testcontainers e precisam de Docker.
- **muma-fit (app):** Flutter via FVM, Riverpod + go_router + fpdart + `matter_core`/`matter_design_system`; `make check` é o gate e não tinha CI (a branch `chore/mat-religa-ci` religa).
- **bencaodiaria-app-api:** .NET 8, MySQL/MariaDB + Dapper; deploy real é GitHub Actions → ECR → EC2 arm64 (o CLAUDE.md da `main` ainda diz Bitbucket/DigitalOcean).
- **bencaodiaria-app-mobile:** Flutter legado em Bloc/get_it (não migrar para Riverpod); CI no GitHub Actions; 557 testes passando no Flutter 3.47.6.

## Cuidados

- Nunca versione a chave da OpenRouter nem outro segredo.
- Segredo, `.env` e dado de usuário nunca vão para modelo gratuito.
- Ação remota ou irreversível (apagar branch, trocar branch padrão, criar no Linear) só com confirmação do Gustavo.
