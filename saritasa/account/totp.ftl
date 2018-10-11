<#import "template.ftl" as layout>
  <@layout.mainLayout active='totp' bodyClass='totp' ; section>

    <#if totp.enabled>
      <h2>OTP Authenticator</h2>

      <table class="table table-bordered table-striped">
        <thead>
          <tr>
            <th colspan="2">Configured Authenticators</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="provider">Mobile</td>
            <td class="action">
              <form action="${url.totpUrl}" method="post" class="form-inline">
                <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
                <input type="hidden" id="submitAction" name="submitAction" value="Delete">
                <button id="remove-mobile" class="btn btn-default"><i class="pficon pficon-delete"></i></button>
              </form>
            </td>
          </tr>
        </tbody>
      </table>
      <#else>
        <h2>OTP Authenticator</h2>

        <hr/>

        <ol>
          <li>
            <p>Install OTP client</p>

            <ul>
              <#list totp.policy.supportedApplications as app>
                <li>${app}</li>
              </#list>
            </ul>
          </li>

          <#if mode?? && mode="manual">
            <li>
              <p>Open the application and enter the key</p>
              <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
              <p><a href="${totp.qrUrl}" id="mode-barcode">Scan barcode?</a></p>
            </li>
            <li>
              <p>Use the following configuration values if the application allows setting them</p>
              <ul>
                <li id="kc-totp-type">Type: ${msg("totp." + totp.policy.type)}</li>
                <li id="kc-totp-algorithm">Algorithm: ${totp.policy.getAlgorithmKey()}</li>
                <li id="kc-totp-digits">Digits: ${totp.policy.digits}</li>
                <#if totp.policy.type="totp">
                  <li id="kc-totp-period">Interval: ${totp.policy.period}</li>
                  <#elseif totp.policy.type="hotp">
                    <li id="kc-totp-counter">Counter: ${totp.policy.initialCounter}</li>
                </#if>
              </ul>
            </li>
            <#else>
              <li>
                <p>Open the application and scan the barcode</p>
                <p><img src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"></p>
                <p><a href="${totp.manualUrl}" id="mode-manual">Unable to scan?</a></p>
              </li>
          </#if>
          <li>
            <p>Enter the one-time code provided by the application and click Save to finish the setup.</p>
          </li>
        </ol>

        <hr/>

        <form action="${url.totpUrl}" class="form-horizontal" method="post">
          <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
          <div class="form-group">
            <div class="col-sm-2 col-md-2">
              <label for="totp" class="control-label">One-time code</label>
            </div>

            <div class="col-sm-10 col-md-10">
              <input type="text" class="form-control" id="totp" name="totp" autocomplete="off" autofocus autocomplete="off">
              <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
            </div>
          </div>

          <div class="form-group">
            <div id="kc-form-buttons" class="col-md-offset-2 col-md-10 submit">
              <div class="">
                <button type="submit" class="btn btn-primary" name="submitAction" value="Save">Save</button>
                <button type="submit" class="btn btn-secondary" name="submitAction" value="Cancel">Cancel</button>
              </div>
            </div>
          </div>
        </form>
    </#if>

  </@layout.mainLayout>
