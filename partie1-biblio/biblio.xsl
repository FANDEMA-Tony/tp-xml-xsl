<?xml version="1.0" encoding="UTF-8"?>
<!-- Biblio : liste des livres NON rendus par étudiant + statistiques XPath -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Bibliothèque</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 30px; }
          table { border-collapse: collapse; width: 90%; margin-bottom: 25px; }
          th, td { border: 1px solid #444; padding: 6px 10px; text-align: left; }
          th { background: #dde6f5; }
          .stats td { background: #f6f6f6; font-weight: bold; }
        </style>
      </head>
      <body>
        <h1>Liste des emprunts de la bibliothèque</h1>
        <xsl:for-each select="biblio/etudiant">
          <h2><xsl:value-of select="@prenom"/>&#160;<xsl:value-of select="@nom"/>
              (code <xsl:value-of select="@code"/>, <xsl:value-of select="@age"/> ans)</h2>
          <h3>Livres non rendus</h3>
          <table>
            <tr><th>ID</th><th>Titre</th><th>Date d'emprunt</th><th>Rendu</th></tr>
            <xsl:for-each select="livre[@rendu='non']">
              <tr>
                <td><xsl:value-of select="@id"/></td>
                <td><xsl:value-of select="@titre"/></td>
                <td><xsl:value-of select="@date"/></td>
                <td><xsl:value-of select="@rendu"/></td>
              </tr>
            </xsl:for-each>
            <tr class="stats">
              <td colspan="3">Nombre de livres empruntés</td>
              <td><xsl:value-of select="count(livre)"/></td>
            </tr>
            <tr class="stats">
              <td colspan="3">Nombre de livres rendus</td>
              <td><xsl:value-of select="count(livre[@rendu='oui'])"/></td>
            </tr>
            <tr class="stats">
              <td colspan="3">Nombre de livres non rendus</td>
              <td><xsl:value-of select="count(livre[@rendu='non'])"/></td>
            </tr>
          </table>
        </xsl:for-each>
        <h3>Bilan général</h3>
        <ul>
          <li>Nombre d'étudiants : <xsl:value-of select="count(biblio/etudiant)"/></li>
          <li>Nombre total d'emprunts : <xsl:value-of select="count(//livre)"/></li>
          <li>Livres non rendus : <xsl:value-of select="count(//livre[@rendu='non'])"/></li>
          <li>Étudiants ayant au moins un livre non rendu :
              <xsl:value-of select="count(biblio/etudiant[livre/@rendu='non'])"/></li>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
