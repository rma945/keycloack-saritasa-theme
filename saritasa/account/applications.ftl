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
    <div class="card-header" id="heading-${groupName}">
      <h5 class="mb-0">
        <button class="btn btn-link <#if collapsed == "true"> collapsed</#if>" type="button" data-toggle="collapse" data-target="#collapse-${groupName}" aria-expanded="${collapsed}" aria-controls="collapse-${groupName}">
          <b>${groupName}</b>
        </button>
      </h5>
    </div>
    <div id="collapse-${groupName}" class="collapse<#if collapsed == "false"> show</#if>"  aria-labelledby="headingOne" data-parent="#appAccordion">
      <div class="card-body container-fluid">
        <!-- draw application buttons start -->
        <div class="row mx-5">
            <#list appDict[groupName] as app>
              <#if app.client.description?has_content && app.client.description != 'hide'>
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

                <div class="col-md-3 my-2" data-toggle="app-popover" data-trigger="hover" title="<b>${AppName}</b>" data-content=
                "
                <#list app.realmRolesAvailable as role>
                  <#if role.description??>
                    ${advancedMsg(role.description)}<br>
                  <#else>
                    ${advancedMsg(role.name)}<br>
                  </#if>
                </#list>
                ">
                  <a target="_blank" rel="noopener noreferrer" href="${app.effectiveUrl}">
                    <div class="card mb-3 shadow-sm pt-3">
                      <img class="card-img-top" src="${url.resourcesPath}/icon/${icon}">
                      <div class="card-body">
                        <p class="card-text text-center text-truncate">${AppName}</p>
                      </div>
                    </div>
                  </a>
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
    <#if properties.mainApp?has_content && appDict[properties.mainApp]??>
      <@drawAppList groupName=properties.mainApp collapsed="false"/>
    </#if>
    <#if appDict['Other']??>
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

  <script>
    $(document).ready(function(){
      $('[data-toggle="app-popover"]').popover({html: true});
    });
  </script>
</@layout.mainLayout>
