<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
    <xsl:strip-space elements="*"/>
	<xsl:param name="dateReport" select="'date not defined'"/>
	<xsl:param name="projectName" select="'project name not defined'"/>
	<xsl:param name="version" select="'project name not defined'"/>
    <xsl:template match="/testResults">
        <html lang="en">
        <head>
            <meta name="Author" content="shanhe.me"/>
			<link rel="shortcut icon" href="/js/favicon.png"/>
            <title>API Test Results</title>
			<style type="text/css"><![CDATA[
				body        { font-family: verdana, arial, helvetica, sans-serif; font-size: 80%; }
				
				/* -- heading ---------------------------------------------------------------------- */
				h1 {
					font-size: 16pt;
					color: gray;
				}
				
				.heading .attribute {
					margin-top: 1ex;
					margin-bottom: 0;
				}
								
				#div_base {
							position:absolute;
							top:0%;
							left:5%;
							right:5%;
							width: auto;
							height: auto;
							margin: -15px 0 0 0;
				}
				
				.detail {
					display: none
				}
				
				.well {
					  background-repeat:repeat;
					  -webkit-border-radius: 6px;
					  -moz-border-radius: 6px;
					  border-radius: 6px;
					}

				.nav .nav-header {
					font-size: 18px;
					color:#FF9900;
				}
		   /* -- left-panel ---------------------------------------------------------------------- */
				.col-md-4{
					max-height: 550px;
                    overflow-y: auto;
					margin-top:20px
				}
				
			/* -- right-panel ---------------------------------------------------------------------- */
				.col-md-8 {
					background:#f5f5f5
				}
				
				.group { 
					font-weight: bold; 
				}
				
				.table-striped{
					table-layout:fixed;
					white-space: normal;
					word-break:break-all; 
					align :right
				}
				.success { color: #565b60 }
                .failure { color: red }
            ]]></style>
			<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css"/>  
			<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
			<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
			<script type="text/javascript" src="/js/searchcase.js"></script>
			<script src="/js/jquery-1.11.3.min.js"></script>
			<script src="/js/pagelayout.js"></script>
			<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        </head>
        <body>
			<div id="div_base">
				<div class="container-fluid">		
						<div class="row-fluid">
							<div class="col-md-12">
								<div id="heading">
									<h1>API Test Results</h1>
									<p class='attribute'><strong>Date report: </strong> <xsl:value-of select="$dateReport" /></p>
									<p class='attribute'><strong>Project name: </strong>  <xsl:value-of select="$projectName" /></p>
									<p class='attribute'><strong>Version: </strong> <xsl:value-of select="$version" /></p>
								</div>
								<div id="summary">
									<xsl:call-template name="summary" />
								</div>
								<div class="form-inline">  
								   <input type="text" id="key-word" class="form-control" style="width:30%;margin:0px 20px 0px 20px;" placeholder="  请输入用例名称"/>
								   <button id="search-button" class="btn btn btn-primary">查询</button> 
								</div> 	
							</div> 
						</div> 
				</div> 
                <div class="container-fluid">		
					<div class="row-fluid">
							<div id="left-panel" class="col-md-4">
								<div class="well sidebar-nav">
									<ul id="result-list" class="nav nav-list">
										<xsl:for-each select="*">
										<xsl:if test="position() = 1 or @tn != preceding-sibling::*[1]/@tn">
											<li class="nav-header"><xsl:value-of select="@tn"/></li>
										</xsl:if>
										<li class="active" onclick="return onclick_li(this, {position()});">
											<div>
												<xsl:attribute name="class">
													<xsl:choose>
														<xsl:when test="@s = 'true'">success option-text</xsl:when>
														<xsl:otherwise>failure option-text</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
												<xsl:value-of select="@lb"/>
											</div>
											<div class="detail">
												<div class="group">Sampler</div>
												<div class="zebra">
													<table class="table table-striped">
														<tr><td class="data key">Thread Name</td><td class="data"><xsl:value-of select="@tn"/></td></tr>
														<tr><td class="data key">Timestamp</td><td class="data"><span class="patch_timestamp"><xsl:value-of select="@ts"/></span></td></tr>
														<tr><td class="data key">Time</td><td class="data"><xsl:value-of select="@t"/> ms</td></tr>
														<tr><td class="data key">Latency</td><td class="data"><xsl:value-of select="@lt"/> ms</td></tr>
														<tr><td class="data key">Bytes</td><td class="data"><xsl:value-of select="@by"/></td></tr>
														<tr><td class="data key">Sample Count</td><td class="data"><xsl:value-of select="@sc"/></td></tr>
														<tr><td class="data key">Error Count</td><td class="data"><xsl:value-of select="@ec"/></td></tr>
														<tr><td class="data key">Response Code</td><td class="data"><xsl:value-of select="@rc"/></td></tr>
														<tr><td class="data key">Response Message</td><td class="data"><xsl:value-of select="@rm"/></td></tr>
													</table>
												</div>
												<div class="trail"></div>
												<xsl:if test="count(assertionResult) &gt; 0">
													<div class="group">Assertion</div>
													<div class="zebra">
														<table class="table table-striped">
															<xsl:for-each select="assertionResult">
																<tbody>
																	<xsl:attribute name="class">
																		<xsl:choose>
																			<xsl:when test="failure = 'true'">failure</xsl:when>
																			<xsl:when test="error = 'true'">failure</xsl:when>
																		</xsl:choose>
																	</xsl:attribute>
																	<tr><td class="data assertion" colspan="3"><xsl:value-of select="name"/></td></tr>
																	<tr><td class="data key">Failure</td><td class="data"><xsl:value-of select="failure"/></td></tr>
																	<tr><td class="data key">Error</td><td class="data"><xsl:value-of select="error"/></td></tr>
																	<tr><td class="data key">Failure Message</td><td class="data"><xsl:value-of select="failureMessage"/></td></tr>
																</tbody>
															</xsl:for-each>
														</table>
													</div>
												<div class="trail"></div>
												</xsl:if>
												<div class="group">Request</div>
												<div class="zebra">
													<table class="table table-striped">
														<tr><td class="data key">Method/Url</td><td class="data"><pre class="data"><xsl:value-of select="method"/><xsl:text> </xsl:text><xsl:value-of select="java.net.URL"/></pre></td></tr>
														<tr><td class="data key">Query String</td><td class="data"><pre class="data"><xsl:value-of select="queryString"/></pre></td></tr>
														<tr><td class="data key">Cookies</td><td class="data"><pre class="data"><xsl:value-of select="cookies"/></pre></td></tr>
														<tr><td class="data key">Request Headers</td><td class="data"><pre class="data"><xsl:value-of select="requestHeader"/></pre></td></tr>
													</table>
												</div>
												<div class="trail"></div>
												<div class="group">Response</div>
												<div class="zebra">
													<table class="table table-striped">
														<tr><td class="data key">Response Headers</td><td class="data"><pre class="data"><xsl:value-of select="responseHeader"/></pre></td></tr>
														<!-- <tr><td class="data key">Response Data</td><td class="data"><pre id='RawJson{position()}' class="data"><xsl:value-of select="responseData"/></pre></td></tr> -->
														<tr><td class="data key">Response File</td><td class="data"><pre class="data"><xsl:value-of select="responseFile"/></pre></td></tr>
														<!-- <tr><td class="data key">JSON Data Format</td><td><div id="Canvas{position()}" class="Canvas"></div></td></tr> -->
														<tr><td class="data key">Response Data</td><td><div id="Canvas{position()}" class="Canvas"><xsl:value-of select="responseData"/></div></td></tr>
													</table>
												</div>
												<div class="trail"></div>
											</div>
										</li>
										</xsl:for-each>
									</ul>
								</div>
				        </div>
						<div id="right-panel" class="col-md-8" style="max-height:550px; overflow-y:auto;margin-top:20px"></div>
					</div>
				</div>
			</div>
        </body>
        </html>
    </xsl:template>
	
	<xsl:template name="summary">
		<table class="table">
			<tr >
				<th>Samples</th>
				<th>Failures</th>
				<th>Success Rate</th>
				<th>Average Time</th>
				<th>Min Time</th>
				<th>Max Time</th>
			</tr>
			<tr >
				<xsl:variable name="testTime" select="/testResults/*/@t/.." />

				<xsl:variable name="allCount" select="count(/testResults/*)" />
				<xsl:variable name="allFailureCount" select="count(/testResults/*[attribute::s='false'])" />
				<xsl:variable name="allSuccessCount" select="count(/testResults/*[attribute::s='true'])" />
				<xsl:variable name="allSuccessPercent" select="$allSuccessCount div $allCount" />
				<xsl:variable name="allTotalTime" select="sum(/testResults/*/@t)" />
				<xsl:variable name="allAverageTime" select="$allTotalTime div $allCount" />
				<xsl:variable name="allMinTime">
					<xsl:call-template name="min">
						<xsl:with-param name="nodes" select="/testResults/*/@t" />
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="allMaxTime">
					<xsl:call-template name="max">
						<xsl:with-param name="nodes" select="/testResults/*/@t" />
					</xsl:call-template>
				</xsl:variable>
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="$allFailureCount &gt; 0">Failure</xsl:when>
					</xsl:choose>
				</xsl:attribute>
				<td >
					<xsl:value-of select="$allCount" />
				</td>
				<td style="cursor:pointer" class="fail">
					<xsl:value-of select="$allFailureCount" />
				</td>
				<td >
					<xsl:call-template name="display-percent">
						<xsl:with-param name="value" select="$allSuccessPercent" />
					</xsl:call-template>
				</td>
				<td >
					<xsl:call-template name="display-time">
						<xsl:with-param name="value" select="$allAverageTime" />
					</xsl:call-template>
				</td>
				<td >
					<xsl:choose>
						<xsl:when test="not($testTime)">NaN66666</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="$testTime">
								<xsl:sort data-type="number" />
								<xsl:if test="position() = 1">
									<xsl:value-of select="number(.)" />
								</xsl:if>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:call-template name="display-time">
						<xsl:with-param name="value" select="$allMinTime" />
					</xsl:call-template>
				</td>
				<td >
					<xsl:call-template name="display-time">
						<xsl:with-param name="value" select="$allMaxTime" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="min">
	<xsl:param name="nodes" />
	<xsl:choose>
		<xsl:when test="not($nodes)">NaN66666</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="$nodes">
				<xsl:sort data-type="number" />
<!--				<xsl:if test="position() = 1">-->
					<xsl:value-of select="number($nodes)" />
<!--				</xsl:if>-->
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>
	<xsl:template name="max">
		<xsl:param name="nodes" select="." />
		<xsl:choose>
			<xsl:when test="not($nodes)">NaN</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$nodes">
					<xsl:sort data-type="number" order="descending" />
					<xsl:if test="position() = 1">
						<xsl:value-of select="number(.)" />
					</xsl:if>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="display-percent">
		<xsl:param name="value" />
		<xsl:value-of select="format-number($value,'0.00%')" />
	</xsl:template>

	<xsl:template name="display-time">
			<xsl:param name="value" />
			<xsl:value-of select="format-number($value,'0 ms')" />
		</xsl:template>
	</xsl:stylesheet>