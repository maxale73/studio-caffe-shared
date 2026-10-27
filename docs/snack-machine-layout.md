# Ricostruzione dello schema snack

`SnackMachineLayout` è una fotografia derivata delle piste `type == .snack`.
Usa `machineSectorCode` per la posizione fisica e conserva `PriceChannelDTO.index`
come numero della pista prezzo. Se il campo settore è vuoto o assente, usa il
numero pista anche come codice settore, purché sia compreso tra 10 e 99.
Un indice a tre cifre non inventa un prefisso di distributore. Il settore esplicito è sempre prioritario.
Non modifica il listino né salva il settore ricavato dall'indice.

## Settori e griglia

- `PriceChannelSector` accetta due cifre ASCII, precedute al massimo da una lettera
  o cifra. Il campo può essere vuoto; gli spazi esterni vengono ignorati. `11`,
  `011` e `x11` identificano lo stesso settore fisico di tre distributori diversi.
  Il prefisso è conservato come testo, compreso lo zero; maiuscole e minuscole
  restano distinte. Codici più lunghi o con suffisso non numerico sono rifiutati.
- `SnackMachineLayout.machines` contiene una griglia per ogni prefisso, incluso
  quello vuoto, che viene ordinato per primo. Ogni griglia ha cassetti, larghezza
  e origine della numerazione indipendenti. La separazione avviene anche se non
  ci sono settori fisici ripetuti tra i distributori.
- `settore / 10` identifica il cassetto; `settore % 10` identifica la posizione.
  I cassetti e le selezioni sono ordinati per settore, senza inventare cassetti assenti.
- La griglia di ogni distributore ha da 3 a 8 colonne. Se compare una posizione zero, usa
  numerazione da zero. In assenza di zero, una riga contigua da uno o la presenza
  della posizione otto identifica numerazione da uno. Negli altri casi assume zero.
- L'ultima posizione valida determina la larghezza comune. La cifra nove non è
  supportata; una posizione otto insieme a zero rimane non collocata.

## Selezioni doppie e limiti dell'inferenza

Quando un cassetto termina sull'ultima colonna, ogni codice indica la fine della
selezione. `11,13,15`, con una griglia di sei colonne, diventa quindi tre selezioni
con intervalli `0..<2`, `2..<4`, `4..<6`. `20...25` produce sei selezioni singole.
Se manca il codice finale ma la riga inizia sulla prima colonna, usa invece i
codici come inizi: `10,12,14` produce gli stessi tre intervalli doppi.

Il raggruppamento è applicato soltanto se tutta la riga si ricostruisce con
selezioni di una o due colonne. Altrimenti mantiene le selezioni singole nelle
posizioni note e restituisce celle `.gap` per gli spazi irrisolti. Un salto di tre
non è trasformato silenziosamente in una selezione tripla.

La sola numerazione non distingue sempre un accoppiamento da un dato mancante,
né identifica sempre quale dei due codici venga usato dal costruttore. In caso di
ambiguità applica le regole sopra descritte, coerenti con l'esempio `11,13,15`.
Per una rappresentazione fisica certificata servirebbe una configurazione
esplicita delle larghezze, che il listino attuale non contiene.

## Piste non posizionate

Le piste snack con codici fuori formato, duplicati all'interno dello stesso
prefisso (`011` e ` 011 `) o incompatibili con la griglia sono conservate in
`unplacedChannels`, con la relativa causale. Nessuna è scartata. Anche i settori
ricavati dal numero pista devono avere una decina di cassetto e non duplicare
settori espliciti o ricavati da altre piste. Un settore non vuoto ma non valido
non viene sostituito dall'indice. I tipi caldo e non definito sono esclusi.
L'opzione `useChannelIndexForMissingSector: false` disabilita il ripiego sull'indice
e conserva anche i settori mancanti tra le piste non collocate.

Le celle reali conservano il settore fisico a due cifre, la pista completa con il
codice originale e l'intervallo di colonne. La UI
può quindi mostrare l'intestazione `settore (pista)`, il prezzo 1 esatto in `Decimal`
e la descrizione, usando la larghezza relativa `columnSpan / columnCount`.

`SnackMachineLayoutTests` copre l'esempio, entrambe le origini di numerazione,
larghezze da 3 a 8, righe tutte accoppiate, cassetti assenti, salti irrisolti,
settori mancanti, duplicati, codici non numerici e conservazione dei dati originali.
Verifica anche prefissi numerici e alfabetici, griglie indipendenti e due distributori
da otto colonne con 87 piste complessive.

Per compatibilità, `drawers` espone i cassetti appiattiti e `columnCount` la massima
larghezza: nei layout multipli i cassetti vanno sempre visualizzati all'interno
della relativa `Machine`, poiché il numero di cassetto può ripetersi tra distributori.
`PriceChannelDTO.validationMessage` applica il formato ai nuovi salvataggi di app
e server; le vecchie stringhe già presenti non vengono riscritte da una migrazione.
