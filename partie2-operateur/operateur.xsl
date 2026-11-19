<?xml version="1.0" encoding="UTF-8"?>
<!-- Opérateur : pour chaque client, abonnements + total des factures, puis statistiques globales -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Opérateur télécom</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 30px; }
          table { border-collapse: collapse; width: 90%; margin-bottom: 25px; }
          th, td { border: 1px solid #444; padding: 6px 10px; text-align: left; }
          th { background: #dde6f5; }
          .stats td { background: #f6f6f6; font-weight: bold; }
        </style>
      </head>
      <body>
        <h2>Liste des clients</h2>
        <xsl:for-each select="operateur/client">
          <h3>Client : <xsl:value-of select="@nom"/> (<xsl:value-of select="@code"/>)</h3>
          <table>
            <tr>
              <th>Numéro</th><th>Type</th><th>Date d'abonnement</th><th>Total des factures</th>
            </tr>
            <xsl:for-each select="abonnement">
              <tr>
                <td><xsl:value-of select="@numero"/></td>
                <td><xsl:value-of select="@type"/></td>
                <td><xsl:value-of select="@date"/></td>
                <td><xsl:value-of select="sum(facture/@montant)"/></td>
              </tr>
            </xsl:for-each>
            <tr class="stats">
              <td colspan="3">Nombre d'abonnements</td>
              <td><xsl:value-of select="count(abonnement)"/></td>
            </tr>
          </table>
        </xsl:for-each>

        <h2>Statistiques globales</h2>
        <ul>
          <li>Nombre de clients : <xsl:value-of select="count(operateur/client)"/></li>
          <li>Nombre d'abonnements : <xsl:value-of select="count(operateur/client/abonnement)"/></li>
          <li>Nombre d'abonnements GSM : <xsl:value-of select="count(//abonnement[@type='GSM'])"/></li>
          <li>Total de toutes les factures : <xsl:value-of select="sum(//facture/@montant)"/></li>
          <li>Total des factures non réglées : <xsl:value-of select="sum(//facture[@regle='non']/@montant)"/></li>
          <li>Moyenne des montants des factures :
              <xsl:value-of select="format-number(sum(//facture/@montant) div count(//facture), '0.00')"/></li>
        </ul>
        <h2>Client C1 uniquement</h2>
        <xsl:for-each select="operateur/client[@code='C1']">
          <p><xsl:value-of select="@nom"/> : <xsl:value-of select="count(abonnement)"/> abonnements,
             total <xsl:value-of select="sum(abonnement/facture/@montant)"/></p>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
