"""Valide et transforme les documents du TP (alternative gratuite à Oxygen).

Prérequis : Python 3 + `pip install lxml`
Usage     : python transformer.py        (depuis le dossier tp-xml-xsl)
"""
from pathlib import Path
from lxml import etree

BASE = Path(__file__).parent


def valider_dtd(xml):
    parser = etree.XMLParser(dtd_validation=True)
    try:
        etree.parse(str(BASE / xml), parser)
        print(f"[DTD ] {xml} : valide")
    except etree.XMLSyntaxError as e:
        print(f"[DTD ] {xml} : INVALIDE -> {e}")


def valider_xsd(xml, xsd):
    schema = etree.XMLSchema(etree.parse(str(BASE / xsd)))
    doc = etree.parse(str(BASE / xml))
    if schema.validate(doc):
        print(f"[XSD ] {xml} : valide")
    else:
        print(f"[XSD ] {xml} : INVALIDE -> {schema.error_log.last_error}")


def transformer(xml, xsl, sortie):
    resultat = etree.XSLT(etree.parse(str(BASE / xsl)))(etree.parse(str(BASE / xml)))
    (BASE / sortie).write_bytes(bytes(resultat))
    print(f"[XSLT] {xml} + {xsl} -> {sortie}")


if __name__ == "__main__":
    # Partie 1 : Biblio
    valider_dtd("partie1-biblio/biblio.xml")
    transformer("partie1-biblio/biblio.xml", "partie1-biblio/biblio.xsl", "partie1-biblio/biblio.html")
    # Partie 2 : Opérateur télécom
    valider_dtd("partie2-operateur/operateur.xml")
    transformer("partie2-operateur/operateur.xml", "partie2-operateur/operateur.xsl", "partie2-operateur/operateur.html")
    # Partie 4 : Météo
    valider_dtd("partie4-meteo/meteo-dtd.xml")
    valider_xsd("partie4-meteo/meteo-xsd.xml", "partie4-meteo/meteo.xsd")
    transformer("partie4-meteo/meteo-xsd.xml", "partie4-meteo/meteo-html.xsl", "partie4-meteo/meteo.html")
    transformer("partie4-meteo/meteo-xsd.xml", "partie4-meteo/meteo-svg.xsl", "partie4-meteo/meteo.svg")
