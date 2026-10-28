# 0013 — Tela é conferida contra o Figma por screenshot e entra com micro-animações

**Status:** Aceita · 28/10/2026

## Contexto

As oito telas do fluxo de Configurações e Perfil do muma-fit (MAT-1701) passaram pelo `pronto` e foram para Done, mas divergiam do Figma. Os problemas apareceram no app inteiro:
- rótulo e subtítulo em verde-água em vez do cinza de legenda;
- título centralizado onde o frame alinha à esquerda;
- valor solto no meio da linha, e não encostado no chevron;
- pontos de canto no recorte da foto, que o frame não tem;
- seção (GRUPOS) que o frame não tem.

O link do Figma estava na sub-issue (regra 9). O que faltou foram três coisas:
- **O executor mais barato recebeu o link, não a spec.** Ele lê o frame mal, ou nem lê, e completa com o que o kit já faz.
- **O `revisor` compara código com código.** Ele não vê a tela, então "tela diferente do frame" passa despercebido.
- **Nada pedia movimento.** As telas saíram estáticas, enquanto o produto quer sensação premium e o muma já tem as peças (`MumaEntrance`, decisão 028 do app).

As tarefas reabertas para corrigir isso esbarraram ainda na regra local "nunca reabrir tarefa concluída". A regra do time é mais estreita: proíbe reabrir **para trabalho novo**.

## Decisão

1. **O brief de tela leva a spec do frame.**
   - O Opus lê o frame com `figma:figma-design-to-code` e escreve no brief uma tabela com cada peça visual (cor por token, tamanho, espaçamento, raio, sombra, tipografia, alinhamento), os textos exatos e os node-ids.
   - Executor sem essa tabela não começa.
   - Se o brief passar de ~6 blocos de tela ou de uma página, vira mais de uma sub-issue, com executores em paralelo.
2. **A revisão de tela compara imagem com imagem.**
   - Antes do commit, o Opus (no `pronto`) captura a tela rodando no simulador e o frame com `get_screenshot`, e confere os dois lado a lado contra a tabela da spec.
   - Divergência reprova e volta ao executor.
   - O `revisor` continua com a revisão de código e passa a cobrar que a comparação foi feita.
3. **Tela entra com micro-animações**, que são item do checklist do `feature-front`:
   - entrada escalonada das seções;
   - feedback de toque;
   - transição de estado e de valor;
   - Hero onde há continuidade entre telas;
   - tudo desligado com reduce motion.
4. **Tarefa cuja entrega não cumpriu o próprio critério é reaberta**, não duplicada. Ela recebe uma seção datada na descrição com o brief do ajuste. Trabalho novo continua sendo tarefa nova, como pede a regra do time.

## Alternativas descartadas

- **Só reforçar o item "fidelidade ao Figma" no checklist:** o item já existia e não segurou. Sem a imagem, quem revisa não vê a diferença.
- **Deixar o executor ler o Figma sozinho:** os modelos gratuitos leem o frame de forma incompleta e gastam o limite diário nisso. A leitura é feita uma vez pelo Opus.
- **Teste de golden (screenshot automatizado):** pega regressão, mas não compara com o Figma e quebra a cada ajuste de design. Pode entrar depois, como complemento.
- **Criar tarefa nova para o ajuste:** separa a correção da entrega que ela corrige e infla o board com duplicatas.

## Consequências

- O brief de tela fica mais longo, e o Opus gasta mais na leitura do Figma. Em troca, o executor deixa de errar a spec.
- O `pronto` de tela passa a exigir simulador (ou emulador) rodando. Sem ele, o relato final diz que a fidelidade não foi verificada.
- `feature-front`, `orquestrar`, `pronto`, `revisor` e `linear-tarefa` mudam juntas nesta versão do plugin.
