<%--

 Copyright (C) 2009 by the geOrchestra PSC

 This file is part of geOrchestra.

 geOrchestra is free software: you can redistribute it and/or modify it under
 the terms of the GNU General Public License as published by the Free
 Software Foundation, either version 3 of the License, or (at your option)
 any later version.

 geOrchestra is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 more details.

 You should have received a copy of the GNU General Public License along with
 geOrchestra.  If not, see <http://www.gnu.org/licenses/>.

--%>

<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="org.georchestra._header.Utf8ResourceBundle" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%
Boolean anonymous = true;

/*
response.setDateHeader("Expires", 31536000);
response.setHeader("Cache-Control", "private, max-age=31536000");
*/

// to prevent problems with proxies, and for now:
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies.

String active = request.getParameter("active");
if (active == null) {
    active = "none";
}

Locale rLocale = request.getLocale();
ResourceBundle bundle = org.georchestra._header.Utf8ResourceBundle.getBundle("_header.i18n.index", rLocale);

String detectedLanguage = rLocale.getLanguage();
String forcedLang = request.getParameter("lang");

String lang = (String) request.getAttribute("defaultLanguage");
if (forcedLang != null) {
    if (forcedLang.equals("en") || forcedLang.equals("es") || forcedLang.equals("ru") || forcedLang.equals("fr") || forcedLang.equals("de") || forcedLang.equals("nl")) {
        lang = forcedLang;
	 } 
} else {
    if (detectedLanguage.equals("en") || detectedLanguage.equals("es") || detectedLanguage.equals("ru") || detectedLanguage.equals("fr") || detectedLanguage.equals("de") || detectedLanguage.equals("nl")) {
        lang = detectedLanguage;
    } 
}
String longLang = lang;

switch(lang) {
  case "en":
    longLang = "eng";
    break;
  case "es":
    longLang = "spa";
    break;
  case "fr":
    longLang = "fre";
    break;
  case "de":
    longLang = "ger";
    break;
  case "nl":
    longLang = "dut";
    break;
  default:
    longLang = "eng";
}


javax.servlet.jsp.jstl.core.Config.set(
    request,
    javax.servlet.jsp.jstl.core.Config.FMT_LOCALIZATION_CONTEXT,
    new javax.servlet.jsp.jstl.fmt.LocalizationContext(bundle)
);

Boolean extractor = false;
Boolean admin = false;
Boolean catadmin = false;
Boolean console = false;
Boolean analyticsadmin = false;
Boolean extractorappadmin = false;
Boolean msadmin = false;
String sec_roles = request.getHeader("sec-roles");
if(sec_roles != null) {
    String[] roles = sec_roles.split(";");
    for (int i = 0; i < roles.length; i++) {
        if (roles[i].equals("ROLE_GN_EDITOR") || roles[i].equals("ROLE_GN_REVIEWER") || roles[i].equals("ROLE_GN_ADMIN") || roles[i].equals("ROLE_ADMINISTRATOR") || roles[i].equals("ROLE_USER")) {
            anonymous = false;
        }
        if (roles[i].equals("ROLE_SUPERUSER")) {
            admin = true;
            console = true;
        }
        if (roles[i].equals("ROLE_ORGADMIN")) {
            admin = true;
            console = true;
        }
        if (roles[i].equals("ROLE_GN_ADMIN")) {
            admin = true;
            catadmin = true;
        }
        if (roles[i].equals("ROLE_ADMINISTRATOR")) {
            admin = true;
            extractorappadmin = true;
        }
        if (roles[i].equals("ROLE_MAPSTORE_ADMIN")) {
            admin = true;
            msadmin = true;
        }
    }
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <base target="_parent" />
    <style type="text/css">
   /* see https://github.com/georchestra/georchestra/issues/147 for missing http protocol 
*/

@import url('https://fonts.googleapis.com/css2?family=Barlow:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');
/* 
	Variables 
	Définition de la couleur du header
*/
:root {
	--color-nav: #1d1a3d;
}

/* Propriétés globales */

* {
	box-sizing: border-box;
}

body {
	margin: 0px;
	font-family: 'Barlow', sans-serif;
}

/* 
	Thème Dark 
	Header avec fond coloré
*/

.dark .nav-primary {
	background-color: var(--color-nav);
}

.dark .nav-primary>.nav-header>.nav-title {
	color: #fff;
}

.dark .nav-primary>.nav-apps a,
.dark .nav-primary>.nav-user a {
	color: #fff;
}

.dark .nav-primary>.nav-apps>a:hover {
	background-color: rgba(255, 255, 255, 0.129);
}

.dark .nav-apps a.active {
    background-color: rgba(255, 255, 255, 0.129);
    border-radius: 4px;
}

.dark .btn-connect a{
	background-color: #ffffff;
	color: var(--color-nav)!important;
}

.dark .btn-user-icon {
	background-color: #ffffff;
}

/* 
	Thème Light 
	Header avec fond blanc et élements colorés
*/

.light .nav-primary {
	background-color: #fff;
}

.light .nav-primary>.nav-header>.nav-title {
	color: var(--color-nav);
}

.light .nav-primary>.nav-apps a,
.light .nav-primary>.nav-user a {
	color: var(--color-nav);
}

.light .nav-primary>.nav-apps>a:hover {
	background-color: var(--color-nav);
	color: #fff;
}

.light .nav-apps a.active {
    background-color: var(--color-nav);
	color: #fff;
    border-radius: 4px;
}

.light .btn-connect a{
	background-color: var(--color-nav);
	color: #fff!important;
}

.light .btn-user-icon {
	background-color: var(--color-nav);
}

/* ---- */

/* Propriétés de la navbar */

.nav {
	height: 80px;
}

.nav-primary {
	height: 100%;
	width: 100%;
	position: relative;
	padding: 1.1rem 0;
	display: inline-flex;
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-pack: justify;
	-ms-flex-pack: justify;
	justify-content: space-around;
	-webkit-box-align: stretch;
	-ms-flex-align: stretch;
	align-items: stretch;
}

.nav-primary>.nav-header {
	display: inline;
}

/* Titre */

.nav-primary>.nav-header>.nav-title {
	display: inline-flex;
	font-size: 18px;
	padding: 10px 10px 10px 10px;
}

.nav-title-text {
	padding: 2px 8px;
}

/* Boutons navbar */

.nav-primary>.nav-btn {
	display: none;
}

.nav-primary>.nav-apps,
.nav-primary>.nav-user {
	display: flex;
    font-size: 17px;
    align-items: center;
}

.nav-primary>.nav-apps a {
	display: inline-block;
	padding: 13px 10px 13px 10px;
	text-decoration: none;
}

.nav-primary>.nav-user a {
	display: inline-block;
    padding: 10px 12px;
    text-decoration: none;
}

.nav-primary>.nav-apps>a:hover {
	border-radius: 4px;
}


.nav-primary>#nav-check {
	display: none;
}

/* Btn connect */

.btn-connect {
    margin: 0;
}
.btn-connect a{
	font-weight: 600;
	border-radius: 5px;
}

.btn-connect a:hover {
	opacity: 0.8;
}

/* Btn user */

#btn-user {
	display: flex;
	margin-right: 25px;
}

#btn-user p {
    margin: 0;
}

.btn-user-icon {
	-webkit-mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath d='M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z'/%3E%3C/svg%3E") no-repeat 0% 52%;
	-webkit-mask-size: 20px;
	width: 20px;
}

#btn-user a:hover {
	text-decoration: revert;
}


/* Navbar Admin tools */
.nav-admin {
	background-color: #f4f4f4;
	height: 25px;
	justify-content: space-between;
	display: flex;
	padding: 0rem 1rem;
}

.nav-admin a {
	color: #777;
	font-size: 14px;
	text-decoration: none;
	padding: 3px 1rem;
}

.nav-admin-link a:hover {
	background-color: rgba(119, 119, 119, 0.436);
}

.nav-admin-link a.active {
	background-color: rgba(119, 119, 119, 0.436);
}

.nav-admin-title {
	display: flex;
}

.nav-admin span {
	color: #777;
	font-size: 15px;
	text-decoration: none;
	font-weight: 600;
}

.nav-admin-title-icon {
	background-color: #777;
	-webkit-mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath d='M9.405 1.05c-.413-1.4-2.397-1.4-2.81 0l-.1.34a1.464 1.464 0 0 1-2.105.872l-.31-.17c-1.283-.698-2.686.705-1.987 1.987l.169.311c.446.82.023 1.841-.872 2.105l-.34.1c-1.4.413-1.4 2.397 0 2.81l.34.1a1.464 1.464 0 0 1 .872 2.105l-.17.31c-.698 1.283.705 2.686 1.987 1.987l.311-.169a1.464 1.464 0 0 1 2.105.872l.1.34c.413 1.4 2.397 1.4 2.81 0l.1-.34a1.464 1.464 0 0 1 2.105-.872l.31.17c1.283.698 2.686-.705 1.987-1.987l-.169-.311a1.464 1.464 0 0 1 .872-2.105l.34-.1c1.4-.413 1.4-2.397 0-2.81l-.34-.1a1.464 1.464 0 0 1-.872-2.105l.17-.31c.698-1.283-.705-2.686-1.987-1.987l-.311.169a1.464 1.464 0 0 1-2.105-.872l-.1-.34zM8 10.93a2.929 2.929 0 1 1 0-5.86 2.929 2.929 0 0 1 0 5.858z' /%3E%3C/svg%3E") no-repeat 0% 43%;
	-webkit-mask-size: 15px;
	width: 20px;
}

/* Propriétés en mode connecté avec affichage de la barre d'admin */

.nav.admin-user>.nav-primary {
	height: 55px;
	padding: 0.5rem 0;
}

.nav.admin-user>.nav-admin {
	display: flex !important;
}

/* Responsive */
@media (max-width:900px) {
	.dark #btn-connect {
		background-color: #ffffff;
	}

	.light #btn-connect {
		background-color: var(--color-nav);
	}

	.light .nav-primary .nav-apps a:hover {
		color: var(--color-nav) !important;
	}

	.nav-primary .nav-apps {
		font-size: 12px;
		position: absolute;
		bottom: 1px;
		width: 100%;
		justify-content: space-around;
	}

	.nav-primary {
		padding: 0 !important;
		justify-content: space-between;
	}

	.nav-user {
		font-size: 13px !important;
		height: 45px;
	}

	.nav-admin span {
		display: none;
	}

	.btn-connect {
		-webkit-mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath d='M11 1a2 2 0 0 0-2 2v4a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h5V3a3 3 0 0 1 6 0v4a.5.5 0 0 1-1 0V3a2 2 0 0 0-2-2z' /%3E%3C/svg%3E") no-repeat 0% 43%;
		-webkit-mask-size: 18px;
		width: 18px;
		margin: 0 15px 0 0;
	}

	.btn-connect:hover {
		opacity: 0.8;
	}

	#btn-connect span {
		display: none;
	}

	.admin-user .nav-title {
		padding: 5px !important;
	}

	.admin-user .nav-primary .nav-apps {
		height: 35px !important;
		font-size: 12px;
	}

	.nav-primary .nav-apps a:hover {
		background-color: #ffffff00 !important;
		text-decoration: underline;
	}
}
</style>
</head>
<body>
    <c:choose>
        <c:when test='<%= admin == true %>'> 
            <div class="nav admin-user dark">
        </c:when>
        <c:otherwise>
            <div class="nav dark">                   
        </c:otherwise>
    </c:choose>    
        <!-- Navbar admin --> 
        <c:choose>
              <c:when test='<%= admin == true %>'> 
              <div class="nav-admin"> 
                  <div class="nav-admin-title">
                      <div class="nav-admin-title-icon"></div>
                      <span>Outils d'administration</span>
                  </div>
                  <div class="nav-admin-link">
                      <!-- Catalogue-->
                      <c:choose>
                           <c:when test='<%= catadmin == true %>'>
                              <c:choose>
                                 <c:when test='<%= active.equals("geonetwork") %>'>
                                      <a class="active" href="/geonetwork/srv/<%= longLang %>/admin.console">
                                          <fmt:message key="catalogue"/>
                                       </a>
                                 </c:when>
                                 <c:otherwise>
                                       <a href="/geonetwork/srv/<%= longLang %>/admin.console">
                                          <fmt:message key="catalogue"/>
                                       </a>
                                 </c:otherwise>
                              </c:choose>
                           </c:when>
                      </c:choose>
                      <!-- Visualiseur -->
                      <c:choose>
                           <c:when test='<%= msadmin == true %>'>
                              <c:choose>
                                 <c:when test='<%= active.equals("msadmin") %>'>
                                       <a class="active">
                                          <fmt:message key="viewer"/>
                                       </a>
                                 </c:when>
                                 <c:otherwise>
                                       <a href="/mapstore/#/admin">
                                          <fmt:message key="viewer"/>
                                       </a>
                                 </c:otherwise>
                              </c:choose>
                           </c:when>
                        </c:choose>
                        <!-- Analytics -->
                        <c:choose>
                           <c:when test='<%= console == true %>'>
                              <c:choose>
                                 <c:when test='<%= active.equals("analytics") %>'>
                                    <a class="active" href="/analytics/">Analytics</a>
                                 </c:when>
                                 <c:otherwise>
                                    <a href="/analytics/">Analytics</a>
                                 </c:otherwise>
                              </c:choose>
                           </c:when>
                        </c:choose>
                        <!-- Utilisateurs -->
                        <c:choose>
                           <c:when test='<%= console == true %>'>
                              <c:choose>
                                 <c:when test='<%= active.equals("console") %>'>
                                       <a class="active" href="${consolePublicContextPath}/manager/"><fmt:message key="users"/></a>
                                 </c:when>
                                 <c:otherwise>
                                       <a href="${consolePublicContextPath}/manager/">
                                          <fmt:message key="users"/>
                                       </a>
                                 </c:otherwise>
                              </c:choose>
                           </c:when>
                        </c:choose>
                  </div>          
              </div> 
              </c:when>
        </c:choose>
        <!-- Navbar des apps -->
        <div class="nav-primary">
          <div class="nav-header">
            <div class="nav-title">
              <img src="img/jDev.logo_globe.white.png" alt="" width="30">
              <div class="nav-title-text">Jdev</div>
            </div>
          </div>
          <div class="nav-apps">
             <!--Home
             <c:choose>
               <c:when test='<%= active.equals("accueil") %>'>
                  <a id="go_home" class="active" href="/accueil" title="<fmt:message key='go.home'/>">Accueil</a>
               </c:when>
               <c:otherwise>
                  <a id="go_home" class="" href="/accueil" title="<fmt:message key='go.home'/>">Accueil</a>
               </c:otherwise>
            </c:choose>--> 
            <!--Catalogue--> 
            <c:choose>
              <c:when test='<%= active.equals("geonetwork") %>'>
                 <a class="active" href="/geonetwork/" id="catalogue"><fmt:message key="catalogue"/></a>
              </c:when>
              <c:otherwise>
                  <a class="" href="/geonetwork/" id="catalogue"><fmt:message key="catalogue"/></a>
              </c:otherwise>
           </c:choose>
           <!--Viewer--> 
           <c:choose>
              <c:when test='<%= active.equals("mapstore") %>'>
                 <a class="active" href="/mapstore/#/" id="map"><fmt:message key="viewer"/></a>
              </c:when>
              <c:otherwise>
                <a class="" href="/mapstore/#/" id="map"><fmt:message key="viewer"/></a>
              </c:otherwise>
           </c:choose>
           <!--Cartes--> 
           <c:choose>
              <c:when test='<%= active.equals("mapstore-home") %>'>
                 <a class="active" href="/mapstore/#/home" id="maps"><fmt:message key="maps"/></a>
              </c:when>
              <c:otherwise>
                  <a class="" href="/mapstore/#/home" id="maps"><fmt:message key="maps"/></a>
              </c:otherwise>
           </c:choose>
           <!--Applications--> 
           <c:choose>
              <c:when test='<%= active.equals("mviewer") %>'>
                 <a class="active" href="https://jdev.fr/resources/mviewer_catalog.html" id="mviewer">Applications</a>
              </c:when>
              <c:otherwise>
                 <a class="" href="https://jdev.fr/resources/mviewer_catalog.html" id="mviewer">Applications</a>
              </c:otherwise>
           </c:choose>
           <!--Service--> 
           <c:choose>
              <c:when test='<%= active.equals("geoserver") %>'>
                 <a class="active" href="/geoserver/web/" id="geoserver"><fmt:message key="services"/></a>
              </c:when>
              <c:otherwise>
                 <a class="" href="/geoserver/web/" id="geoserver"><fmt:message key="services"/></a>
              </c:otherwise>
           </c:choose>
          </div>
  
          <!-- Connexion et profil utilisateur-->
          <div class="nav-user">
            <c:choose>
                <c:when test='<%= anonymous == false %>'>
                    <div id="btn-user">
                        <div class="btn-user-icon"></div>
                        <p class="logged" >
                            <a href="${consolePublicContextPath}/account/userdetails"><%=request.getHeader("sec-username") %></a>                                                       
                        </p>
                    </div> 
                    <p class="logged btn-connect">
                        <a href="/logout"><fmt:message key="logout"/></a>
                    </p>
                </c:when>
                <c:otherwise>
                      <p class="logged btn-connect">
                        <a id="login_a"><fmt:message key="login"/></a>
                      </p>                    
                </c:otherwise>
            </c:choose>
          </div>
        </div>
        <!-- /.Navbar des apps -->
      </div>
    <script>
       (function(){
           // required to get the correct redirect after login, see https://github.com/georchestra/georchestra/issues/170
           var url,
               a = document.getElementById("login_a"),
               cnxblk = document.querySelector('p.logged');
           if (a !== null) {
               url = parent.window.location.href;
               if (/\/cas\//.test(url)) {
                   a.href = "/?login";
               } else if (/\/geoserver\/web\/\?0/.test(url)) {
                   a.href = "/geoserver/web/?login";
               } else {
                   // removing any existing anchor from URL first:
                   // see https://github.com/georchestra/georchestra/issues/1032
                   var p = url.split('#', 2),
                   /* Taken from https://github.com/openlayers/openlayers/blob/master/lib/OpenLayers/Util.js#L557 */
                   paramStr = "login", parts = (p[0] + " ").split(/[?&]/);
                   a.href = p[0] + (parts.pop() === " " ?
                       paramStr :
                       parts.length ? "&" + paramStr : "?" + paramStr) +
                       // adding potential anchor
                       (p.length == 2 ? "#" + p[1] : "");
               }
           }
       
       })();
    </script>
 </body>
</html>
