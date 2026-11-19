# 0014 — Auditoria de loja por um plugin nosso com código de terceiros fixado e sem hook

**Status:** Aceita · 18/11/2026 · Estende o ADR-0008 e o ADR-0009

## Contexto

App da Matter já foi rejeitado na revisão da loja, e a submissão dos apps é manual: nada confere permissões, `PrivacyInfo.xcprivacy`, exclusão de conta, IAP ou metadados antes do envio. O playbook [mjmirza/app-store-compliance](https://github.com/mjmirza/app-store-compliance) cobre isso para Apple e Google Play, inclusive Flutter: uma skill de auditoria, o comando `/app-store-audit` e um script de scan (`app-store-compliance-guard.sh`). A licença (OpenRoots ORA 2.3) é gratuita abaixo de US$ 20 mi de faturamento anual, que é o caso da Matter.

O instalador do upstream copia tudo para `~/.claude` e registra o scan como hook `PreToolUse` de Bash. O ADR-0009 manteve código de terceiros e hooks fora dos nossos plugins.

## Decisão

- Plugin novo `matter-loja` no marketplace `matter`, habilitado só nos apps (e já no `matter-flutter-template`). Leva a skill, o comando e o script de scan do upstream, **sem hook**.
- Código de terceiros entra num plugin nosso só se as três condições valem juntas: não traz hook; é copiado numa versão fixa pelo `sync-upstream.sh` do plugin, com a versão e as trocas registradas no `UPSTREAM.md`; e alguém lê o diff do upstream antes de cada atualização. `LICENSE` e `NOTICE` vão junto.
- Os apps rodam o mesmo scan no CI (`store-compliance.yml`), com o upstream fixado por SHA. O check começa não obrigatório; o que ele achar vira issue do app, e ele passa a obrigatório quando estiver verde.
- As skills `pronto`, `feature-front` e o `revisor` mandam auditar quando o PR mexe no que a loja revisa (plist, manifesto de privacidade, permissões, IAP, versão).

## Alternativas descartadas

- **`install.sh` do upstream por pessoa:** vale para uma máquina, em todo repo dela, sem versão fixa, e não chega a quem clona o app.
- **Hook bloqueando `flutter build ipa/appbundle`:** o envio é manual, fora do Claude, então o hook só atrapalharia builds locais sem pegar a submissão real. O CI pega o que importa.
- **Só recomendar em `ferramentas.md`:** não tem como exigir a auditoria no `pronto` nem no CI se cada um tem uma versão diferente, ou nenhuma.

## Consequências

- Atualizar o upstream é pôr um clone limpo na tag nova, rodar `sync-upstream.sh <clone>`, ler o diff e subir a `version` do plugin; o SHA do CI dos apps sobe junto.
- Fica fora da auditoria pelo plugin: `pull-metadata.sh`, que usa o token da Play ou a chave `.p8` da Apple (segredo, nunca em modelo gratuito), e o `monitor.py` e os `monitor-*.py`, que buscam feeds na rede. O `sync-upstream.sh` acrescenta essa regra à skill e ao comando, sem editar o texto do upstream.
- No CI o scan roda com a pasta como argumento e `APP_STORE_GUARD_OK=0`: sem pasta ele entra em modo hook e sai 0 sem escanear, e com a variável em 1 deixa passar crítico.
- O plugin carrega cerca de 2 MB de doc e dados do upstream; a skill é sob demanda, então não pesa no contexto fixo.
- O CI dos apps passa a depender de um repo público de terceiros fixado por SHA: se ele sumir, o job falha e o SHA troca por uma cópia nossa.
