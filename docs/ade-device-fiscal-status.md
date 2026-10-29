# Stato fiscale dei sistemi master vending

`AdeDeviceFiscalStatus` descrive lo stato fiscale corrente del sistema master,
distinto dall'installazione fisica del distributore. I raw value sono quelli delle
API REST Gestionali AdE: `ATTIVATO`, `IN_SERVIZIO`, `FUORI_SERVIZIO`,
`DISATTIVATO`, `DISMESSO`. Nel ciclo vending il censimento produce `ATTIVATO`;
`CENSITO`, presente nel contratto generale AdE, non è un caso di questo enum.
Un dato non conosciuto è rappresentato da `nil`, senza inventare uno stato AdE.

`AdeDeviceFiscalStatusReason` conserva separatamente i codici delle causali:

| Codice | Causale | Stato compatibile |
| --- | --- | --- |
| 00601 | Altro, con descrizione obbligatoria | Tutti |
| 00603 | Cessione | DISATTIVATO |
| 00604 | Furto | DISATTIVATO |
| 00605 | Ritrovamento | ATTIVATO |
| 00606 | Smaltimento | DISMESSO |
| 00607 | Malfunzionamento | FUORI_SERVIZIO |
| 00608 | Magazzino | FUORI_SERVIZIO |

Il codice `00602` riguarda l'assistenza hot-swap dei dispositivi mobili e non
appartiene al modello dei sistemi master.

`AdeDeviceDTO` e `FetchedDevice` aggiungono i campi opzionali `fiscalStatus`,
`fiscalStatusReason`, `fiscalStatusReasonDescription`. Payload precedenti e
costruttori senza questi dati restano validi.

`AdeDeviceFiscalStatusUpdate` valida la compatibilità della causale e ripulisce
la descrizione. Il JSON deve includere `status`; una causale richiede uno stato
e una descrizione richiede una causale. `null` è ammesso solo se lo stato corrente
è già sconosciuto.
Il salvataggio dedicato segue le convenzioni esistenti:
`POST adeDevice/save_fiscal_status/:device_id`.

Questi dati sono annotazioni locali: il salvataggio non trasmette cambi di stato
all'Agenzia delle Entrate e non certifica che il dato sia stato verificato sul portale.
La migrazione server inizializza a `IN_SERVIZIO` i sistemi già associati ad almeno
un distributore, secondo il criterio richiesto dal gestore; gli altri rimangono `nil`.

Fonte: Agenzia delle Entrate, specifiche tecniche vending machine versione 3.0,
marzo 2017, §2.3.3 e tabella di coerenza pp. 9-11, e allegato API REST Gestionali.
[Provvedimento del 30 marzo 2017 e allegati, copia ufficiale MEF](https://def.finanze.it/DocTribFrontend/getContent.do?id=%7BAEA8D74C-6E91-480F-A9EF-CEB93881DCBC%7D).

## Transizioni manuali (shared 1.3.149)

`AdeDeviceFiscalStatus.allowedManualStatuses(from:)` fornisce le scelte alla UI;
`AdeDeviceFiscalStatusUpdate.transitionValidationMessage(from:)` verifica il
cambio sul server. La validazione dei campi e della causale rimane separata.

| Stato corrente | Stati selezionabili (incluso quello corrente) |
| --- | --- |
| Non noto | Non noto e tutti gli stati noti, per inizializzare il dato |
| ATTIVATO | ATTIVATO, IN_SERVIZIO, FUORI_SERVIZIO, DISATTIVATO, DISMESSO |
| IN_SERVIZIO | IN_SERVIZIO, FUORI_SERVIZIO, DISATTIVATO, DISMESSO |
| FUORI_SERVIZIO | IN_SERVIZIO, FUORI_SERVIZIO, DISATTIVATO, DISMESSO |
| DISATTIVATO | ATTIVATO (riattivazione), DISATTIVATO |
| DISMESSO | DISMESSO |

La matrice riguarda il normale editor locale: il ripristino straordinario di un
sistema dismesso non è gestito da questa operazione. Uno stato noto non può essere
azzerato, evitando il percorso IN_SERVIZIO → Non noto → ATTIVATO. Resta possibile
correggere causale e descrizione mantenendo lo stato corrente. Il server applica
il controllo nella stessa transazione e con lo stesso lock degli eventi di ciclo
vita. Le prime transizioni automatiche mantengono la precedenza concordata e i
relativi alert; non usano la matrice dei cambi manuali.
