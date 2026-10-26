# Ricostruzione dello schema snack

`SnackMachineLayout` è una fotografia derivata delle piste `type == .snack`.
Usa `machineSectorCode` per la posizione fisica e conserva `PriceChannelDTO.index`
come numero della pista prezzo. Non modifica il listino e non confonde i due codici.

## Settori e griglia

- Il settore deve contenere un intero positivo di almeno due cifre, con soli
  caratteri ASCII numerici. Spazi alle estremità e zeri iniziali sono accettati.
- `settore / 10` identifica il cassetto; `settore % 10` identifica la posizione.
  I cassetti e le selezioni sono ordinati per settore, senza inventare cassetti assenti.
- La griglia comune ha da 3 a 8 colonne. Se compare una posizione zero, usa
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

Le piste snack senza settore, con codici non numerici, duplicati dopo la
normalizzazione (`11` e `011`) o incompatibili con la griglia sono conservate in
`unplacedChannels`, con la relativa causale. Nessuna è scartata e l'indice prezzo
non viene usato implicitamente come settore. I tipi caldo e non definito sono esclusi.

Le celle reali conservano settore, pista completa e intervallo di colonne. La UI
può quindi mostrare l'intestazione `settore (pista)`, il prezzo 1 esatto in `Decimal`
e la descrizione, usando la larghezza relativa `columnSpan / columnCount`.

`SnackMachineLayoutTests` copre l'esempio, entrambe le origini di numerazione,
larghezze da 3 a 8, righe tutte accoppiate, cassetti assenti, salti irrisolti,
settori mancanti, duplicati, codici non numerici e conservazione dei dati originali.
