# Sorgenti Qt corrispondenti alle DLL di Lineare

Pubblicazione tecnica del 7 ottobre 2026 a cura di Dimac s.r.l.
Contatto: mario.brumini@dimacsrl.com.

Revisione stabile: **qt-6.11.2-vcpkg-3aea538-x64-windows**.

Questa repository mette a disposizione i sorgenti Qt 6.11.2, le patch e il
materiale di ricostruzione corrispondenti alle librerie Qt delle build locali
di Lineare verificate alla data indicata. Copre Qt Core, Gui, Widgets, Network
e i plugin Windows, Modern Windows Style, JPEG, GIF e ICO delle due
configurazioni Debug/Release. Non comprende il codice proprietario di Lineare.

## Download

Usare la [revisione stabile](https://github.com/Mario-Dimac/qt-corresponding-source/tree/qt-6.11.2-vcpkg-3aea538-x64-windows)
oppure scaricare [l'intera pubblicazione in ZIP](https://github.com/Mario-Dimac/qt-corresponding-source/archive/refs/tags/qt-6.11.2-vcpkg-3aea538-x64-windows.zip).
Gli archivi dei sorgenti sono file ordinari Git, disponibili anche senza Git LFS.

- `sources/qtbase-everywhere-src-6.11.2.tar.xz`: archivio originale completo
  usato dalla build, comprendente i sorgenti delle parti incorporate in Qt.
- `sources/vcpkg-3aea538b2bb21a586502c67b00eb474fdd2e3098.tar.gz`:
  snapshot completo delle ricette e degli script vcpkg alla revisione usata.
- Gli altri archivi in `sources/`: sorgenti delle dipendenze esterne
  double-conversion, libjpeg-turbo, libpng, md4c, PCRE2/sljit e zlib.
- `ports/qtbase/`: copia leggibile del port Qt originale, con tutte le patch.
- `build/`: istruzioni di ricostruzione, verifica e sostituzione delle DLL.
- `metadata/`: configurazione, provenienza SPDX, ABI e hash delle DLL verificate.
- `licenses/`: testi originali Qt, vcpkg e dipendenze native.
- `SHA256SUMS.txt`: hash SHA256 dei materiali pubblicati.

I sorgenti Qt effettivi si ottengono dall'archivio originale applicando le
24 patch elencate in `build/patch-order.txt`. vcpkg esegue automaticamente
questa operazione; la verifica contro l'albero locale e documentata in
`metadata/source-verification.json`.

## Ricostruzione e licenze

Seguire [le istruzioni di ricostruzione](build/README.md).
Le parti Qt coperte da LGPLv3 conservano tale licenza e gli altri componenti
conservano i propri termini. Non si assegna una licenza unica a tutti i file
della repository. I testi originali sono inclusi negli archivi e in `licenses/`,
comprese LGPLv3 e GPLv3. Le patch vcpkg conservano i termini applicabili ai
rispettivi file e al codice modificato.

La pubblicazione riguarda Qt e il materiale qui elencato. Gli avvisi di
OpenCV, ONNX Runtime, Python, stack AI e altri componenti del prodotto sono
gestiti separatamente. La corrispondenza con un installer futuro deve essere
verificata confrontandone le DLL con `metadata/qt-binaries.json`.

Gli archivi e le patch sono verificati; durante questa pubblicazione non
e stata eseguita una seconda compilazione completa di Qt. Questa raccolta
tecnica non costituisce una certificazione legale dell'intero prodotto.
