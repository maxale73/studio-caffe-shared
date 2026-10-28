# Ciclo di vita locale AdE

Un nuovo dispositivo nasce con `fiscalStatus = nil`. La prima associazione a una
macchina in ruolo master imposta `ATTIVATO`; la prima audit importata con successo
imposta `IN_SERVIZIO`. I primi eventi prevalgono su qualsiasi stato precedente,
comprese le annotazioni manuali, e rimuovono causale e descrizione precedenti.

`AdeDeviceLifecycleDecision` distingue lo stato corrente dalla memoria dei primi
eventi (`hasBeenMaster`, `hasImportedAudit`), mantenuta dal server. Gli eventi
successivi conservano lo stato corrente, anche se corretto o cancellato manualmente.
Le associazioni slave non sono eventi di attivazione.

Quando lo stato precedente è diverso da quello atteso, `alertMessage(adeID:)`
descrive l'incoerenza e l'eventuale correzione. Il server invia gli avvisi dopo
il commit nell'header `X-Ade-Device-Lifecycle-Alerts`: JSON di
`AdeDeviceLifecycleAlerts` codificato Base64 UTF-8. Il corpo della risposta resta
compatibile con i client precedenti. Un'importazione riassume al massimo quattro
avvisi nell'header e indica il numero degli ulteriori dispositivi da verificare.

L'app decodifica l'header soltanto dopo il successo della richiesta e presenta
l'alert nella vista che ha eseguito l'associazione o l'importazione. Lo stato
resta un'annotazione locale: non vengono effettuate comunicazioni all'AdE.
