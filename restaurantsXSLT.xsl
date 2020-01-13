<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/> 
  
  <xsl:template match="/">
    <html>
	<head>
	<title>Каталог Ресторанти</title>

	<link rel="stylesheet" type="text/css" href="style.css" />
	</head>
	<body>
	<h1> Ресторанти в България</h1>
	<button class="button" onclick="showRestaurants();">
			Ресторанти
  	</button>
  	<button class="button" onclick="showChains()">
			Вериги
  	</button>

	  <button class="button" onclick="showTypes()">
			Видове ресторанти
  	</button>
	<button class="button" onclick="showCities()">
			Градове
  	</button>
       <xsl:apply-templates/>
    <script>
      function showRestaurants() {
      document.getElementById('restaurantsContainer').style.display = 'inline';
      document.getElementById('chainsContainer').style.display = 'none';
      document.getElementById('typesContainer').style.display = 'none';
      document.getElementById('citiesContainer').style.display = 'none';
      };
      function showChains() {
      document.getElementById('restaurantsContainer').style.display = 'none';
      document.getElementById('chainsContainer').style.display = 'inline';
      document.getElementById('typesContainer').style.display = 'none';
      document.getElementById('citiesContainer').style.display = 'none';
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
    </body></html>
  </xsl:template>

  
  <xsl:template match="/restaurantsCatalog/restaurantsList">
    <div id="restaurantsContainer">
    	<xsl:for-each select="/restaurantsCatalog/restaurantsList/restaurant[id &lt; 11]">
				<xsl:sort
					select="numSeats"
					data-type="number"
					order="descending"/>

				<div style="color:white;" class="restaurant">
				
					<img src="images/{id}.jpg"/>

					<p id="restaurantName"><xsl:value-of select="name"/></p>
					
					<div id="restaurantDetail">
						<p id="label" >Град</p>
						<p><xsl:value-of select="city"/></p>
						<p id="label">Адрес</p>
						<p><xsl:value-of select="address"/></p>
						<p id="label">Телефон</p>
						<p><xsl:value-of select="phone"/></p>
						<p id="label">Брой места</p>
						<p><xsl:value-of select="numSeats"/></p>
					</div>
					<div id="extraInfo">
						<p id="label" >Уебсайт</p>
						<p><a href="{website/@href}"><xsl:value-of select="website"/></a></p>
						<p id="label" >Ценова категория</p>
						<p><xsl:value-of select="priceCategory"/></p>
					</div>
					<div class="dropdown">
						<p id="label">Типове кухня</p>
						<div class="dropdown-content">
							<xsl:for-each select="../types/type">
								<p id="type"><xsl:value-of select="."/></p>
							</xsl:for-each>
						</div>
					</div>
				
				</div> 
  		</xsl:for-each>
  	</div>
  </xsl:template>
<!-- 
<xsl:template match="/restaurantsCatalog/chainList">
    <div id="chainContainer" style="display:none;">
  		<xsl:for-each select="/restaurantsCatalog/chainList/chain">
				<xsl:variable name="sName"><xsl:value-of select="seatName"/></xsl:variable>
				<xsl:variable name="sId"><xsl:value-of select="uni/@idRef"/></xsl:variable>

		<div style="color:white;" class="branch">
		<div>
						<p id="seatLabel"><xsl:value-of select="seatName"/>
						</p>
					</div>
					<div>
						<xsl:for-each select="/unisInBG/universityList/university/uniInformation[name =$sName and id != $sId]">
															
									<div style="color:white;" class="specialBranch">
										<img src="images/{id}.jpg"/>
										
										<p id="branchName"><xsl:value-of select="branchName"/></p>
				
										<div id="branchInfo">
											<p id="label" >Седалище</p>
											<p><xsl:value-of select="location"/></p>
											<p id="label" >Регион</p>
											<p><xsl:value-of select="region"/></p>
											<p id="label" >Година</p>
											<p><xsl:value-of select="year"/></p>
										</div>
										<div id="branchContacts">
											<p id="label" >Тел</p>
											<p><xsl:value-of select="telephone"/></p>
										<xsl:if test="telephoneExtra">
											<p id="label" >Доп.тел</p>
											<p><xsl:value-of select="telephoneExtra"/></p>
										</xsl:if>
										<xsl:if test="site">
											<p id="label" >Сайт</p>
											<a href="{site/@href}"><xsl:value-of select="site"/></a>
										</xsl:if>
										</div>
					
										<div class="dropdown">
											<p id="label">Факултети</p>
											<div class="dropdown-content">
												<xsl:for-each select="../facultyList/faculty">
													<p id="faculty"><xsl:value-of select="."/></p>
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

<xsl:template match="/unisInBG/regionList">
    <div id="regionContainer" style="display:none;">
  		<xsl:for-each select="/unisInBG/regionList/regionInfo">
				<xsl:variable name="rName"><xsl:value-of select="regionName"/></xsl:variable>
				<xsl:variable name="rId"><xsl:value-of select="reg/@regIdRef"/></xsl:variable>

		<div style="color:white;" class="region">

				<p id="regionLabel"><xsl:value-of select="regionName"/></p>
					<div>
						<xsl:for-each select="/unisInBG/universityList/university/uniInformation[regionId = $rId]">
															
									<div style="color:white;" class="specialRegion">
									
										<img src="images/{id}.jpg"/>

										<p id="uniName"><xsl:value-of select="name"/></p>
										<xsl:if test="branchName">
											<p id="branchName"><xsl:value-of select="branchName"/></p>
										</xsl:if>
										<div id="regInfo">
											<p id="label" >Седалище</p>
											<p><xsl:value-of select="location"/></p>
											<p id="label" >Година</p>
											<p><xsl:value-of select="year"/></p>
										<xsl:if test="students">
											<p id="label" >Студенти</p>
											<p><xsl:value-of select="students"/></p>
										</xsl:if>
										</div>
										<div id="uniContacts">
											<p id="label" >Тел</p>
											<p><xsl:value-of select="telephone"/></p>
										<xsl:if test="telephoneExtra">
											<p id="label" >Доп.тел</p>
											<p><xsl:value-of select="telephoneExtra"/></p>
										</xsl:if>
										<xsl:if test="site">
											<p id="label" >Сайт</p>
											<a href="{site/@href}"><xsl:value-of select="site"/></a>
										</xsl:if>
										</div>
					
										<div class="dropdown">
											<p id="label">Факултети</p>
											<div class="dropdown-content">
												<xsl:for-each select="../facultyList/faculty">
													<p id="faculty"><xsl:value-of select="."/></p>
												</xsl:for-each>
											</div>
										</div>
									</div>

						</xsl:for-each>
					</div>
		</div>
		</xsl:for-each>
	</div>
</xsl:template> -->

<!--</body>-->
</xsl:stylesheet>

