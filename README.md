## Progetto Di Codifica di Testi del Professor Angelo Mario del Grosso

## Per il parsing e la validazione

- **Xerces-J-bin.2.12.1**
- Comando :  "Xerces-J-bin.2.12.1/xerces-2_12_1/xml-apis.jar;Xerces-J-bin.2.12.1/xerces-2_12_1/xercesImpl.jar;Xerces-J-bin.2.12.1/xerces-2_12_1/xercesSamples.jar" dom.Counter -v  codxml.xml
## Per la trasformazione in HTML

- **SaxonHE10-3J**
- Comando : java -jar SaxonHE10-3J/saxon-he-10.3.jar -s:codxml.xml -xsl:Progetto.xsl -o:output.html   
  
## XML, Stili e Interattività
Il progetto contiente la codifica delle pagine 7-8 del manoscritto nel file **codxml.xml**
Il progetto include stili CSS personalizzati e file JavaScript per migliorare l'interattività dell'interfaccia utente.

- **stile.css**
- **codJS.js**


