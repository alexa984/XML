<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/> 
  
  <xsl:template match="/">
    <html>
	<head>
	<title>Университети в България</title>

	<link rel="stylesheet" type="text/css" href="style.css" />
	</head>
	<script>
		function showUniversities() {
			document.getElementById('universityContainer').style.display = 'inline';
            document.getElementById('branchContainer').style.display = 'none';
			document.getElementById('regionContainer').style.display = 'none';
    };
		function showBranches() {
            document.getElementById('universityContainer').style.display = 'none';
            document.getElementById('branchContainer').style.display = 'inline';
			document.getElementById('regionContainer').style.display = 'none';
    };
		function showRegions() {
            document.getElementById('universityContainer').style.display = 'none';
            document.getElementById('branchContainer').style.display = 'none';
			document.getElementById('regionContainer').style.display = 'inline';
    }
  </script>
	<body>
	<h1> Университети в България</h1>
	<button class="button" onclick="showUniversities();">
			Университети
  	</button>
  	<button class="button" onclick="showBranches()">
			Филиали
  	</button>
	<button class="button" onclick="showRegions()">
			Региони
  	</button>
       <xsl:apply-templates/>
    </body></html>
  </xsl:template>

  
  <xsl:template match="/unisInBG/universityList">
    <div id="universityContainer">
    	<xsl:for-each select="/unisInBG/universityList/university/uniInformation[id &lt; 11]">
				<xsl:sort
					select = "students"
					data-type="number"
					order = "descending">
				</xsl:sort>

				<div style="color:white;" class="university">
				
					<img src="images/{id}.jpg"/>

					<p id="uniName"><xsl:value-of select="name"/></p>
					
					<div id="uniInfo">
						<p id="label" >Седалище</p>
						<p><xsl:value-of select="location"/></p>
						<p id="label">Регион</p>
						<p><xsl:value-of select="region"/></p>
					</div>
					<div id="extraInfo">
						<p id="label" >Година</p>
						<p><xsl:value-of select="year"/></p>
						<p id="label" >Студенти</p>
						<p><xsl:value-of select="students"/></p>
					</div>
					<div id="contacts">
						<p id="label" >Тел</p>
						<p><xsl:value-of select="telephone"/></p>
					<xsl:if test="telephoneExtra">
						<p id="label" >Доп.тел</p>
						<p><xsl:value-of select="telephoneExtra"/></p>
					</xsl:if>
					</div>
					<div id="online">
						<p id="label" >Сайт</p>
						<a href="{site/@href}"><xsl:value-of select="site"/></a>
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
  </xsl:template>

<xsl:template match="/unisInBG/branchList">
    <div id="branchContainer" style="display:none;">
  		<xsl:for-each select="/unisInBG/branchList/branch">
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
</xsl:template>

</xsl:stylesheet>
