<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Каталог Ресторанти</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="style.css" />
      </head>
      <script>
        function showRestaurants() {
        document.getElementById('restaurantsContainer').style.display = 'inline';
        document.getElementById('chainsContainer').style.display = 'none';
        };
        function showChains() {
        document.getElementById('restaurantsContainer').style.display = 'none';
        document.getElementById('chainsContainer').style.display = 'inline';
        };
        function showTypes() {
        document.getElementById('restaurantsContainer').style.display = 'none';
        document.getElementById('chainsContainer').style.display = 'none';
        document.getElementById('typesContainer').style.display = 'inline';
        document.getElementById('citiesContainer').style.display = 'none';
        }
        function showCities() {
        document.getElementById('restaurantsContainer').style.display = 'none';
        document.getElementById('chainsContainer').style.display = 'none';
        document.getElementById('typesContainer').style.display = 'none';
        document.getElementById('citiesContainer').style.display = 'inline';
        }
      </script>
      <body>
        <h1> Ресторанти в България</h1>
        <div id="menu">
          <button class="button" onclick="showRestaurants();">
            Ресторанти
          </button>
          <button class="button" onclick="showChains()">
            Вериги
          </button>

          <button class="button" onclick="showTypes()">
            Видове
          </button>
          <button class="button" onclick="showCities()">
            Градове
          </button>
        </div>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>


  <xsl:template match="/restaurantsCatalog/restaurantList">
    <div id="restaurantsContainer" class="container">
      <div class="row">
        <xsl:for-each select="/restaurantsCatalog/restaurantList/restaurant[id &lt; 11]">
          <xsl:sort
            select="numSeats"
            data-type="number"
            order="descending"/>

          <div style="color:white;" class="restaurant col-md-8 container">
            <div class="presentation col-md-4">
              <p id="restaurantName">
                <xsl:value-of select="name"/>
              </p>
              <xsl:variable name="picture" select="@location"/>
              <img src="images/{picture}.jpg"/>
            </div>


            <div id="restaurantDetail" class="col-md-3">
              <p id="label" >Град</p>
              <p>
                <xsl:value-of select="city"/>
              </p>
              <p id="label">Адрес</p>
              <p>
                <xsl:value-of select="address"/>
              </p>
              <p id="label">Телефон</p>
              <p>
                <xsl:value-of select="phone"/>
              </p>
              <p id="label">Брой места</p>
              <p>
                <xsl:value-of select="numSeats"/>
              </p>
            </div>
            <div id="extraInfo" class="col-md-5">
              <p id="label" >Уебсайт</p>
              <p>
                <a href="{website/@href}">
                  <xsl:value-of select="website"/>
                </a>
              </p>
              <p id="label" >Ценова категория</p>
              <p>
                <xsl:value-of select="priceCategory"/>
              </p>
              <div class="dropdown col-md-2">
                <p id="label">Типове кухня</p>
                <div class="dropdown-content">
                  <xsl:for-each select="types/type">
                    <p id="type">
                      <xsl:value-of select="."/>
                    </p>
                  </xsl:for-each>
                </div>
              </div>
              <div class="dropdown col-md-2">
                <p id="label">Услуги</p>
                <div class="dropdown-content">
                  <xsl:for-each select="services/service">
                    <p id="service">
                      <xsl:value-of select="."/>
                    </p>
                  </xsl:for-each>
                </div>
              </div>
            </div>


          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>


  <xsl:template match="/restaurantsCatalog/chainList">
    <div id="chainsContainer" style="display:none;" class="container">
        <xsl:for-each select="/restaurantsCatalog/chainList/chainInfo">
          <div class="restaurant container" style="display:block;">
          
            <xsl:variable name="chainId" select="@chainIdRef"/>
          
          <div id="chainLabel" class="row">
            <xsl:value-of select="@chainNameRef"/>
          </div>
                
              <div class="row container">
                <xsl:for-each select="/restaurantsCatalog/restaurantList/restaurant[chainId = $chainId]">
                  <div class="row container">
                    <div class="presentation">
                      <p id="restaurantName">
                        <xsl:value-of select="name"/>
                      </p>
                      <xsl:variable name="picture" select="@location"/>
                      <img src="images/{picture}.jpg"/>
                    </div>

                    <div id="restaurantDetail">
                      <p id="label" >Град</p>
                      <p>
                        <xsl:value-of select="city"/>
                      </p>
                      <p id="label">Адрес</p>
                      <p>
                        <xsl:value-of select="address"/>
                      </p>
                      <p id="label">Телефон</p>
                      <p>
                        <xsl:value-of select="phone"/>
                      </p>
                      <p id="label">Брой места</p>
                      <p>
                        <xsl:value-of select="numSeats"/>
                      </p>
                    </div>
                    <div id="extraInfo">
                      <p id="label" >Уебсайт</p>
                      <p>
                        <a href="{website/@href}">
                          <xsl:value-of select="website"/>
                        </a>
                      </p>
                      <p id="label" >Ценова категория</p>
                      <p>
                        <xsl:value-of select="priceCategory"/>
                      </p>
                    </div>
                    <div class="dropdown">
                      <p id="label">Типове кухня</p>
                      <div class="dropdown-content">
                        <xsl:for-each select="../types/type">
                          <p id="type">
                            <xsl:value-of select="."/>
                          </p>
                        </xsl:for-each>
                      </div>
                    </div>

                  </div>

                </xsl:for-each>
              </div>
</div>
        </xsl:for-each>
      </div>
  </xsl:template>

</xsl:stylesheet>

