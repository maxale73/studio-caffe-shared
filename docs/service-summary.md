# Riepilogo manutenzioni per componente

`MachineServiceSummary` riceve il catalogo completo, tutti gli interventi della macchina e la data di riferimento. Il calcolo è condiviso tra i client e non richiede nuove colonne o API.

Ogni componente, anche disattivato o mai utilizzato, conserva la data e tutti i tipi dell’ultimo intervento. Il riferimento per le battute è l’ultima lettura non negativa registrata nelle manutenzioni della stessa macchina. Gli interventi futuri vengono esclusi. Il tempo trascorso si misura dalla data dell’ultimo intervento alla data di riferimento del riepilogo.

La progressione usa tutte le letture della macchina in ordine temporale, incluse quelle relative ad altri componenti. Quando il valore diminuisce, inizia un nuovo intervallo: si sommano soltanto gli incrementi osservati nei diversi intervalli. Per esempio `10000 → 12000 → 500 → 800` produce **almeno 2300 battute**. La discontinuità resta indicata, poiché non è noto quante battute siano state eseguite tra le due letture del cambio contatore. Non si presume che il nuovo contatore sia partito da zero.

Una manutenzione senza lettura non eredita il contatore di una manutenzione precedente. Letture identiche allo stesso istante vengono accorpate; valori diversi allo stesso istante rendono il conteggio non calcolabile, senza inventare un ordine. Anche un totale oltre la capacità di `Int` resta non calcolabile.
