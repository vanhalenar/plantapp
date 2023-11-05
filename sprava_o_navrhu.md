# Správa o návrhu

# 1.2 Téma
## Pomocník pre pestovateľov rastlín (Timotej Halenár)
Návrh vychádza z mojej vlastnej potreby pre aplikáciu, ktorá by poskytovala prehľadný harmonogram polievania či hnojenia rastlín, tipy na starostlivosť o kvety či prehľad všetkých rastlín v domácnosti. Vždy som chcel mať veľa rastlín, ale nikdy som sa nevedel starať o kvety, a aplikácia tohto typu by mi vedela pomôcť.

## Téma 2 (Karolína Pirohová)
Kajin návrh témy a zdôvodnenie

## Téma 3 (Tomáš Mikát) 
Ako návrh som vymyslel aplikáciu, ktorá by zjednodušila spoznávanie ľudí a stretávanie sa s nimi. Existuje už veľa aplikácií s podobnými zámermi, avšak naša by bola zameraná na objavovanie menších špecifickejších skupín ľudí. Zadali by sa informácie o tom, čo má človek rád a čo by chcel, aby mal spoločné s hľadanou skupinou. Tak by sa vyhladala skupinka, ktorá sa nachádza v jeho okolí a pridal by sa do spoločného chatu. Tam by si mohli písať, plánovať stretnutia/akcie/výlety.

## Zvolená téma: Pomocník pre pestovateľov rastlín
Rozhodli sme sa pre danú tému, pretože abcdef

# 1.3 Prieskum užívateľských potrieb
## Dotazník
tu budú všetky otázky a poznatky získané z nich

## Analýza požiadaviek (Timotej Halenár)
tu budú získané poznatky z prieskumu
### Planta: analýza aplikácie
Hneď po otvorení aplikácie Planta sa užívateľovi zobrazí prehľad povinností pre aktuálny deň s možnosťou odkliknúť si každú z nich ako splnenú, čím sme sa v našej aplikácii inšpirovali. Jedným kliknutím je možné zaznačiť, že rastlina bola poliata, ale chýbala možnosť odložiť polievanie, ak užívateľ akurát nemá možnosť (napr. nie je doma). V Plante si užívateľ drží databázu svojich kvetov, ktoré sú rozdelené do skupín podľa miestností. Pre túto funkcionalitu som pri vlastnom testovaní aplikácie nenašiel využitie, skôr som mal dojem, že ide o zbytočnú komplikáciu. Bodom inšpirácie sa stal navigačný bar a teda členenie aplikácie do stránok - domovská stránka, prehľad rastlín, vyhľadávanie. Navyše sme pridali kalendár, ktorý obsahuje prehľad naplánovaných polievaní na nadchádzajúce týždne.

## Analýza požiadaviek (Karolína Pirohová)
tu budú získané poznatky z prieskumu
### Plant Daddy: analýza aplikácie
tu budú popísané prednosti a nedostatky aplikácie Plant Daddy

## Analýza požiadaviek (Tomáš Mikát)
tu budú získané poznatky z prieskumu
###  Plant Parent: analýza aplikácie
Plant Parent slúži hlavne na rovnaký cieľ ako aj naša aplikácia. Má veľa návodov, veľkú databázu rastlín, vlastnú kolekciu, rozoznanie rastlín pomocou fotoaparátu a samozrejme aj úlohy vo forme pripomienok. Aplikácia má jednoduchý a ľahko interpretovateľný dizajn, čiže sa v nej dá orientovať celkom rýchlo a bez problémov. Medzi jej veľké výhody patrí možnosť komunikácie s profesionálmi o určitých problémoch a informáciách. Avšak má aj problémy, ktorých sa chcem vyvarovať. Hlavným mínusom je, že niekoľko vymožeností je zamknutých za plateným VIP. Narozdiel od toho naša aplikácia bude celá zadarmo. Taktiež má ešte jeden menší problém, že sa niekedy na jednej obrazovke nachádza priveľa informácií a ťažko sa v nich orientuje. Tomu zabránime lepším roztriedením a hlavne znížením množstva nedôležitých informácií. Nakoniec už len jej nedostatky, ku ktorým môžem dať asi len gamifikáciu, ktorú my plánujeme naimplementovať.

## Užívateľské potreby a kľúčové problémy
tu bude zhrnutie analýzy požiadaviek, čo ľudia potrebujú od našej svetobornej aplikácie? čo chcú, nechcú? ako postupujú pri činnosti? aké sú kľúčové vlastnosti našej aplikácie?

# 1.4 Návrh aplikácie

## Rozdelenie práce
tu bude napísané, ako si rozdelíme prácu a pre aký spôsob rozdelenia sme sa rozhodli (1 alebo 2)

## Návrh časti aplikácie - domovská obrazovka a ocenenia (Timotej Halenár)
Domovská obrazovka je navrhnutá veľmi jednoducho: obsahuje karty s povinnosťami na aktuálny deň, ktoré je možné kliknúť a tým zaznamenať, že povinnosť bola splnená (poliatie alebo pohnojenie kvetu). Hlavnou funkcionalitou aplikácie je práve udržiavať harmonogram polievania a pripomínať užívateľom, ktoré kvety je treba poliať, preto je tento blok umiestnený hneď na domovskej obrazovke. 
Vďaka užívateľskému prieskumu sme zistili, že by určitá forma gamifikácie bola vítaná. Vznikla tak stránka, kde má užívateľ prehľad ocenení, ktoré získava napr. za pravidelné polievanie. Na tejto obrazovke môže vidieť, ktoré výzvy splnil a ktoré aktuálne robí.
### Testovanie
tu bude napísané, ako sa testovalo (viz zadanie)

## Návrh časti aplikácie (Karolína Pirohová)
tu bude popísaný návrh časti aplikácie a bude tu maketa (viz zadanie)
### Testovanie
tu bude napísané, ako sa testovalo (viz zadanie)

## Návrh časti aplikácie - Kolekcia rastlín a Kalendár úloh (Tomáš Mikát)
Pre moju časť aplikácie sa budú používať dva hlavné panely.
Kalendár úloh obsahuje posuvný panel, na ktorom sa zobrazujú jednotlivé úlohy. V kalendári sa pre dosiahnutie jednoduchšej orientácie zobrazuje len jeden týždeň. Pre zobrazenie iného týždňa slúži tlačidlo, ktoré otvorí zoznam týždňov a v ňom bude možné určitý týždeň vybrať. 
Kolekcia rastlín funguje ako jednoduchý zoznam obsahujúci jednotlivé rastliny, ich druh a fotku. Po kliknutí na niektorú rastlinu sa užívateľovi zobrazí jej profil. Pre zrýchlenie hľadania rastliny sa nad zoznamom nachádza vyhľadávací bar, ktorý obsahuje aj filtrovanie pomocou lokácie a druhu.
### Testovanie
tu bude napísané, ako sa testovalo (viz zadanie)

## Technický návrh aplikácie
tu bude popis architektúry celej aplikácie (frontend aj backend), návrhový vzor (MVC), popis dátového modelu, definícia API, technológie a nástroje a zdôvodnenie ich výberu
