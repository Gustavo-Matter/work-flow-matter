# 0007 — ADR só para decisão com alternativa descartada

**Status:** Aceita · 15/10/2026

## Contexto

Os quatro repos usam ADR, e isso funciona: evita rediscutir escolhas. Mas não há critério. O muma-fit app tem 60 decisões, parte delas detalhe de tela ("CTA do formulário no fim"); o muma-fit-api tem ADR de 22 KB com payload copiado.

## Decisão

Mantemos ADR, com a skill `registrar-decisao`:
- vira ADR quando existe alternativa razoável descartada que alguém vai querer rediscutir, ou quando quebra uma suposição que a IA faria lendo o código;
- detalhe de tela ou de implementação local vai para o doc da feature;
- formato fixo e curto (até ~5 KB), sem payload;
- decisão aceita não é reescrita: uma nova a substitui.

## Alternativas descartadas

- **Abandonar ADR:** perde o registro do porquê, que é o que mais economiza discussão.
- **ADR para toda mudança:** o estado atual do muma-fit app.

## Consequências

- Os ADRs existentes ficam; os que são detalhe de tela podem ser movidos para o doc da feature quando ela for tocada.
