---
name: aso-loja
description: Use ao criar ou revisar a ficha de um app na App Store ou no Google Play (nome, subtítulo, palavras-chave, descrições, capturas com legenda, ícone e destaque), ao cadastrar um app novo nos consoles ou ao mexer no ASO depois do lançamento. Entrega as fichas em docs/loja/ dentro dos limites de cada loja, as imagens e o checklist de publicação.
---

# aso-loja

ASO é o SEO das lojas. Esta skill fecha a ficha de um app antes do primeiro envio e orienta as trocas depois. Base: o vídeo *App Store Optimization: The Proven ASO Framework for 2026*, do App Masters (Steve P. Young), em https://youtu.be/ytAKZDh5eHU. O exemplo completo é o Creduno: `Creduno/docs/loja/`.

## O que pesa no ranking (do mais ao menos forte)

1. **Metadados.**
   - Apple: nome, subtítulo e campo de palavras-chave.
   - Google: título, descrição curta e descrição completa.
   - É o fator que mais pesa, e é onde esta skill atua.
2. **Volume e velocidade de downloads.** Pesam mais quando já existe canal pago ou rede social.
3. **Nota e avaliações.** Aumentam a conversão, que realimenta o ranking.
4. **Conversão da página.** Visualização → download. Melhora testando as capturas. Impressão → download quase não serve como sinal.
5. **Retenção e engajamento.** Pesam forte no Google e cada vez mais na Apple.
6. **Pesam pouco:** atualização frequente, instalações e backlinks. Backlink serve para o site, não para a loja.

## Processo

### 1. Termos

- Liste termos **relevantes** para o app, de cauda longa: ex. "cartão sem anuidade", não "cartão".
- Escolha **6 a 10** com pouca concorrência. Use uma ferramenta de ASO para ver a nota de busca e a complexidade; na falta dela, use a busca da própria loja e o autocompletar.
- Sem canal pago, fique com a cauda longa. Se depois de algumas semanas nada subir, troque para o **jogo da quantidade**: muitos termos de tráfego baixo (nota de busca ~5), em que o app chega ao top 3.
- **Não use marca de concorrente.** Quem busca uma marca baixa a marca. Concorrente vai no Apple Ads, não no ASO.

### 2. Campos e limites

Conte os caracteres com `len()` sobre o texto exato. Anote a contagem na ficha ("27 de 30").

| Loja | Campo | Limite | Regra |
|---|---|---|---|
| Apple | Nome | 30 | Marca + o termo mais forte (`Creduno: Cartões de Crédito`) |
| Apple | Subtítulo | 30 | Termos, não slogan. "Ofertas, ranking e comparador" desperdiça o campo. |
| Apple | Palavras-chave | 100 | Vírgula sem espaço. Não repita o que já está no nome e no subtítulo, nem a sua marca, nem plural e singular do mesmo termo. |
| Apple | Texto promocional | 170 | Não indexa. Muda sem versão nova. |
| Google | Título | 30 | Marca + o termo mais forte |
| Google | Descrição curta | 80 | Abre com os termos principais |
| Google | Descrição completa | 4000 | Indexa. Repita cada termo principal 2 a 4 vezes, em texto natural e sem lista de palavras. |

- **Proibido nos textos:** "melhor", "nº 1", "#1", emoji, preço, "grátis" no título, promessa ("aprovado na hora") e nome de marca de terceiros.
- **App financeiro:** nada de "score" sem a negativa, nada de "crédito fácil" e nada de garantia de aprovação.

### 3. Localização extra (opcional, a validar)

- Cada loja da Apple indexa mais de uma localização. A dos EUA, por exemplo, indexa 9, incluindo es-MX.
- Preencher o nome e o subtítulo de uma localização extra dobra os termos indexados naquele país.
- **Antes de usar:**
  - confirme na tabela de localizações da Apple quais localizações o país-alvo indexa;
  - lembre que há relatos de que a análise da página por IA tirou força da tática.
- Registre na ficha se foi usada.

### 4. Imagens

- **Capturas com legenda curta** (até 40 caracteres), com o benefício principal na **primeira**. A pessoa decide antes de ler a descrição.
- **Tamanhos:**
  - Play: telefone 1080×1920 (a proporção máxima é 2:1, então uma captura de iPhone 6,9" sem moldura não serve), ícone 512×512 e destaque 1024×500;
  - Apple (nov/2026): o slot **obrigatório** é o iPhone de tela média, 6,1"/6,3" (1206×2622); 6,9" (1320×2868) virou opcional. Se o app declarar iPad (`TARGETED_DEVICE_FAMILY` com 2), iPad 13" 2064×2752 também é obrigatório.
- Gere por script (`docs/loja/gerar_imagens.py`, como no Creduno) a partir das capturas brutas em `docs/loja/raw/`. Assim a troca de tela ou de legenda é um comando só.
- **Captura limpa:**
  - status bar fixa (`xcrun simctl status_bar <udid> override --time 09:41 ...`);
  - anúncios desligados e faixa DEBUG desligada;
  - alça de janela do iPadOS apagada na montagem.

### 5. Depois de publicar ou trocar o ASO

- Dê um **empurrão de downloads** curto logo depois da troca (campanha, rede social, base própria), porque a velocidade conta.
- **Paciência:** não troque o subtítulo nem os termos antes de 2 a 4 semanas, ou não dá para saber o que funcionou.
- Acompanhe no App Store Connect e no Play Console: downloads por busca, visualização → download e ranking dos termos.
- ASO é uma fatia do marketing, não o todo. Com receita pequena, comece o pago pelo Apple Ads, que só precisa dos termos.

## Entregáveis em `docs/loja/`

- [ ] `ficha-app-store-pt-BR.md` e `ficha-google-play-pt-BR.md`, com cada campo e a contagem ("n de limite")
- [ ] `notas-para-revisao.md` (inglês para a loja, pt-BR para o dono), dizendo se há login, conta de teste e anúncios
- [ ] `privacidade-formularios.md` (Data Safety e App Privacy) e `classificacao-e-declaracoes.md`, com os itens a conferir marcados `CONFERIR`
- [ ] `raw/` com as capturas brutas e as pastas geradas (`google-play-phone/`, `app-store-iphone-6.3/`, `app-store-iphone-6.9/` e `app-store-ipad-13/`, se o app declarar iPad), mais o ícone e o destaque
- [ ] `checklist-publicacao.md`: o que falta, em ordem, dizendo quem faz cada item (dono, infra ou IA)

## Cadastro nos consoles

- **Apple:** primeiro o App ID explícito em Identifiers. Depois, no App Store Connect, crie o app em Novo app (nome, idioma principal, bundle, SKU) e anote o **Apple ID numérico**.
- **Google:** em Criar app, informe o nome, o idioma padrão, se é App ou Jogo e se é gratuito ou pago. As declarações de política e de exportação são aceite: **só marque com o "ok" do dono na hora.**
- **App Store Connect:** desmarque "Início de sessão obrigatório" quando o app não tiver login, e envie as capturas pelo Gerenciador de mídia.
- **Play:** o envio de várias capturas de uma vez entra fora de ordem. Tire do slot e adicione uma a uma pela biblioteca (Adicionar recursos › item › Adicionar). Salve a ficha como rascunho, porque "Avançar" leva à revisão.
- **A IA nunca:**
  - digita senha ou código;
  - aceita contrato sem o "ok" do dono;
  - mexe em pagamento ou banco;
  - envia para revisão.
- **O vendedor público é a conta em que o app é criado.** Confira se a política e os termos citam a mesma empresa.
