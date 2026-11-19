<?xml version="1.0" encoding="UTF-8"?>
<!-- Météo : XML -> histogramme SVG animé (un histogramme par date) -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- Paramètres de dessin -->
  <xsl:variable name="echelle" select="10"/>   <!-- 1 °C = 10 px -->
  <xsl:variable name="pas" select="100"/>      <!-- écart entre deux barres -->
  <xsl:variable name="largeurBarre" select="40"/>
  <xsl:variable name="base" select="350"/>     <!-- ordonnée de l'axe des abscisses -->
  <xsl:variable name="hauteurBloc" select="420"/>

  <xsl:template match="/meteo">
    <svg width="{60 + count(mesure[1]/ville) * $pas}"
         height="{count(mesure) * $hauteurBloc}">
      <xsl:for-each select="mesure">
        <g transform="translate(0,{(position() - 1) * $hauteurBloc})">

          <!-- Titre -->
          <text x="60" y="30" font-family="Arial" font-size="22" font-weight="bold">
            Températures à la date : <xsl:value-of select="@date"/>
          </text>

          <!-- Lignes de repère à 10, 20 et 30 °C -->
          <xsl:call-template name="repere"><xsl:with-param name="niveau" select="10"/><xsl:with-param name="largeur" select="60 + count(ville) * $pas"/></xsl:call-template>
          <xsl:call-template name="repere"><xsl:with-param name="niveau" select="20"/><xsl:with-param name="largeur" select="60 + count(ville) * $pas"/></xsl:call-template>
          <xsl:call-template name="repere"><xsl:with-param name="niveau" select="30"/><xsl:with-param name="largeur" select="60 + count(ville) * $pas"/></xsl:call-template>

          <!-- Axes -->
          <line x1="50" y1="{$base}" x2="{60 + count(ville) * $pas}" y2="{$base}"
                stroke="black" stroke-width="2"/>
          <line x1="50" y1="{$base}" x2="50" y2="50" stroke="black" stroke-width="2"/>
          <polygon points="50,40 44,55 56,55" fill="black"/>
          <text x="20" y="35" font-family="Arial" font-size="15">T°</text>

          <!-- Barres animées -->
          <xsl:for-each select="ville">
            <xsl:variable name="x" select="70 + (position() - 1) * $pas"/>
            <xsl:variable name="h" select="@temperature * $echelle"/>
            <rect x="{$x}" y="{$base - $h}" width="{$largeurBarre}" height="{$h}"
                  fill="yellow" stroke="blue" stroke-width="2">
              <animate attributeName="height" from="0" to="{$h}" dur="1.5s" fill="freeze"/>
              <animate attributeName="y" from="{$base}" to="{$base - $h}" dur="1.5s" fill="freeze"/>
            </rect>
            <!-- Valeur au-dessus de la barre -->
            <text x="{$x + $largeurBarre div 2}" y="{$base - $h - 8}" text-anchor="middle"
                  font-family="Arial" font-size="14" fill="blue">
              <xsl:value-of select="@temperature"/>°
            </text>
            <!-- Nom de la ville sous la barre -->
            <text x="{$x + $largeurBarre div 2}" y="{$base + 25}" text-anchor="middle"
                  font-family="Arial" font-size="14" fill="blue">
              <xsl:value-of select="@nom"/>
            </text>
          </xsl:for-each>
        </g>
      </xsl:for-each>
    </svg>
  </xsl:template>

  <!-- Ligne de repère horizontale et son étiquette -->
  <xsl:template name="repere">
    <xsl:param name="niveau"/>
    <xsl:param name="largeur"/>
    <line x1="50" x2="{$largeur}" y1="{$base - $niveau * $echelle}" y2="{$base - $niveau * $echelle}"
          stroke="#cccccc" stroke-dasharray="4"/>
    <text x="10" y="{$base - $niveau * $echelle + 5}" font-family="Arial" font-size="13">
      <xsl:value-of select="$niveau"/>°
    </text>
  </xsl:template>
</xsl:stylesheet>
