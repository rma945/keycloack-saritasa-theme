<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="SSO applications page">
  <meta name="author" content="RomanCherednikov">
  <meta name="robots" content="noindex, nofollow">
  <title>${msg("loginTitle",(realm.displayName!''))}</title>
  <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
  <#if properties.styles?has_content>
    <#list properties.styles?split( ' ') as style>
      <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
    </#list>
  </#if>
  <#if properties.scripts?has_content>
    <#list properties.scripts?split( ' ') as script>
      <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
    </#list>
  </#if>
  <#if scripts??>
    <#list scripts as script>
      <script src="${script}" type="text/javascript"></script>
    </#list>
  </#if>
</head>

<div class="center-block">
  <img src="${url.resourcesPath}/img/logo.png" class="img-responsive" alt="${properties.logoText!}">
</div>

<body id=login-body>
  <div class="container-fluid">
    <div class="login-form">
      <div class="main-div">
        <div class="panel">
          <p>Please enter your LDAP credentials</p>
        </div>
        <#if message?has_content>
          <div class="alert
          <#if message.type = 'success'>alert-success</#if>
          <#if message.type = 'warning'>alert-warning</#if>
          <#if message.type = 'error'>alert-danger</#if>
          <#if message.type = 'info'>alert-info</#if>
          "
          role="alert">${message.summary?no_esc}</div>
        </#if>
        <form id="Login" action="${url.loginAction}" method="post">
          <div class="form-group">
            <input class="form-control" name="username" id="username" placeholder="Username">
          </div>
          <div class="form-group">
            <input type="password" name="password" class="form-control" id="password" placeholder="Password">
          </div>
          <#if realm.rememberMe && !usernameEditDisabled??>
            <div class="float-left">
              <label>
                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" <#if login.rememberMe??>checked</#if>> Remember me
              </label>
            </div>
          </#if>
          <button type="submit" class="btn btn-primary">Login</button>
        </form>
      </div>
      <p class="botto-text">© 2018 Saritasa, LLC. All Rights Reserved. </p>
    </div>
  </div>
  </div>
</body>
</html>
