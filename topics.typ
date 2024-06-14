#import "@preview/touying:0.4.2": *

// Themes: default, simple, metropolis, dewdrop, university, aqua
#let s = themes.metropolis.register(aspect-ratio: "4-3")
#let occured(t) = text(fill: red, t)
#let occnow = box(fill: yellow, inset: 0.2em, baseline: 0.2em, height: 1em, radius: 0.4em,text(fill: red, weight: "bold", "24/0"))
#let s = (s.methods.info)(
  self: s,
  title: [Sieci Komputerowe],
  subtitle: [Heurystyka Edukacyjna],
  date: [Statystyki tematów uzupełnione o tegoroczną zerówkę #occnow],
  institution: [2023/2024],
)
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init

#show strong: alert

#let (slide, empty-slide, title-slide, focus-slide) = utils.slides(s)
#set text(size: 0.7em)
#show: slides

= Ranking tematów
#table(columns: (2.5fr, 1.5fr),
[Temat],[Wystąpienia (rok/termin)],
[Tryby pracy przełączników, metody przełączania],[23/0,23/0',24/1',19/1,19/2,24/1"],
[Porównanie koncentrator, przełącznik, router, brama],[23/0,23/0',17/1,18/1,24/1'],
occured([Wady IPv4 wynikające z budowy nagłówka]),[23/0,23/0',18/1,24/1',19/1,#occnow],
occured([Mechanizmy i algorytmy sterowania przepływem danych w IP]),[23/0,23/0',23/1,24/1',19/1,19/2,18/0,24/1",#occnow],
occured([Zasady dostępu DCF i PCF w IEEE 802.11]),[23/0,17/1,18/1,19/1,24/1",#occnow],
occured([VLAN - definicje, cel, sposoby określ. przynależności, 802.1Q]),[23/0',24/1',19/2,#occnow],
occured([Synchronizacja w sieciach - def., cechy, standardy, w tym NTP]),[23/0',23/1,24/1',#occnow],
[Zasady organizacji DNS],[17/1],
[Tworzenie i modyfikacja tablic routingu],[17/1,18/1],
[DHCP - co to, po co, zasada działania],[18/1,23/1,24/1"],
[DNS - co to jest, jak działa, typy rekordów],[19/1,18/0,24/1"],
[Przyczyny przejścia z adresacji klasowej na bezklasową],[18/1,19/1],
[Dlaczego ramka Ethernet ma rozmiar >64B i \<2kB],[23/1,24/1\"],
[Kodowanie xB/yB - zalety nad prostymi np. Manchester i opis],[23/1,19/2,18/0],
[Kryteria wyboru przełączników],[23/1],
[Różne typy adresów w ujęciu warstwowym],[19/2,18/0],
[Porównanie ISO/OSI i TCP/IP, podst. założenia],[19/2],
[Opis działania systemów pocztowych, w tym protokoły],[18/0],
[Mechanizmy sieci WLAN, podwarstwa MAC, zróżn. strumienie],[18/0],
occured([WiFi - Czułość odbiornika a parametramy emisyjne i propagacyjne]),
occnow
)

' - EiT, " - IBM\
_Pominięto tematy wymagające znajomości literatury._\
*Pominięto tematy z zakr. wiedzy ogólnej, scalono podobne tematy (jako element heurystycznej strategii zaliczenia).*

= Pewniaki
== Tryby pracy przełączników, metody przełączania
- Metody przełączania:
  - Store-and-forward: przesyłamy dane po otrzymaniu całej ramki i sprawdzeniu sumy kontrolnej
    - Zalety: nie zalewamy sieci nieprawidłowymi danymi, idealne przy aplikacjach wrażliwych na błędy w transmisji
    - Wady: opóźnienie proporcjonalne do długości ramki
  - Cut-Through: przesyłamy dane od razu po odczytaniu adresu docelowego
    - Zalety: o wiele szybciej, doskonałe do zastosowań niewrażliwych na przekłamania np. systemów multimedialnych
    - Wady: możemy zalewać sieć uszkodzonymi ramkami
- Tryby pracy:
  - Transparent Bridging: dane rozgłoszeniowe przesyłane na wszystkie porty (oprócz źródłowego)
    - Zalety: brak konieczności konfiguracji przy zmianie podłączeń
    - Wady: możliwość wystąpienia sztormów rozgłoszeniowych, zalewanie sieci bardzo niekorzystne np. przy grach czy multimediach
  - Express Switching: dane rozgłoszeniowe przesyłane na wybrany port (ustalany przez supervisora)
    - Zalety: nie zalewamy sieci, pozwala uniknąć sztormów rozgłoszeniowych
    - Wady: konieczność ręcznej konfiguracji, jak przełączymy urządzenie do innego portu i nie zmienimy ustawień to nie działa
*Dane rozgłoszeniowe = broadcast + ramki do urządzeń nieznajdujących się jeszcze w buforze LookUp*

== Porównanie urządzeń sieciowych
- Regenerator [warstwa fizyczna]:
  - Zamienia zniekształcony sygnał na "ładny"
  - Opóźnienia rzędu nanosekund (rozwiązanie sprzętowe analogowe)
  - Zastosowania: łączenie dwóch sieci tego samego typu (przedłużanie zasięgu medium)
- Koncentrator [warstwa fizyczna]:
  - Rozgłasza otrzymany sygnał na wszystkie porty (oprócz źródłowego)
  - Opóźnienia kilkaset nanosekund (podobnie jak regenerator)
  - Do stosowania wyłącznie w sieciach o małym obciążeniu, np. centralek p-poż. i innych przemysłowych
  - Może wykrywać kolizje
- Most [warstwa łącza danych]:
  - Urządzenie cyfrowe stosowane do łączenia ze sobą sieci heterogenicznych
  - Uczy się, w której sieci znajduje się stacja
  - Opóźnienia mikrosekundowe
- Przełącznik [warstwa łącza danych i warstwa sieciowa]:
  - Podobnie jak most, uczy się lokalizacji stacji i przesyła dane, ale jednocześnie
  - Do momentu wypełnienia LookUp (albo jak go przepełnimy) table działa jak koncentrator
  - Dzieli domenę kolizyjną
  - Może posiadać zaawansowane mechanizmy filtracji wg. protokołu, MAC itp.
  - Może dzielić domenę rozgłoszeniową (VLANy)
- Router [warstwa sieciowa]:
  - Dzieli domenę rozgłoszeniową
  - Opóźnienia rzędu kilku milisekund (nie nadużywać!)
  - Zaawansowane mechanizmy filtracji, firewalle, wydzielanie podsieci itp.
  - Routing wg. tablicy trasowania (statycznej od supervisora lub tworzonej dynamicznie)
== Wady IPv4 wynikające z budowy nagłówka #occnow
- Wersja protokołu - po co aż 4 bity jak może być tylko 4 lub 6??
- Typ usługi - ignorowane przez wiele urządzeń, może być tam kod klasy obsługi (ekspres, gwarantowana) ale i tak wtedy nieużywamy 2 bitów
- Całkowita długość datagramu: 16 bitów to może być za mało
- Identyfikacja: ponownie 16b to za mało na długie połączenia, ponadto narażenie prywatności (powiązanie wiadomość - IP)
- Przesunięcie fragmentacji: sama idea fragmentacji wprowadza duże opóźnienia i możliwość zgubienia części danych, co zwykle skutkuje ponownym przesyłaniem całości
- Czas życia (TTL): tylko 8 bitów, można tym manipulować i "ubijać" datagramy, ponadto każdy OS ustawia inaczej przez co można go zidentyfikować
- Protokół: 8 bitów - stanowczo za mało, nieustandaryzowane
- Suma kontrolna: po co skoro stopa błędów $10^(-12)$, zwłaszcza że dotyczy tylko nagłówka
- Opcje nagłówka: rejestrowanie (i tak za małe pole 40B), wymuszanie trasy, zwykle ignorowane
- *Adresy: 32b stanowczo za mało żeby zapewnić unikalność w skali świata*

== Mechanizmy i algorytmy sterowania przepływem danych w IP #occnow
- TCP Sliding Window Flow Control
  - Odbiorca określa ile danych może przyjąć, określając szerokość okna
    - Po otrzymaniu +ACK nadawca może wysłać kolejną porcję danych określoną przez rozmiar okna
    - Jeśli otrzyma -ACK lub nie otrzyma żadnej odpowiedzi w ustalonym czasie restransmituje dane
- TCP Congestion Control *implementowany po stronie nadawczej*
  - Nadawca ma 2 parametry:
    - CWND - Congestion WiNDow
    - SSHTHRESH - Slow Start THRESHold
  - Tryb Slow Start
    - Początkowo CWND = 1 \* MSS (Max Segment Size)
    - Dla każdego +ACK zwiększamy CWND o 1 (wykładniczo, nawet gdy ACK potwierdza mniej niż 1MSS)
    - Jeżeli CWND>SSHTHRESH to przełączamy się w tryb Congestion Avoidance
  - Tryb Congestion Avoidance
    - Zwiększamy CWND dopiero gdy przyjdą wszystkie +ACK (liniowo)
  - Fast Retransmit *TCP TAHOE*
    - Jeśli odbierzemy >=3 zduplikowane ACK to znaczy że segment był stracony
    - Szybka retransmisja brakującego segmentu zanim nastąpi timeout
    - Procedura Slow Start
  - Fast Recovery *TCP RENO*
    - Duplikaty ACK oznaczają że coś tam się przesyła
    - Szybka retransmisja
    - SSHTHRESH = CWND/2
    - CWND = SSHTHRESH+3
    - Procedura Congestion Avoidance
    - Pozwala zwiększyć wydajność unikając procedury Slow Start po retransmisji
== Zasady dostępu DCF i PCF w IEEE 802.11 #occnow
- DCF (asynchroniczny)
  - Oparty o rywalizację, mogą istnieć kolizję ale staramy się ich unikać
  - Nadawca wysyła RTS (zawiera czas transmisji)
  - Odbiorca wysyła CTS (również zawiera planowany czas zajętości medium)
  - Inne stacje odkładają dane w swoich Network Allocation Vectorach
  - Nadawca wysyła dane
  - Po poprawnym odebraniu odbiorca wysyła ACK i kolejna rywalizacja
  - Występuje problem ukrytych stacji, które mogą wywołać kolizję nie wiedząc, że druga nadaje
- PCF (synchroniczny)
  - Brak rywalizacji, brak kolizji, dostępem zarządza Point Coordinator (zwykle Access Point)
  - Jest stosowany przez wydzielony fragment czasu (podawany w beacon frame), obok DCF
  - W czasie PIFS PC odpytuje poszczególne stacje wysyłając POOL, wtedy wysyłają one swoje dane (muszą zdążyć zacząć w SIFS), reszta trzyma je w NAV
#grid(columns: (1fr, 1fr), figure(caption: "DCF", image("DCF.png", width:20em)), figure(caption: "PCF", image("PCF.png", width:20em)))
== VLAN - definicje, cel, sposoby określ. przynależności, 802.1Q #occnow
- Pozwalają tworzyć wiele logicznych sieci w jednej fizycznej
- Zalety: 
  - Bezpieczeństwo - uniemożliwienie podsłuchiwania, skanowania urządzeń
  - Przeciwdziałanie sztormom rozgłoszeniowym, podział domeny rozgłoszeniowej bez routerów
  - Zmiany organizacji sieci za pomocą oprogramowania
- Najpopularniejsze typy:
  - Segmentacja wirtualna - wydzielone nie nakładające się grupy, każda funkcjonuje jako oddzielna domena, pod jednym adresem. Najprostrzy sposób na tworzenie grup roboczych.
  - Podsieć wirtualna - ruch pakietów poddawany programowej kontroli, jedno urządzenie może należeć do wielu grup
- Sposoby określania przynależności stacji
  - Grupy portów - segmentacja wirtualna, prawie każdy przełącznik to obsługuje
  - Adresy MAC - tabela asocjacyjna wewnątrz przełącznika, MAC->jedna/wiele podsieci
  - Adresy warstwy sieciowej (np. IP) - np. podział według masek podsieci
  - Reguły logiczne - kombinacja powyższych + protokoły, pola ramki itp.
  - Multicastowe adresy IP - stacje łączą się w grupy rejestrując specjalne adresy IP
- Do ramki ethernet pomiędzy adresami a długością wpychane jest pole 802.1Q VLAN TAG (usuwa je potem ostatni switch na trasie)
  - Protocol ID - stała 0x8100
  - User Priority Bits - priorytet QoS zakr. 0-7
  - Canonical Format Indicator - 1 = brak zezwolenia na retransmisje przez porty bez wsparcia dla 802.1Q
  - VLAN ID - 12 bitów, chociaż często liczba ograniczona przez producenta
VLAN może być jawny lub ukryty (wtedy klient nawet nie wie, że jest w VLANie)
