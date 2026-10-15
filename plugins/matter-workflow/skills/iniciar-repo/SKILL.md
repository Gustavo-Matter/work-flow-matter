---
name: iniciar-repo
description: Use ao criar um repositório novo da Matter (API .NET ou app Flutter) ou ao alinhar um existente ao workflow — CLAUDE.md como índice, template de PR, esqueleto de docs, gate/CI, seção do Linear e higiene de branches.
---

# iniciar-repo

Deixa o repo pronto para o Claude trabalhar com pouco contexto e sem adivinhar. Os modelos estão no repositório work-flow-matter (`C:\Matter\ambiente-ia\templates\`).

## Repo existente: meça primeiro

Rode a skill `diagnosticar-workflow` e só depois mude. Não reescreva doc que está correta.

## Passos

1. **CLAUDE.md** a partir de `CLAUDE.back.md` ou `CLAUDE.front.md`, até ~2 KB: stack, comandos, gate, deploy, armadilhas e seção Linear. Confira cada afirmação no código (deploy, banco, fase do produto). Arquitetura detalhada vai para `docs/architecture.md`.
2. **Template de PR:** `.github/pull_request_template.md` a partir de `pull_request_template.md`.
3. **Esqueleto de `docs/`**, só com o que já tem conteúdo:

   | Back | Front |
   |---|---|
   | `README.md` (índice "quero… → leia") | `README.md` (índice) |
   | `architecture.md`, `conventions.md` | `ARCHITECTURE.md`, `CONVENTIONS.md` |
   | `api/<modulo>.md` (contrato) | `features/<feature>.md` (link para o contrato) |
   | `adr/` com `_template.md` | `decisions/` com `_template.md` |
   | `CHANGELOG.md` na raiz | — |

   Não crie pasta vazia "para seguir o padrão".
4. **Ferramentas** (lista em `docs/ferramentas.md` do work-flow-matter):
   - `.claude/settings.json` do repo a partir de `templates/project-settings.json`, habilitando `matter-workflow` e mais `matter-flutter` (app Flutter) ou `matter-dotnet` (API .NET). Sem `.mcp.json` próprio: o Dart MCP vem do plugin (ADR-0009);
   - no CLAUDE.md, a linha "prefira o LSP a grep para achar definição e referência";
   - não instale nada fora da lista aprovada sem passar pelo critério do ADR-0008.
5. **Gate e CI:** o comando de gate (`dotnet build` + `dotnet test` ou `make check`) descrito no CLAUDE.md e rodando no GitHub Actions. App Flutter novo: copiar o CI do `matter-flutter-template`.
6. **Linear:** projeto e label de repositório na seção Linear do CLAUDE.md. Label inexistente: pedir ao Murilo (agente não cria label).
7. **Higiene** (relate e peça confirmação antes de executar o que é irreversível ou remoto):
   - branch padrão do GitHub = branch ativa;
   - branches já mergeadas e branches de processo (`docs/diretrizes-linear`) apagadas;
   - `.env` e segredos fora do git, inclusive no histórico de branches antigas;
   - remoto pelo alias SSH `github-matterads`;
   - worktrees em `C:\Matter\.worktrees\`;
   - `.claude/settings.local.json` com padrões de comando, não comandos únicos.
8. **Processo não entra no repo:** nada de `docs/linear.md` ou diretrizes copiadas; elas vêm do plugin.

## Saída

Um PR pequeno por passo que mudou algo, e a linha do repo atualizada em `docs/adocao.md` do work-flow-matter.
