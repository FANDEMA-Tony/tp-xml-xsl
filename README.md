# Activité Pratique N°1 : XML, DTD, XSD, XSL, XPath

Master 1 Big Data & Cloud Computing, cours de M. Youssfi.

## Contenu

| Dossier | Contenu |
|---|---|
| `partie1-biblio/` | `biblio.dtd`, `biblio.xml`, `biblio.xsl`, `biblio.html` (résultat), `arbre-biblio.svg/png` |
| `partie2-operateur/` | `operateur.dtd`, `operateur.xml`, `operateur.xsl`, `operateur.html`, `arbre-operateur.svg/png` |
| `partie4-meteo/` | `meteo.dtd`, `meteo-dtd.xml`, `meteo.xsd`, `meteo-xsd.xml`, `meteo-html.xsl`, `meteo-svg.xsl`, `meteo.html`, `meteo.svg` (histogramme animé), `arbre-meteo-schema.*`, `arbre-meteo-instance.*` |
| `transformer.py` | Valide et transforme tout, sans Oxygen |

## Correspondance avec l'énoncé de la partie 4 (Météo)

1. Arbre XML : `arbre-meteo-schema` (structure) et `arbre-meteo-instance` (exemple).
2. DTD : `meteo.dtd`.
3. XML valide (DTD) : `meteo-dtd.xml`.
4. Schéma XML : `meteo.xsd`.
5. XML valide (schéma) : `meteo-xsd.xml`.
6. XSL vers HTML : `meteo-html.xsl`, résultat `meteo.html`.
7. XSL vers SVG animé : `meteo-svg.xsl`, résultat `meteo.svg` (ouvrir dans un navigateur : les barres montent en 1,5 s).

## Choix de conception

- **DTD** : l'élément racine se précise dans le `<!DOCTYPE meteo SYSTEM "meteo.dtd">`. Les types sont limités à `CDATA`, `ID`, `NMTOKEN` et aux énumérations. Les attributs `rendu`, `regle` et `type` utilisent une énumération avec valeur par défaut, comme dans la démonstration du cours.
- **XSD** : `date` est de type `xs:date` et `temperature` est un `xs:decimal` borné entre -60 et 60. Deux contraintes `xs:unique` interdisent une même ville deux fois dans une mesure et une même date deux fois.
- **Dates** : `2006-1-1` est valide pour la DTD (simple `CDATA`) mais **refusé par le XSD** (format `AAAA-MM-JJ` obligatoire). Le fichier `meteo-xsd.xml` utilise donc `2006-01-01`. C'est la différence DTD / XSD que le cours souligne.
- **XSLT 1.0** : les feuilles fonctionnent avec Oxygen, Saxon, lxml et les navigateurs. XPath 1.0 n'a pas `avg()`, donc la moyenne s'écrit `sum(...) div count(...)`.
- **XPath utilisé** : `count()`, `sum()`, filtres `[@rendu='non']`, `//` (n'importe quel niveau), `@` (attribut), `format-number()`.
- Les feuilles de style ne sont pas liées avec `<?xml-stylesheet?>` : comme le dit M. Youssfi, les navigateurs récents bloquent ce mécanisme. On applique la transformation avec un scénario (Oxygen) ou avec `transformer.py`.

## Exécuter le TP

**Avec Python (Windows, gratuit)**
```
pip install lxml
python transformer.py
```
Ouvrir ensuite les fichiers `.html` et `.svg` dans le navigateur.

**Avec VS Code** : extension *XML* (Red Hat) pour la validation DTD/XSD. Pour XSLT, extension *XSLT/XPath* (DeltaXignia), commande *XSLT: Quick Run*.

**Avec Oxygen** : *Configurer le scénario de transformation*, XML = le fichier `.xml`, XSL = la feuille correspondante, sortie HTML (ou XML pour le SVG).

**Avec xmllint (Linux/Mac)**
```
xmllint --noout --valid partie4-meteo/meteo-dtd.xml
xmllint --noout --schema partie4-meteo/meteo.xsd partie4-meteo/meteo-xsd.xml
```
