# Ciclo di vita locale AdE

Un nuovo dispositivo nasce con `fiscalStatus = nil`. La prima associazione a una
macchina in ruolo master imposta `ATTIVATO`; la prima audit importata con successo
imposta `IN_SERVIZIO`. I primi eventi prevalgono su qualsiasi stato precedente,
comprese le annotazioni manuali, e rimuovono causale e descrizione precedenti.

`AdeDeviceLifecycleDecision` distingue lo stato corrente dalla memoria dei primi
eventi (`hasBeenMaster`, `hasImportedAudit`), mantenuta dal server. Gli eventi
successivi conservano lo stato corrente, anche se corretto o cancellato manualmente.
Le associazioni slave non sono eventi di attivazione.

Il ritiro mantiene collegamento e ruolo, mentre la macchina passa a `deposito`.
Gli slave ancora installati vanno ritirati o dissociati prima del master. Finché
il master resta installato, il ritiro di uno slave non cambia lo stato fiscale
del sistema condiviso. Dopo il ritiro dell'ultima macchina, `warehouseReturn`
imposta `FUORI_SERVIZIO` e causale `Magazzino` (00608). La successiva installazione
mantiene questo stato fino alla prima audit riuscita, che riporta `IN_SERVIZIO`
anche se esistevano audit precedenti. Le altre causali manuali restano conservate
nelle importazioni successive alla prima.

Quando lo stato precedente è diverso da quello atteso, `alertMessage(adeID:)`
descrive l'incoerenza e l'eventuale correzione. Il server invia gli avvisi dopo
il commit nell'header `X-Ade-Device-Lifecycle-Alerts`: JSON di
`AdeDeviceLifecycleAlerts` codificato Base64 UTF-8. Il corpo della risposta resta
compatibile con i client precedenti. Un'importazione riassume al massimo quattro
avvisi nell'header e indica il numero degli ulteriori dispositivi da verificare.

L'app decodifica l'header soltanto dopo il successo della richiesta e presenta
l'alert nella vista che ha eseguito l'associazione o l'importazione. Lo stato
resta un'annotazione locale: non vengono effettuate comunicazioni all'AdE.

## Causale obbligatoria del ritiro

`AdeDeviceWithdrawal` richiede `reason`, limitato a `00608` (Magazzino) e `00607`
(Malfunzionamento). Entrambi gli endpoint di ritiro accettano il payload;
il ritiro del solo sistema lascia invariato lo stato fisico del distributore.
L'evento `withdrawal(reason)` imposta `FUORI_SERVIZIO` con la causale scelta.
Il server conserva il motivo anche quando ritira un solo slave e il sistema
rimane operativo sul master.

`awaitingServiceAfterWithdrawal` distingue il ritiro per malfunzionamento da
una semplice annotazione manuale: nel primo caso un'audit riuscita ripristina
`IN_SERVIZIO`, nel secondo conserva lo stato manuale. L'aggiornamento manuale
dello stato fiscale annulla questa attesa. `warehouseReturn` resta disponibile
per la preparazione automatica di un nuovo sistema su una macchina in deposito.
