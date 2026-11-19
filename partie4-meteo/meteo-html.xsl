<?xml version="1.0" encoding="UTF-8"?>
<!-- Météo : XML -> HTML (un tableau par date + statistiques XPath) -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Températures</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 30px; }
          table { border-collapse: collapse; width: 60%; margin-bottom: 10px; }
          th, td { border: 1px solid #444; padding: 6px 10px; text-align: left; }
          th { background: #fff200; }
          .stats { margin-bottom: 30px; }
        </style>
      </head>
      <body>
        <h1>Mesures des températures</h1>
        <xsl:for-each select="meteo/mesure">
          <h2>Températures à la date : <xsl:value-of select="@date"/></h2>
          <table>
            <tr><th>Ville</th><th>Température (°C)</th></tr>
            <xsl:for-each select="ville">
              <tr>
                <td><xsl:value-of select="@nom"/></td>
                <td><xsl:value-of select="@temperature"/></td>
              </tr>
            </xsl:for-each>
          </table>
          <div class="stats">
            Moyenne : <b><xsl:value-of select="format-number(sum(ville/@temperature) div count(ville), '0.0')"/> °C</b> &#8212;
            Maximum : <b><xsl:value-of select="ville[not(@temperature &lt; ../ville/@temperature)][1]/@nom"/>
              (<xsl:value-of select="ville[not(@temperature &lt; ../ville/@temperature)][1]/@temperature"/> °C)</b> &#8212;
            Minimum : <b><xsl:value-of select="ville[not(@temperature &gt; ../ville/@temperature)][1]/@nom"/>
              (<xsl:value-of select="ville[not(@temperature &gt; ../ville/@temperature)][1]/@temperature"/> °C)</b>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
