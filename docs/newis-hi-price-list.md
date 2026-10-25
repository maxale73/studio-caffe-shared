# Codici delle piste nei file Newis HI

Il manuale EVOCA Newis **Hi! Platinum Executive**, U0234IT03, luglio 2020,
pp. 66–67, descrive la lista LA1 numero 5 come vendite gratuite e fidelizzazione.
In questa lista, gli indici 1...100 sono le linee prezzo; gli indici 101...200
conteggiano le vendite con punti fedeltà delle medesime linee 1...100.

Fonte primaria: [manuale del produttore, pp. 66–67](https://www.valevend-shop.it/img/cms/Manuali%20pagamento/Hi!%20Platinum%20EXE_U0234IT03%20.pdf).

`ParsedAuditBeta.priceListProductCode(listNumber:productCode:)` applica quindi
la corrispondenza `n - 100` esclusivamente ai record **Newis HI, lista 5,
indici 101...200**. Non applica un modulo 100 ai codici delle altre liste o
degli altri dispositivi, né elimina record in base all'uguaglianza dei prezzi.

`priceList()` usa il codice normalizzato per raggruppare i record: prezzi e
conteggi sono conservati e le vendite confluiscono sulla pista originaria.
Esempio: `LA1*5*101*50*7*70` contribuisce sette vendite al prezzo di 0,50
alla pista 1; non crea una pista 101. Un eventuale `LA1*0*101*80*1*10`
conserva invece il codice 101. I contatori aggregati di `parseReport()` e il
testo originale dell'audit non sono modificati.

La corrispondenza funziona sia dopo `parseReport()` sia immediatamente dopo
l'inizializzazione, tramite la stessa priorità di riconoscimento dei metadati
DXS, ID1, ID7 e AM1. Il server usa questo metodo anche per raggruppare i
centesimi originali della migrazione, evitando una seconda regola indipendente.

I test usano entrambi gli audit HI già presenti: le sei voci precedenti
`1, 2, 3, 101, 102, 103` diventano tre piste `1, 2, 3`. Sono coperti anche
conteggi e prezzi distinti, metadati ID1/ID7, limiti 101/200, codici di altre
liste, dispositivi diversi e codici 101 effettivi.
