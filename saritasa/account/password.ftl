<#import "template.ftl" as layout>
  <@layout.mainLayout active='password' bodyClass='password' ; section>

    <div class="row">
      <div class="col-md-10">
        <h2>Update password</h2>
      </div>
    </div>

    <form action="${url.passwordUrl}" class="form-horizontal" method="post">
      <input type="text" id="username" name="username" value="${(account.username!'')}" autocomplete="username" readonly="readonly" style="display:none;">

      <#if password.passwordSet>
        <div class="form-group">
          <div class="col-sm-2 col-md-2">
            <label for="password" class="control-label">Current password</label>
          </div>

          <div class="col-sm-4 col-md-4">
            <input type="password" class="form-control" id="password" name="password" autofocus autocomplete="current-password">
          </div>
        </div>
      </#if>

      <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

      <div class="form-group">
        <div class="col-sm-2 col-md-2">
          <label for="password-new" class="control-label">New password</label>
        </div>

        <div class="col-sm-4 col-md-4">
          <input type="password" class="form-control" id="password-new" name="password-new" autocomplete="new-password">
        </div>
      </div>

      <div class="form-group">
        <div class="col-sm-2 col-md-2">
          <label for="password-confirm" class="control-label" class="two-lines">Confirm password</label>
        </div>

        <div class="col-sm-4 col-md-4">
          <input type="password" class="form-control" id="password-confirm" name="password-confirm" autocomplete="new-password">
        </div>
      </div>

      <div class="form-group">
        <div id="kc-form-buttons" class="col-md-offset-2 col-md-10 submit">
          <button type="submit" class="btn btn-primary" name="submitAction" value="Save">Save</button>
        </div>
      </div>
    </form>

  </@layout.mainLayout>
