---
name: contrato-api
description: Use quando uma mudança precisa do back e do front juntos, ou quando o app precisa de algo que a API ainda não tem. Define o contrato da rota antes do código e substitui os handoffs em Markdown entre os repositórios.
---

# contrato-api

O contrato tem **um** dono: o repositório do back. O app linka, não copia.

## Do lado do app (pedido)

1. Confira no contrato do back (`docs/api/<modulo>.md`) que a rota ou o campo realmente não existe.
2. Abra uma sub-issue no Linear (skill `linear-tarefa`) no projeto do back, com:
   - o que a tela precisa (campo, filtro, ação) e por quê;
   - exemplo do JSON esperado, só os campos novos;
   - se bloqueia o app ou se o app já trata a ausência.
3. Não crie `docs/back/*.md` nem `HANDOFF.md`. O estado do pedido é o status da sub-issue.

## Do lado do back (contrato)

1. Escreva o contrato em `docs/api/<modulo>.md` **antes** do código: método, rota, request, response no envelope, códigos de erro, paginação.
2. Mudança que quebra o app existente: rota nova ou versão nova; nunca mude o formato de uma rota em uso.
3. Abra o PR do contrato (ou o primeiro PR da sub-issue com o contrato dentro) e linke na sub-issue.
4. Na entrega: uma linha no `CHANGELOG.md` com a versão. Sem handoff com Dart.

## Do lado do app (consumo)

`docs/features/<feature>.md` aponta para o contrato e descreve só o que é do app: estado, cache, tratamento de erro, tela.
