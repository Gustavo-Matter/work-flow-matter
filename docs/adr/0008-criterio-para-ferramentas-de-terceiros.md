# 0008 — Critério para plugins, skills e MCPs de terceiros

**Status:** Aceita · 15/10/2026

## Contexto

O catálogo tem dezenas de plugins "para economizar token". Muitos instalam hooks ou status line que rodam código a cada ferramenta usada, e os ganhos anunciados não têm benchmark. Cada servidor MCP e cada skill também somam ao contexto de toda sessão.

## Decisão

Uma ferramenta de terceiros só entra no workflow se:
- resolve um problema que o [diagnóstico](../diagnosticos/) mediu (retrabalho, navegação cara, fidelidade ao Figma);
- é oficial ou tem autor identificável, e quem a instala **leu os hooks** que ela traz;
- custa pouco contexto fixo: skill sob demanda e MCP de poucas ferramentas;
- não duplica uma skill nossa.

A lista aprovada e a recusada, com o motivo, fica em [ferramentas.md](../ferramentas.md). Mudança na lista é PR aqui.

## Alternativas descartadas

- **Instalar tudo que promete economizar token:** hooks com acesso amplo, sem medição, e mais contexto fixo.
- **Não usar nada de terceiros:** perde o Dart MCP e o LSP, que são oficiais e dão navegação por símbolo em vez de grep.

## Consequências

- Ferramenta nova passa por este critério antes de entrar em `ferramentas.md`.
- Ferramenta que ninguém usou em um mês sai da lista.
