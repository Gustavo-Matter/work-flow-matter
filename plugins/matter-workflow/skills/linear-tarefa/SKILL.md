---
name: linear-tarefa
description: Use ao criar, atualizar status ou quebrar tarefas no Linear do time MatterAds, seguindo as diretrizes do time e o padrão de tarefa do Gustavo (tarefa central com planejamento, sub-issues, PR atrelado, In Progress, critério de pronto).
---

# linear-tarefa

Checklist para qualquer escrita no Linear do time MatterAds (`MAT`). Ele junta duas fontes:
- **Regras do time:** seção "Regras para agentes" de [DIRETRIZES.md](DIRETRIZES.md) (nesta pasta).
- **Padrão de tarefa do Gustavo:** a seção abaixo, que é convenção local e não faz parte da doc do time.

## Padrão de tarefa (convenção local)

Toda tarefa criada segue estes pontos:

1. **Título descritivo.** O título diz o resultado de forma que qualquer pessoa entenda sem abrir a tarefa (ex.: "Novas features do app Benção Diária: traduções, planos de leitura, …"), e não a atividade ("Trabalhar no app").
2. **PR atrelado.** Todo PR do trabalho é anexado à tarefa (`links` no `save_issue`). Se o PR ainda não existe, anexe assim que abrir. Cite a tarefa (`MAT-123`) no corpo do PR.
3. **Começa em In Progress.** A tarefa nasce quando o trabalho começa, então é criada já em **In Progress**.
   - Antes, conte o WIP da pessoa no projeto. Se já houver 2 em In Progress, não crie nesse status; pergunte qual ela conclui ou devolve.
   - A **tarefa central que tem sub-issues não entra na conta do WIP**, porque o trabalho real está nas sub-issues. Isso é decisão do Gustavo de 14/10/2026.
   - Exceção: sub-issues de trabalho futuro, que ninguém começou, ficam em **Backlog** até alguém puxá-las. A doc do time pede que o status reflita a realidade.
4. **Boa descrição**, no modelo abaixo. Contexto suficiente para outra pessoa assumir a tarefa.
5. **Sub-issues para tarefas secundárias.** Quando o trabalho tem partes, crie uma **tarefa central** e as partes como sub-issues (`parentId`). Cada sub-issue segue as mesmas regras: título, descrição, critério de pronto e labels. Dependências entre elas vão em `blockedBy`.
   - **Não vira sub-issue:** documentação de ADRs, planejamento e docs ligados ao plano. Esse trabalho é registrado na própria tarefa central, no planejamento geral. Sub-issue é para entrega de código, infra ou decisão de produto.
   - **Um PR por sub-issue:** cada sub-issue tem a sua branch e o seu PR, com código, testes e a doc daquela entrega, atrelado à sub-issue e citado na tarefa central. Substitui o antigo "um PR por plano", que gerava PRs de 200+ arquivos (ver `docs/workflow.md`, regra 1).
6. **Planejamento dentro da tarefa central.** A descrição da tarefa central contém o planejamento:
   - objetivo;
   - escopo e fora de escopo;
   - decisões, com links para ADRs e docs;
   - ordem das etapas, com as sub-issues e suas dependências;
   - riscos e pendências.

   Docs longos ficam no repositório e são linkados, mas o resumo do plano fica na tarefa.

Modelo de descrição:
```
## Contexto
Por que a tarefa existe e o que ela entrega.
## Planejamento            ← obrigatório na tarefa central; opcional nas sub-issues
- Objetivo / escopo / fora de escopo
- Decisões (links para ADRs/docs)
- Etapas: sub-issues em ordem, com dependências
- Riscos e pendências
## Critério de pronto
- [ ] ... (verificável)
- [ ] Todas as sub-issues concluídas ou canceladas   ← só na central
## Links
- PRs, docs, ADRs
```

## Checklist

1. Leia [DIRETRIZES.md](DIRETRIZES.md) (nesta pasta) se ainda não leu nesta sessão. Leia também a seção "Linear" do CLAUDE.md do repositório atual, que diz o projeto e a label de repositório.
2. Procure duplicata com `list_issues` (`query` + `team: MAT`). Se já existir uma tarefa aberta para o mesmo resultado, use-a. Se o trabalho novo for parte de algo que já tem tarefa central, crie como sub-issue dela.
3. Escolha um projeto existente. Se nenhum servir, é sustentação: sem projeto, com a label `Sustentação`. Se o trabalho pedir um projeto novo, pare e avise a pessoa de que isso precisa da autorização do Murilo.
4. Título descritivo, que diz o resultado. Se ele tem "e", provavelmente são duas tarefas. Avalie usar uma tarefa central com sub-issues.
5. Descrição no modelo acima. Na tarefa central, o planejamento é obrigatório.
6. Labels: exatamente uma de repositório (grupo "Projetos"), quando o trabalho mexe em código, e exatamente uma de tipo: `Bug` (exige evidência), `Feature`, `Improvement` ou `HotFix`. Use só labels que já existem (`list_issue_labels team: MAT`). Se a do repositório não existir, não crie; avise a pessoa para pedir ao Murilo.
7. Defina o responsável. Ele só é opcional em Backlog.
8. Se o trabalho não cabe em poucos dias, quebre em sub-issues, cada uma com resultado verificável.
9. Status inicial: In Progress para o trabalho que está começando agora, Backlog para sub-issues futuras (ponto 3 do padrão). Antes de pôr qualquer tarefa em In Progress ou In Review, conte as tarefas da pessoa naquele status no projeto. Os limites são 2 e 4. Se ela já estiver no limite, não mova; pergunte qual ela conclui ou devolve primeiro.
10. Ao abrir o PR, anexe-o à tarefa e também à central, se for o PR do plano.
    - **Quando o agente termina uma sub-issue**, ela vai para **Todo**, não para In Review. O Gustavo revisa e ele mesmo move para In Review (decisão de 14/10/2026). Registre a entrega na descrição: commits e o que foi feito.
11. Ao terminar:
    - marque Done só com o critério cumprido;
    - se sobrou trabalho, crie uma tarefa nova (sub-issue da central);
    - se o trabalho foi abandonado, marque Canceled e comente o motivo.

    A central só fecha quando todas as sub-issues estiverem concluídas ou canceladas.
12. Nunca:
    - apagar tarefa (cancele);
    - reaproveitar tarefa para outro assunto ou reabrir tarefa concluída (crie uma nova);
    - criar, renomear, unir, concluir ou cancelar projetos, nem criar ou alterar iniciativas (só o Murilo);
    - usar a label `Canary` à mão;
    - mexer em tarefa de outra pessoa sem pedido explícito;
    - misturar os times MatterAds e CHATFOOD;
    - escrever no Linear algo que não foi verificado.
13. Convenção local: antes de criar qualquer coisa, mostre a lista de tarefas propostas para a pessoa confirmar.
