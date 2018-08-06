<#macro mainLayout active bodyClass>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="SSO login page">
    <meta name="author" content="RomanCherednikov">
    <meta name="robots" content="noindex, nofollow">

    <title>
      <#if properties.logoText?has_content>
        ${properties.logoText}
      <#else>
        SSO
      </#if>
    </title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico">
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script type="text/javascript" src="${url.resourcesPath}/${script}"></script>
        </#list>
    </#if>
</head>
<body class="admin-console user ${bodyClass}">

<!-- Navigation bar -->
  <nav class="navbar px-5 navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" style="color:white">
      <img src="${url.resourcesPath}/img/logo.png" width="64" height="30" class="d-inline-block align-top">
      <#if properties.logoText?has_content>
        ${properties.logoText}
      </#if>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown px-5">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Menu
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">

            <a class="dropdown-item" href="${url.applicationsUrl}">Applications</a>
            <#if realm.userManagedAccessAllowed && features.authorization>
              <a class="dropdown-item" href="${url.resourceUrl}">Resources</a>
            </#if>
            <a class="dropdown-item" href="${url.sessionsUrl}">Sessions</a>
            <a class="dropdown-item" href="${url.totpUrl}">OTP</a>
            <#if features.log>
              <a class="dropdown-item" href="${url.logUrl}">Logs</a>
            </#if>
            <a class="dropdown-item" href="${url.logoutUrl}">Sign Out</a>
          </div>
        </li>
      </ul>
    </div>
  </nav>

  <div class="container">
      <div class="col-xs-12 content-area">
          <#if message?has_content>
              <div class="alert alert-${message.type}">
                  <#if message.type=='success' ><span class="pficon pficon-ok"></span></#if>
                  <#if message.type=='error' ><span class="pficon pficon-error-octagon"></span><span class="pficon pficon-error-exclamation"></span></#if>
                  ${message.summary?no_esc}
              </div>
          </#if>

          <#nested "content">
      </div>
  </div>

</body>
</html>
</#macro>
