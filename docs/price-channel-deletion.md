# Eliminazione delle piste prezzo

`PriceChannelDeletion` identifica una o più piste tramite `channelIDs`, un array
non vuoto di UUID senza duplicati. Il payload non contiene copie di prezzi o
altre proprietà delle piste.

`AdeDeviceEndpointsGroup.deletePriceChannels(deviceID:deletion:)` segue le
convenzioni esistenti: `POST adeDevice/delete_price_channels/:device_id`, con
autenticazione token e UUID del dispositivo nel percorso. Restituisce
`PriceLayoutResponse` con il listino completo dopo l'eliminazione.

Il server verifica tutte le appartenenze prima di scrivere. Una pista mancante
o estranea al dispositivo annulla l'intera richiesta con HTTP 409. Un array
vuoto o duplicato restituisce HTTP 400; dispositivo o listino assenti HTTP 404.
Errori durante la cancellazione o l'aggiornamento del timestamp annullano la
transazione. Le piste non selezionate e il loro ordine logico non cambiano.

L'intestazione del layout viene conservata anche quando tutte le piste vengono
eliminate: `channels` diventa un array vuoto e il seed non ricrea il listino
dalle rilevazioni storiche. Non sono necessarie nuove migrazioni.
