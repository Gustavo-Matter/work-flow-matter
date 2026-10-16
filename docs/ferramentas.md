# Ferramentas de terceiros

Plugins, skills e MCPs aprovados para o desenvolvimento de back e front. Critério em [ADR-0008](adr/0008-criterio-para-ferramentas-de-terceiros.md). Pesquisa de 15/10/2026.

## Como as ferramentas chegam aos projetos

[ADR-0009](adr/0009-ferramentas-de-stack-em-plugins-separados.md): três plugins no marketplace `matter`, e cada repo habilita o que usa no seu `.claude/settings.json` (modelo: [templates/project-settings.json](../templates/project-settings.json)).

| Plugin nosso | Entrega | Habilitar em |
|---|---|---|
| `matter-workflow` | Skills, agente `revisor`, diretrizes do Linear | Todos os repos |
| `matter-flutter` | Dart MCP + LSP do Dart, via `fvm` | Apps Flutter, no escopo **local** (`--scope local`); no escopo user o MCP sobe em todo projeto |
| `matter-dotnet` | LSP de C# (`csharp-ls`) | APIs .NET |

Requisitos na máquina: `fvm` com o SDK do projeto (Flutter) e `dotnet tool install -g csharp-ls` (.NET).

### Verificação depois de instalar

16/10/2026, Mac: `matter-flutter` instalado no muma-fit, `claude mcp list` mostra `plugin:matter-flutter:dart ✔ Connected`. Falta conferir o LSP do Dart e o `matter-dotnet`. Confirme num app Flutter e numa API .NET:
1. `/plugin` lista `matter-workflow`, `matter-flutter` ou `matter-dotnet` como habilitados e sem erro.
2. `/mcp` mostra o servidor `dart` conectado (só no app Flutter).
3. Peça "onde é usado o símbolo X" e confira nas ferramentas que o LSP respondeu em vez de grep.
4. Falhou: ajuste o `plugin.json` aqui, suba a versão e registre no CHANGELOG.

## Já instalados

| Ferramenta | Uso |
|---|---|
| `figma` (plugin + MCP) | Ler frame, tokens e Code Connect: `figma-design-to-code`, `figma-code-connect`, `get_variable_defs` |
| `design` (plugin) | Crítica de design, handoff, acessibilidade |
| `claude-mem` (plugin) | Memória entre sessões |
| `matter-workflow` (este repo) | O workflow |

## Aprovados

| Ferramenta | Stack | Para quê | Como instalar |
|---|---|---|---|
| **Dart and Flutter MCP server** (oficial) | Front | Analisar, testar, ver a árvore de widgets do app rodando e hot reload | Plugin `matter-flutter` (usa `fvm dart` para casar com o SDK do projeto) |
| **LSP de C#** (`csharp-ls`) | Back | Navegação por símbolo em vez de grep | Plugin `matter-dotnet`; exige `csharp-ls` no PATH (`dotnet tool install -g csharp-ls`) |
| **LSP de Dart** (`dart language-server`, do SDK) | Front | O mesmo, para Flutter | Plugin `matter-flutter` |
| **Very Good AI Flutter Plugin** | Front | Agente `flutter-reviewer`, loop `green-gate`, skills de Bloc e arquitetura em camadas | Catálogo do claude.ai, por pessoa. **Traz hooks (`PreToolUse`, `PostToolUse`, `SessionStart`) e dois MCPs (um deles `dart`, que duplica o do `matter-flutter`): leia antes** |
| **Token Inspector** | Ambos | `mcp-audit`, `find-bloat`, `slim-instructions` | Catálogo do claude.ai, por pessoa. Só skills |
| **AI Ready Design System** | Design | Auditar o design system do Figma em 28 regras | Catálogo do claude.ai, por pessoa. Só skill; uso pontual |

Esses três não entram nos plugins da Matter (ADR-0009): têm autor e hooks próprios. Cada pessoa os instala pelo catálogo.

O LSP só ajuda se o Claude o usar: quando instalar, acrescente ao CLAUDE.md do repo "prefira o LSP a grep para achar definição e referência".

### Figma sem plugin novo

O plugin `figma` já cobre. O que falta é configurar:
1. **Code Connect** mapeando os componentes do Figma para os widgets do `matter_design_system`, para o `get_design_context` devolver o widget real.
2. `create_design_system_rules` para gerar o arquivo de regras de tokens do repo.
3. Link com node na sub-issue e leitura pela skill `figma-design-to-code` antes de codar (regra 9 do workflow).

## Recusados

| Ferramenta | Motivo |
|---|---|
| Token Shield, ContextStellar, ClaudeTokenSAP | Hooks em toda ferramenta usada, sem benchmark; o ganho maior já veio de CLAUDE.md enxuto, docs quebrados e skills sob demanda |
| Token Weather, Context Bar, Token Status Line | Status line com acesso amplo; conveniência, não resolve problema medido |
| Flutter Skills (Riverpod 3.x) | Só serve ao muma-fit e sobrepõe a `feature-front` |
| Code Review comunitário | Já temos o agente `revisor` e a skill `code-review` nativa |
| Mobile Design System, Claude2Figma | Projeto novo, ou para quem desenha no Figma |
| Kobiton | Teste em dispositivo real; fora do escopo |
| Canva e HubSpot (MCP) | Não ajudam em back nem em front; desligar se não forem usados |

## Revisão

A cada mês, `Token Inspector → mcp-audit` e a lista acima: o que ninguém usou sai.
