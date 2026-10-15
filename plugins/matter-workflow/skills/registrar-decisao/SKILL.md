---
name: registrar-decisao
description: Use quando uma escolha técnica ou de produto foi feita (ou está sendo revista) e pode precisar de ADR, em back (docs/adr/) ou front (docs/decisions/). Decide se vira ADR ou nota no doc da feature, e escreve no formato curto da Matter.
---

# registrar-decisao

ADR é o registro do **porquê**. Serve para ninguém (nem a IA) rediscutir a mesma escolha daqui a seis meses. Não é diário de implementação.

## 1. Vira ADR?

Vira ADR se **pelo menos uma** for verdade:
- havia alternativa razoável e ela foi descartada por um motivo que alguém vai questionar;
- a decisão quebra uma suposição que um agente faria lendo o código (ex.: "não há use cases", "streak é derivado, não persistido");
- muda contrato, segurança, dados do usuário, custo ou infraestrutura.

**Não** vira ADR (vai para `docs/features/<feature>.md` ou para o doc do módulo):
- posição de botão, cor, texto, ordem de seção, comportamento de uma tela só;
- detalhe de implementação que o código e o nome já explicam;
- payload de rota (vai no contrato, `docs/api/<modulo>.md`).

Na dúvida, pergunte ao usuário em uma linha antes de escrever.

## 2. Antes de escrever

1. Leia o índice (`docs/adr/README.md`, `docs/decisions/README.md` ou a tabela do `docs/README.md`) e os ADRs com tema próximo.
2. Contradiz uma decisão **Aceita**? Não edite a antiga: escreva uma nova que a substitui e mude só o status da antiga para "Substituída por NNNN".

## 3. Formato (até ~5 KB)

```
# NNNN — <decisão em uma frase>
**Status:** Aceita · <data> [· Estende/Substitui NNNN]
## Contexto        fatos e o que força a decisão
## Decisão         o que foi decidido
## Alternativas descartadas   cada uma com o porquê
## Consequências   o que muda, o que fica mais difícil
```

Sem payload, sem código além de uma linha ilustrativa, sem passo a passo de tela. Siga o idioma e a numeração do repo (`0041-...` no back, `061-...` no front do muma-fit).

## 4. No mesmo PR

- Linha nova no índice.
- O doc do módulo/feature **linka** o ADR em vez de repetir o raciocínio.
