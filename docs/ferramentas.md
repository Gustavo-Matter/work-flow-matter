# Ferramentas de terceiros

Plugins, skills e MCPs aprovados para o desenvolvimento de back e front. Critério em [ADR-0008](adr/0008-criterio-para-ferramentas-de-terceiros.md). Pesquisa de 15/10/2026.

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
| **Dart and Flutter MCP server** (oficial) | Front | Analisar, testar, ver a árvore de widgets do app rodando e hot reload | `.mcp.json` do repo ([modelo](../templates/front.mcp.json)); usa `fvm dart` para casar com o SDK do projeto |
| **LSP de C#** (`csharp-ls`, marketplace oficial) | Back | Navegação por símbolo em vez de grep | `/plugin install` no terminal; exige `csharp-ls` no PATH (`dotnet tool install -g csharp-ls`) |
| **LSP de Dart** (`dart-analyzer`, marketplace comunitário `boostvolt/claude-code-lsps`) | Front | O mesmo, para Flutter | `/plugin marketplace add boostvolt/claude-code-lsps`, depois instalar o `dart-analyzer`; exige o Dart SDK no PATH |
| **Very Good AI Flutter Plugin** | Front | Agente `flutter-reviewer`, loop `green-gate`, skills de Bloc e arquitetura em camadas | Card do app / `/plugin`. **Traz hooks (`PreToolUse`, `PostToolUse`, `SessionStart`) e dois MCPs: leia antes** |
| **Token Inspector** | Ambos | `mcp-audit`, `find-bloat`, `slim-instructions` | Card do app / `/plugin`. Só skills |
| **AI Ready Design System** | Design | Auditar o design system do Figma em 28 regras | Card do app / `/plugin`. Só skill; uso pontual |

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
