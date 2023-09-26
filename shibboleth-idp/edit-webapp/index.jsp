<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title><spring:message code="root.title" text="Shibboleth IdP" /></title>
    <link rel="stylesheet" type="text/css" href="https://cdn.ncsu.edu/brand-assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.ncsu.edu/shibboleth/css/style_405.css">
  </head>

  <body>
    <div class="wrapper">
      <div class="container">

    <div class="bs-header">
      <div class="container heading-content">
       <header role="banner">
         <div class="row">
           <div class="col-md-12">
             <img src="<spring:message code="idp.logo" />" alt="<spring:message code="idp.logo.alt-text" text="logo" />">
           </div>
         </div>
       </header>
      </div>
    </div>

        <div class="content">
          <h2><spring:message code="root.message" text="No services are available at this location." /></h2>
        </div>
      </div>

    <footer class="container" role="contentinfo">
      <div class="group page-footer">
        <div class="row">
          <div class="col-md-12">
            <div class="shib-footer-red">
              <spring:message code="root.footer" text="Insert your footer text here." />
            </div>
          </div>
        </div>
      </div>
    </footer>

    </div>

  </body>
</html>
