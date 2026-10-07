# Ricostruzione Qt Windows x64

## Ambiente della build di riferimento

- Windows x64 e Visual Studio 2026, workload sviluppo desktop C++.
- Toolset MSVC nella cartella `14.51.36231`; il compilatore rilevato da Qt
  si identifica come `19.51.36260.0`.
- Windows SDK `10.0.26100.0` e CMake `4.4.3`.
- vcpkg al commit `3aea538b2bb21a586502c67b00eb474fdd2e3098`.
- Triplet `x64-windows`, CRT dinamico e Qt in DLL, Debug e Release.
- Feature Qt effettive: `core,doubleconversion,gui,widgets,network,jpeg,png,thread`.

Lo snapshot vcpkg conserva port, patch, triplet, toolchain e helper della
revisione utilizzata. La copia leggibile `ports/qtbase/` e identica al port
contenuto nello snapshot. `patch-order.txt` riporta le 24 patch applicate
per questa combinazione Windows/feature. Non applicarle una seconda volta:
vcpkg le applica durante l'estrazione dei sorgenti.

## Procedura

Scaricare o clonare l'intera repository al tag indicato nel README principale.
Aprire PowerShell con Git e CMake 4.4.3 disponibili nel PATH, dopo aver
installato gli strumenti Microsoft sopra indicati. Dalla radice della repository:

```powershell
& ./build/verifica-archivi.ps1
& ./build/ricostruisci-qt.ps1 -Destination C:/dev/qt-source-rebuild
```

La destinazione deve essere nuova. Lo script non tocca il vcpkg del progetto.
Gli archivi Qt e delle dipendenze native incluse vengono copiati nella cache
download della nuova installazione. Servono connessione Internet e spazio
disco per il bootstrap e gli strumenti interni eventualmente mancanti
(Python, Perl, pkg-config e altri strumenti selezionati dalle ricette).
Gli strumenti Microsoft e i loro SDK non sono redistribuiti in questa repository.
I sorgenti delle dipendenze native esterne sono inclusi in `sources/`; le
relative patch e ricette sono nello snapshot vcpkg.

vcpkg compila le proprie dipendenze con il generatore interno scelto dalle
ricette, che nella build di riferimento e Ninja. Non occorre installare Ninja
manualmente. Il generatore dell'applicazione Lineare, MSBuild, e distinto.
L'opzione `--no-binarycaching` obbliga la compilazione dai sorgenti.

Le DLL si trovano in `installed/x64-windows/bin`, quelle Debug in
`installed/x64-windows/debug/bin`; i plugin nelle rispettive
`Qt6/plugins/{platforms,styles,imageformats}`.
`metadata/configure-commands.txt` e i riepiloghi Debug/Release documentano
la configurazione originale. I percorsi Microsoft presenti nei comandi
registrati descrivono quel PC: non vanno copiati come percorsi obbligatori.

## Sostituzione delle DLL

Chiudere Lineare e salvare una copia della cartella installata. Copiare nella
cartella dell'eseguibile le DLL Qt modificate compatibili per ABI e x64;
aggiornare insieme i plugin correlati nelle sottocartelle `platforms`,
`styles` e `imageformats`. Usare Release per il prodotto installato e Debug
per una build Debug, conservando i nomi delle DLL. Riavviare e verificare le
funzioni interessate; ripristinare la copia in caso di incompatibilita.
I diritti di modifica e debug concessi dalle licenze Qt restano applicabili.

## Verifiche effettuate e limiti

Sono verificati gli hash degli archivi contro i metadati SPDX installati,
l'applicazione delle patch, il confronto dei sorgenti ottenuti con quelli
locali utilizzati e la corrispondenza delle DLL/plugin nelle build locali
con l'installazione vcpkg. I risultati sono in `metadata/`.
Non e stata eseguita una seconda compilazione completa di Qt durante questa
pubblicazione, ne si promette identita binaria tra ricompilazioni su PC diversi.
Prima di associare questa revisione a un altro installer confrontarne le DLL
con `metadata/qt-binaries.json`.
