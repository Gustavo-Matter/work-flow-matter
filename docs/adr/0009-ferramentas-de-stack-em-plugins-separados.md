# 0009 — Ferramentas de stack são plugins separados do core

**Status:** Aceita · 15/10/2026 · Estende o ADR-0005 e o ADR-0008

## Contexto

O Dart MCP e os language servers (Dart, C#) precisam estar disponíveis para o Claude em cada repo. Um MCP ligado no escopo do usuário sobe em todo projeto, inclusive nos que não são Flutter, e o `~/.claude/settings.json` não chega a outra pessoa da equipe. Ferramentas de terceiros do catálogo trazem hooks que não escrevemos.

## Decisão

- Dois plugins no marketplace `matter`, mantidos por nós: `matter-flutter` (Dart MCP e LSP do Dart, via `fvm`) e `matter-dotnet` (LSP de C#). Só configuração; nenhum hook e nenhum código de terceiros.
- O `matter-workflow` continua sendo o core (skills, agente, diretrizes), igual em qualquer stack.
- Cada repo habilita o que usa no próprio `.claude/settings.json` (modelo em `templates/project-settings.json`): `matter-workflow` em todos, `matter-flutter` nos apps, `matter-dotnet` nas APIs. Quem clonar o repo é convidado a instalar.
- Plugins do catálogo (Very Good AI Flutter, Token Inspector, AI Ready Design System) **não** entram nos nossos plugins: têm autor próprio e hooks. Ficam como recomendação em `ferramentas.md`, instalados por quem leu o que eles fazem.

## Alternativas descartadas

- **Tudo dentro do `matter-workflow`:** o MCP do Dart subiria em projetos .NET e o LSP de C# em apps Flutter, somando contexto à toa.
- **`.mcp.json` copiado em cada repo:** é N cópias, e muda a cada ajuste do comando.
- **Habilitar no escopo do usuário:** vale só para uma máquina e carrega em todo projeto.

## Consequências

- Os `.mcp.json` por repo deixam de ser necessários; a adoção é o `.claude/settings.json` do repo.
- O LSP exige o binário na máquina: `csharp-ls` (`dotnet tool install -g csharp-ls`) e o Dart SDK via FVM.
- Os campos `lspServers` e `.mcp.json` de plugin foram escritos pela documentação e **ainda não foram exercitados no Claude Code**. Os passos de verificação estão em `docs/ferramentas.md`.
