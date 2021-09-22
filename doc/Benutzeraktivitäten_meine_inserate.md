# Benutzeraktivitäten

### Foot

- Verlinkung Impressum
- Verlinkung HELP

### Head

- Inserate erstellen(weiterleitung)
- Verlinkung zur Institution wenn Click auf Logo?
- Verlinkung Kategorien (über Titel)

## InserateEditor

* Bild hinzufügen
* Bild als Standard setzen
* Bild entfernen
* Titel bearbeiten
* Beschreibung bearbeiten
* Anzahl Tage der Gültigkeit festlegen (max 30 Tage)
* Warnung, wenn geblacklistet

## per Email

* Inserat aufgeben (Bestätigungslink)

### Für privilegierte Nutzer

* Inserat ablehnen (mit Begründungstext)
* Inserat erlauben
* Absender blacklisten

!!! Folge:
    Komplettes Inserat in Mail mitliefern

## Kategorien

- Kategorie Auswahl(weiterleitung)
- Angebot des Tages?(Nach links/rechts wechseln)

## Inserate
  
- alles aufklappen
- alles zuklappen
- einzelne Angebote aufklappen
- einzelne Angebote zuklappen
- Bildergalerie nach links/rechts
- Kontakt aufnehmen (weiterleitung)

## Hilfe

- Problem aufklappen
- Problem zuklappen
- FAQ lesen

## Nachrichten
  
- Wenn schon bekannt: 
    - Verlauf anzeigen
    - schreiben + posten als Interessent
    - schreiben + posten als Verkäufer
- Wenn neu:
    - als Interessent Absender angeben
    - schreiben + posten als Interessent

## Impressum

- Verantwortlichkeiten nachvollziehen
- DSGVO, Was wird wie verarbeitet

# Views & Programmfluss

![Figure [graph]: Programmfluss mit Views](http://g.gravizo.com/svg?
 digraph G {
    Start_www [shape="ellipse"];
    Start_email [shape="ellipse"];
    Kategorien [shape=rect margin="0.25,0.1"];
    Inserate [shape=rect margin="0.25,0.1"];
    InserateEditor [shape=rect margin="0.25,0.1"];
    Nachrichten [shape=rect margin="0.25,0.1"];
    Hilfe [shape=rect margin="0.25,0.1"];
    Impressum[shape=rect margin="0.25,0.1"];
    Start_www -> Kategorien;
    Kategorien -> Inserate;
    Kategorien -> Impressum;
    Kategorien -> InserateEditor;
    Kategorien -> Hilfe;
    Inserate -> Nachrichten;
    Inserate -> Impressum;
    Inserate -> Hilfe;
    Inserate -> Kategorien;
    Nachrichten -> Kategorien;
    Nachrichten -> Impressum;
    Nachrichten -> Inserate [label="?"];
    InserateEditor -> Kategorien;
    Hilfe -> Kategorien;
    Hilfe -> Impressum;
    Impressum -> Hilfe;
    Impressum -> Kategorien;
    Start_email -> InserateEditor;
    Start_email -> Nachrichten;
})
