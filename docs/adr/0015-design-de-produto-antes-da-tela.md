# 0015 — Design de produto passa pela skill design-app antes do Figma e do código

**Status:** Aceita · 19/11/2026

## Contexto

O ciclo ia de `planejar-feature` direto para o Figma e para a `feature-front`. Os checklists cobram fidelidade ao frame (ADR-0013) e os quatro estados da tela assíncrona, mas nada cobrava **decisão de produto** antes do frame existir:
- onboarding curto ou longo, e por quê;
- o que o app aprende do usuário;
- o que traz o usuário de volta;
- como o pior momento é tratado.

Com IA, qualquer equipe gera telas "bonitas" em um dia. O que diferencia vira o que ninguém desenha por padrão: estados, coesão, recuperação, valor acumulado. O Creduno (app de cartões, primeiro produto novo depois disso) precisou dessas respostas antes da primeira tela.

## Decisão

1. Etapa nova no ciclo, **1b. design**, com a skill `design-app`: depois do plano e antes do Figma e da `feature-front`.
2. A skill aplica quatro lentes, tiradas de quatro vídeos do Tim Gabe:
   - onboarding curto por padrão, longo só quando personaliza ou filtra;
   - estados, coesão e recuperação de falha;
   - valor acumulado visível;
   - relógio real.
   Ela entrega o design e um checklist de seis linhas no `docs/features/<x>.md`.
3. Guardrails fixos: sem urgência falsa nem dark pattern; anúncio rotulado e fora de ranking.
4. A `feature-front` não começa tela nova sem o checklist da `design-app` no doc da feature.

## Alternativas descartadas

- **Deixar para o designer ou para o Figma:** a Matter não tem designer dedicado em todo projeto, e o Figma registra o resultado, não as perguntas. Sem a skill, cada projeto redescobre (ou esquece) as mesmas lentes.
- **Pôr as lentes no checklist da `feature-front`:** chega tarde. Quando a tela está sendo codada, onboarding e retenção já foram decididos sem querer.
- **Skill de terceiros de UX:** não tem as travas de anúncio e de produto financeiro que a Matter precisa, e cairia no critério do ADR-0008 sem problema medido que justifique.

## Consequências

- Todo app ou fluxo novo ganha uma etapa de design com saída verificável (o checklist). Ajuste pequeno numa tela existente não passa por ela.
- O `revisor` pode cobrar a presença do checklist em PR que cria tela nova.
- As lentes vêm de uma fonte só (um canal). Se alguma se mostrar errada em produto real, ela é revista por novo ADR.
