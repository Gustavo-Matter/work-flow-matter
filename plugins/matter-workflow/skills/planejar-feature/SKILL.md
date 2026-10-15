---
name: planejar-feature
description: Use antes de começar uma feature ou um conjunto de mudanças que leva mais de um PR, em back ou front. Quebra o trabalho em sub-issues pequenas, cada uma com seu PR, e põe o plano na tarefa central do Linear.
---

# planejar-feature

O plano decide o tamanho dos PRs. Plano ruim gera PR de 200 arquivos e retrabalho.

## Passos

1. **Leia antes de propor.** CLAUDE.md do repo e só a doc do módulo/feature tocado. Não leia `docs/` inteira.
2. **Liste o que já está decidido e o que está em aberto.** Pergunta em aberto que muda o desenho vai para o usuário agora, não vira suposição.
3. **Quebre em sub-issues.** Cada uma:
   - entrega algo testável sozinha;
   - cabe num PR revisável (meta: até ~15 arquivos de código, fora gerados e migrations);
   - tem critério de pronto verificável ("`GET /x` devolve 404 no envelope quando…"), não "implementar X".
4. **Mudou back e front juntos?** A primeira sub-issue é o contrato (skill `contrato-api`). Código das duas pontas vem depois.
5. **Escreva o plano na descrição da tarefa central** (skill `linear-tarefa`): objetivo, sub-issues em ordem, decisões tomadas, perguntas abertas. Não crie `docs/planejamento-*.md` no repo.
6. **Decisão que vale ADR** (escolha com alternativa descartada que alguém vai querer rediscutir) entra como item da sub-issue onde ela é implementada, não como sub-issue própria.

## Não faça

- Uma branch e um PR para o plano inteiro.
- Sub-issue de "documentação": a doc vai no PR do código que ela descreve.
- Planejar fases que ninguém pediu "para seguir o padrão".
