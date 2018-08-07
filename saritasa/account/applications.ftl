<#import "template.ftl" as layout>

<#function createAppList appList>
  <#local result={"Other": []}>
  <#list applications.applications as application>
    <#if application.effectiveUrl?has_content>
      <#if application.client.name?has_content && application.client.name?contains(" ")>
        <#local groupName = application.client.name?keep_before(" ")>
        <#if !result[groupName]??>
          <#local result = result + { groupName:  [application]}>
        <#else>
          <#local appList = result[groupName] + [application] >
          <#local result = result + { groupName:  appList}>
        </#if>
      <#else>
        <#local appList = result["Other"] + [application]>
        <#local result = result + { "Other": appList}>
      </#if>
    </#if>
  </#list>
  <#return result>
</#function>

<#macro drawAppList groupName collapsed="true">
  <div class="card">
    <div class="card-header <#if collapsed == "true"> collapsed</#if>" id="heading-${groupName}" data-toggle="collapse" data-target="#collapse-${groupName}" aria-expanded="${collapsed}" aria-controls="collapse-${groupName}">
      <h5 class="mb-0">
        <b class="text-primary">${groupName}</b>
      </h5>
    </div>
    <div id="collapse-${groupName}" class="collapse<#if collapsed == "false"> show</#if>"  aria-labelledby="headingOne" data-parent="#appAccordion">
      <div class="card-body container-fluid">
        <!-- draw application buttons start -->
        <div class="row mx-5">
            <#list appDict[groupName] as app>
              <#if app.client.description?has_content && app.client.description?contains('hide')>
              <#else>
                <#if app.client.name?has_content>
                  <#local AppName = app.client.name>
                  <#local tmpAppName = app.client.name?lower_case>
                  <#if tmpAppName?contains("aws")>
                    <#local icon = 'aws.png'>
                  <#elseif tmpAppName?contains("vpository")>
                    <#local icon = 'vpository.png'>
                  <#elseif tmpAppName?contains("keycloak")>
                    <#local icon = 'keycloak.png'>
                  <#elseif tmpAppName?contains("jenkins")>
                    <#local icon = 'jenkins.png'>
                  <#else>
                    <#local icon = 'default.png'>
                  </#if>
                <#else>
                  <#local AppName = app.client.clientId>
                  <#local icon = 'default.png'>
                </#if>

                <div class="col-md-3 my-2"
                <#if app.resourceRolesAvailable?has_content>
                  data-toggle="app-popover" data-trigger="hover" title="<b>${AppName}</b>"
                  data-content=
                  "
                  <#list app.resourceRolesAvailable?keys as resource>
                      <#list app.resourceRolesAvailable[resource] as clientRole>
                          <#if clientRole.roleDescription??>
                            ${advancedMsg(clientRole.roleDescription)}<br>
                          <#else>
                            ${advancedMsg(clientRole.roleName)}<br>
                          </#if>
                      </#list>
                  </#list>
                  ">
                </#if>
                  <!-- card start -->
                  <div class="card mb-3 shadow-sm pt-3">
                    <#if icon?contains('aws')>
                      <div class="card-img-top text-right px-2">
                        <span data-id="${app.client.clientId}" class="badge badge-primary aws-cli-badge" data-toggle="modal" data-target="#aws-cli-modal">cli</span>
                      </div>
                      <input type="hidden" id="json-${app.client.clientId}" value='{"clientid":"${app.client.clientId}", "clienturl":"${url.accountUrl?replace("account","protocol/saml/clients")}${app.client.clientId}"}'>
                    <#else>
                      <div style="padding: 12px"></div>
                    </#if>
                    <a target="_blank" rel="noopener noreferrer" href="${app.effectiveUrl}">
                      <img class="card-img-top" src="${url.resourcesPath}/icon/${icon}">
                      <div class="card-body">
                        <p class="card-text text-center text-truncate">${AppName}</p>
                      </div>
                    </a>
                  </div>
                  <!-- card end -->
                </div>
              </#if>
            </#list>
        </div>
        <!-- draw application buttons end -->
      </div>
    </div>
  </div>
</#macro>

<@layout.mainLayout active='applications' bodyClass='applications'; section>
  <#global appDict = createAppList(applications.applications)>

  <div class="accordion" id="appAccordion">
    <#if properties.mainApp?has_content && appDict[properties.mainApp]?has_content>
      <@drawAppList groupName=properties.mainApp collapsed="false"/>
    </#if>
    <#if appDict['Other']?has_content>
      <@drawAppList groupName="Other" collapsed="true"/>
    </#if>

    <#list appDict?keys as groupName>
      <#if properties.mainApp?has_content && groupName == properties.mainApp>
        <!-- stupid skip action -->
      <#elseif groupName == "Other">
        <!-- stupid skip action -->
      <#else>
        <@drawAppList groupName=groupName collapsed="true"/>
      </#if>
    </#list>
  </div>


  <!-- aws cli modal start -->
  <div class="modal fade" id="aws-cli-modal" tabindex="-1" role="dialog" aria-labelledby="aws-cli-modal-label" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="aws-cli-modal-label">AWS CLi usage</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          Download and install  <a href="https://github.com/Versent/saml2aws/releases">saml2aws</a> cli utility.<br>
          Launch <b>saml2aws</b> for generate a new configuration for <b class=aws-modal-client-id>ClienID</b>:<br>
          <br>
          <div style="background-color:#ececec; padding:10px">
            saml2aws configure -a <b class=aws-modal-client-id>ClienID</b> \<br>
            --idp-provider KeyCloak \<br>
            --username <b>${(account.username!'')}</b> \<br>
            --url <b id=aws-modal-client-url>client-url</b> \<br>
            --mfa=Auto \<br>
            --skip-prompt<br>
          </div>
          <br>
          Issue a new temporary AWS Cli credentials:
          <div style="background-color:#ececec; padding:10px">
            saml2aws login -a <b class=aws-modal-client-id>ClienID</b>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary mx-auto" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <!-- aws cli modal end -->

  <script>
    $(document).ready(function(){
      $('[data-toggle="app-popover"]').popover({html: true});

      $('.aws-cli-badge').click(function() {
        var target = "#json-" + $(this).data("id");
        var json_data = JSON.parse($(target).val())

        $('.aws-modal-client-id').each(function() {
          $(this).text(json_data.clientid);
        });
        $('#aws-modal-client-url').text(json_data.clienturl)
      })
    });
  </script>
</@layout.mainLayout>
