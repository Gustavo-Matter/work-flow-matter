> Origem: LINEAR_DIRETRIZES.md do time MatterAds, copiado em 2026-10-14.

# Diretrizes de uso do Linear — MatterAds

Este arquivo descreve como o time MatterAds organiza o trabalho no Linear. Vale para pessoas e para agentes de IA (Claude, Cursor, Codex e outros) que criam ou alteram coisas no Linear em nome de alguém do time.

Se você é um agente: leia tudo antes de qualquer escrita no Linear e siga as regras da seção "Regras para agentes". Em caso de dúvida, pergunte à pessoa que está operando você em vez de decidir sozinho.

## Objetivo

Qualquer pessoa deve conseguir abrir o Linear e entender o que está acontecendo. Toda regra abaixo existe para isso.

## Os três níveis

| Nível | Pergunta que responde | O que é |
|---|---|---|
| Iniciativa | Aonde a empresa quer chegar? | Objetivo estratégico. Agrupa projetos. |
| Projeto | O que vamos entregar? | Uma entrega com fim definido. Agrupa tarefas. |
| Tarefa (issue) | Qual é o próximo passo? | Um passo que uma pessoa termina em poucos dias. |

Fora dos três níveis fica a **sustentação**: tarefas do dia a dia, que não pertencem a projeto nenhum.

**Tudo tem começo, meio e fim.** O que não tem fim não é iniciativa, nem projeto, nem tarefa: é sustentação, ou ainda não está bem definido.

## Iniciativas

- Iniciativa é objetivo, não área. O teste: ela pode ser concluída e tem um dono?
- "Infra e AWS" é área e não serve. "Eficiência operacional de infraestrutura AWS" é objetivo e serve.
- Só o Murilo cria, renomeia ou encerra iniciativas.

Iniciativas existentes em outubro de 2026:

- Gestão de campanhas com I.A
- Criação de modelo de operação de campanhas
- Gerenciamento de recursos dos blogs por um painel unificado
- Sites performáticos e com menor utilização de recursos de infra
- Observabilidade e monitoramento dos ativos digitais da empresa
- Eficiência operacional de infraestrutura AWS

A lista muda com o tempo. Consulte o Linear para a lista atual.

## Projetos

- Projeto é entrega, não repositório. O nome diz o que será entregue ("Dashboard operacional"), nunca o nome do repositório ("agente-ceo").
- Todo projeto tem responsável (lead), uma iniciativa e um critério de fim: como saber que terminou.
- **Projeto novo só existe com autorização do Murilo.** Ninguém cria projeto por conta própria. Para propor um, leve a ele: o que será entregue, como saber que terminou e a qual iniciativa pertence. Ele cria o projeto.
- Projeto encerrado é marcado como Completed ou Canceled. Não se reaproveita projeto antigo para outra entrega.

## Tarefas

Uma boa tarefa:

- Cabe em poucos dias de trabalho.
- Tem um único responsável.
- Tem título que diz o resultado, não a atividade. "Cache do HTML no astro-headless" em vez de "Trabalhar no headless".
- Tem critério de pronto na descrição.
- Trata de uma coisa só. Se o título tem "e", provavelmente são duas tarefas.

Como quebrar: se o trabalho não cabe em poucos dias, divida em tarefas menores, cada uma com um resultado verificável. Exemplo: "Fazer o site headless" vira "Reescrever os componentes PHP para Astro", "Cache do HTML", "Fallback para o WordPress em caso de falha" e "Script de readiness para o segundo site".

### Uma tarefa, um resultado

- Não troque o título ou a descrição de uma tarefa antiga para usá-la em outro assunto.
- Não reabra uma tarefa concluída para um trabalho novo.
- Não mantenha uma tarefa aberta "porque sempre tem mais".
- Mudou o escopo: feche a antiga e abra outra.
- Trabalho novo ganha tarefa nova, com link para a anterior quando houver relação.

Tarefa reaproveitada faz o histórico mentir.

## Status

| Status | Significado |
|---|---|
| Backlog | Ideia ou pendência, sem compromisso de data. Pode ficar sem responsável. |
| Todo | Fila do que vem a seguir. Tem responsável. |
| In Progress | Alguém está trabalhando nisso agora. |
| In Review | Pronto, esperando alguém validar. |
| Done | Concluído conforme o critério de pronto. |
| Canceled | Não será feito. Cancelar também é um fim. |
| Duplicate | Duplicada de outra tarefa. |

- O status deve ser igual à realidade. Mude quando a realidade mudar.
- Tarefa em In Progress ou In Review sem movimento há mais de 30 dias é fechada na revisão mensal.
- Tarefa em Todo ou Backlog parada há mais de 30 dias pode ser cancelada na revisão mensal.
- Não se apaga tarefa: cancela-se.

## Limite de tarefas em andamento

Por pessoa, em cada projeto:

| Status | Limite |
|---|---|
| In Progress | 2 |
| In Review | 4 |
| Todo | sem limite |

Passou do limite: conclua ou devolva uma tarefa antes de puxar outra. O Linear não bloqueia; a conferência é feita na revisão semanal.

## Sustentação

Correção de falha, suporte, ajuste pontual, manutenção, dívida técnica, segurança e credenciais são sustentação.

- A tarefa fica no time MatterAds, **sem projeto**.
- Recebe a label `Sustentação`.
- Recebe a label do repositório, quando houver código.
- Tem responsável e status como qualquer tarefa.

Sustentação não entra em projeto. Se entrar, o projeto nunca termina.

## Labels

| Grupo | Labels | Regra |
|---|---|---|
| Repositório (no Linear, o grupo se chama "Projetos") | `AGENTE-CEO`, `INSIGHTS-API`, `MATTERADS-DATA`, `MATTERADS-LOGS`, `META-API`, `GAM-ETL`, `ACTIVEVIEW-API`, `ADZEP-API`, `AV-WORKERS`, `ADS-LIBRARY`, `DECISION-PANEL`, `MATTER-CANARY` | Toda tarefa que mexe em código marca o repositório. Uma por tarefa. |
| Tipo | `Bug`, `Feature`, `Improvement`, `HotFix` | Uma por tarefa. |
| Avulsas | `Sustentação`, `DevOps`, `Canary` | `Sustentação` para tarefa sem projeto. `Canary` é aplicada pelo monitor automático; não use à mão. |

Significado dos tipos:

- `Bug`: comportamento que diverge do esperado em código que já existe. Exige evidência (query, log, print, resposta de API).
- `Feature`: capacidade que não existe hoje.
- `Improvement`: melhoria em algo que já funciona.
- `HotFix`: correção urgente que furou o fluxo normal.

O projeto diz o que está sendo entregue. A label diz onde o código mora e que tipo de trabalho é. Se o repositório não tem label, peça ao Murilo para criar; não invente uma.

## Rotina

- **Todo dia:** atualizar o status quando ele muda e registrar bloqueios na própria tarefa.
- **Toda semana:** revisão do quadro por pessoa; quem passou do limite resolve antes de puxar outra tarefa.
- **Todo mês:** fechar o que está parado há 30 dias e revisar projetos e iniciativas.

## Regras para agentes

Você pode, sem pedir autorização:

- Ler qualquer coisa no time MatterAds.
- Criar tarefas dentro de um projeto que já existe, quando a pessoa que opera você pedir.
- Criar tarefas de sustentação (sem projeto, com a label `Sustentação`).
- Atualizar status, descrição e comentários das tarefas da pessoa que opera você.

Você não pode:

- Criar, renomear, unir, concluir ou cancelar **projetos**. Se o trabalho pedir um projeto novo, pare e diga à pessoa que isso precisa da autorização do Murilo.
- Criar ou alterar **iniciativas**.
- Criar labels novas.
- Reaproveitar uma tarefa existente para outro assunto, nem reabrir tarefa concluída para trabalho novo. Crie uma tarefa nova.
- Alterar status, responsável ou conteúdo de tarefas de outras pessoas, a menos que a pessoa que opera você peça explicitamente e tenha esse direito.
- Apagar tarefas. Cancele.
- Mexer no time CHATFOOD a partir de um pedido sobre o MatterAds, e vice-versa.

Ao criar uma tarefa, sempre:

1. Procure antes se já existe uma tarefa aberta para o mesmo resultado. Se existir, use-a e não crie duplicata.
2. Escolha o projeto certo entre os existentes. Se nenhum servir, crie como sustentação, sem projeto.
3. Escreva um título que diga o resultado.
4. Escreva na descrição o contexto e o critério de pronto.
5. Aplique a label de repositório e a label de tipo.
6. Defina o responsável. Em Backlog, o responsável é opcional.
7. Se o trabalho não cabe em poucos dias, quebre em mais de uma tarefa.

Antes de mover uma tarefa para In Progress:

1. Conte quantas tarefas a pessoa já tem em In Progress naquele projeto.
2. Se já forem 2, não mova. Avise a pessoa e pergunte qual ela conclui ou devolve primeiro.
3. O mesmo vale para In Review, com limite de 4.

Ao terminar um trabalho:

- Marque a tarefa como Done só se o critério de pronto foi cumprido.
- Se sobrou trabalho, crie uma tarefa nova para o restante e conclua a atual, em vez de deixá-la aberta.
- Se o trabalho foi abandonado, marque como Canceled e diga o motivo num comentário.

Não escreva no Linear informação que você não verificou. Se não sabe o estado real de uma tarefa, pergunte.
