---
name: design-app
description: Use ao desenhar ou revisar um app, um fluxo ou uma tela nova (onboarding, home, retenção, estados de erro) antes de ir para o Figma e para a feature-front. Aplica quatro lentes (onboarding, estados, valor acumulado e relógio) e entrega o design com um checklist preenchido.
---

# design-app

Tela bonita hoje sai de qualquer ferramenta, e por isso não diferencia mais. O que faz um app parecer premium e trazer o usuário de volta é **prova de cuidado**: estado pensado, falha bem tratada, um produto que aprende o usuário e que muda com o tempo. Esta skill vem **depois** do `planejar-feature` e **antes** do Figma e da `feature-front`.

Base: quatro vídeos do Tim Gabe (*The Psychology of Premium Apps*, *The New Way Apps Dominate in 2026*, *Why Irresistible Apps Are Designed This Way*, *How To Solve The App Onboarding Paradox*). O porquê está no ADR-0015.

## Antes de desenhar

1. Leia o plano (tarefa central no Linear) e o `docs/features/<x>.md`, se existir.
2. Escreva em uma frase **a ação principal** do produto (ex.: "achar o cartão certo") e **o pior momento** dele (ex.: "pedido de cartão negado", "pagamento recusado").
3. Liste as telas do fluxo. Para cada uma, aplique os passos abaixo.

## 1. Onboarding: curto por padrão

- Por padrão, o onboarding é **o mais curto possível**, e o valor aparece na primeira coisa que a pessoa já ia fazer. Cadastro, tour e permissão só quando forem indispensáveis, e no momento em que forem pedidos pelo uso.
- **Longo só se comprar uma destas duas coisas**, e isso fica escrito no doc:
  - uma **primeira experiência personalizada** que não existiria sem os dados;
  - um **filtro** de quem tem dor real (e vai converter).
- Se for longo: uma pergunta por tela, barra de progresso, e **prévia do resultado crescendo** a cada resposta. Assim cada pergunta parece trabalho para o usuário, não para o app.

## 2. Estados: toda tela responde três perguntas

Em cada passo, o usuário sabe: **o que acabou de acontecer**, **se dá para desfazer** e **o que fazer agora**. Desenhe, por tela:

- [ ] carregando (com o que está acontecendo, não só um spinner);
- [ ] vazio (com uma ação para sair dele, não "nada aqui");
- [ ] erro, com causa em linguagem simples e uma ação (tentar de novo, falar com suporte);
- [ ] sem internet no meio do fluxo, sem perder o que já foi feito;
- [ ] sucesso, com o próximo passo;
- [ ] desfazer, ou confirmação onde não dá para desfazer;
- [ ] limite atingido (cota, plano, sessão), com **contagem e data** de quando volta ("2 de 2 usadas · renova em 01/12").

Resposta vaga, do tipo "algo deu errado" ou "você usou todas", reprova.

## 3. Coesão: um padrão por situação

- Situação que se repete (limite, bloqueio, confirmação, erro de rede, anúncio) tem **um** componente e **um** texto, usado no app inteiro.
- Use o fluxo inteiro como usuário, por ~1 hora no protótipo ou no build, e anote cada ponto onde "parece outro app". Cada ponto vira ajuste ou componente do kit (`kit-flutter`).
- Navegação e posição de controles não mudam entre telas parecidas.

## 4. Recuperação: o pior momento é a vitrine

- Quebre de propósito: Wi-Fi desligado no meio do fluxo, pagamento recusado, lista vazia, serviço externo fora do ar, anúncio que não carrega.
- Desenhe esses estados com **o mesmo cuidado da tela de sucesso**. Uma falha bem atendida deixa o usuário tão satisfeito quanto se ela não tivesse acontecido, às vezes mais.
- O pior momento definido no "Antes de desenhar" ganha: o que aconteceu, o que fazer e um contato a um toque.

## 5. Valor acumulado: o app aprende o usuário

- Para cada ação principal, pergunte: **isso deixa o app melhor para esta pessoa, ou só melhor em geral?** Se for só em geral, é funcionalidade, não valor acumulado.
- O depósito acontece **sem esforço**: a preferência é aprendida do uso, não de um formulário.
- **Torne visível** o que o usuário já investiu (ex.: "seu perfil tem 4 cartões e 12 preferências", "recomendação ajustada 9 vezes").
- **Pergunta de saída:** se ele fosse para um concorrente hoje, o que teria que refazer do zero? "Nada" é sinal de que essa camada não existe ainda.

## 6. Relógio: algo muda sozinho

- A funcionalidade principal ganha **uma regra de tempo real**: algo que muda com o usuário olhando ou não. Pode ser seleção do dia ou da semana que renova, oferta com prazo, resumo periódico ou meta com data.
- Notificação **só lembra** que o relógio existe. Quem traz o usuário de volta é o relógio.
- **Trava ética, sem exceção:** o prazo tem que ser verdadeiro. Contagem regressiva falsa, "só hoje" que se repete ou escassez inventada reprova, e em produto financeiro ainda é risco de consumidor.

## Guardrails

- Nada de dark pattern: botão de recusa escondido, confirmshaming, cancelamento difícil.
- **Anúncio sempre rotulado** ("Publicidade"), visualmente separado do conteúdo e fora de ranking ou de lista numerada. Rewarded é opcional, com a recompensa dita antes e um "Voltar".
- Indicador próprio (score, nota, chance) diz que é estimativa do app.
- Acessibilidade: contraste AA, alvo de toque ≥ 44 pt, texto que aumenta sem quebrar a tela, reduce motion respeitado.

## Saída

1. **O design**:
   - fase de exploração: artifact do tipo **Design** no claude.ai (quickstart com intent `design`);
   - fase de execução: frame no **Figma**, que é o que a regra 9 exige na sub-issue.
   Toda tela do fluxo aparece com os estados do passo 2.
2. **Checklist preenchido** no `docs/features/<x>.md`, uma linha por lente:

```
Design (design-app)
- Onboarding: curto | longo porque <personaliza X / filtra Y>
- Estados: <telas> com carregando, vazio, erro, offline, sucesso, limite
- Coesão: padrões únicos para <limite, erro, anúncio…>
- Recuperação: pior momento = <…>; tratamento = <…>
- Valor acumulado: depósito = <…>; visível em <…>; pergunta de saída = <…>
- Relógio: <regra de tempo real> ; lembrete = <…>
```

3. Escolha com alternativa descartada (ex.: onboarding longo × curto, monetização que trava conteúdo) vai pela `registrar-decisao`.

Lente que não se aplica ao produto fica escrita como "não se aplica, porque…", nunca em branco.
