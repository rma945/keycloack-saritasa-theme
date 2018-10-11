### Description
Custom theme for a [Keycloak](https://www.keycloak.org) that provide a simple dashboard with SASL applications for users.

**Features:**
* Application groups
* Application icons
* Hide applications for users without assigned roles
* Hide unused applications
* [saml2aws](https://github.com/Versent/saml2aws) integraion


### Application groups
Applications automatically groups by Application name prefix. So if you create 2 application with a same prefix like:

```
MyCompany-{appname}
```

it will be placed in same group **MyCompany**


### Application icons
Application icons automatically assigns by application name.
Create a new application with any name line "My GitHub SSO" and place icon named as **github.png** in theme folder:

```
saritasa/account/resources/icon/
```
Then, add icon name to **appIcons** list value in a **saritasa/account/theme.properties** and all you applications that contains **github** in name - will be displayed with this icon.


### saml2aws integraion
Adding quick configuration for issuing a temporary AWS Cli credentials throught [saml2aws](https://github.com/Versent/saml2aws)


### Default Applications group
Change **mainApp** variable in  **saritasa/account/theme.properties** to your main application group name, and this group will be always at first place in dashboard.


### Hide application for users without assigned roles

If you don't want to show applications to a users that don't have access to this apps - you can enable **hideAppWithoutRoles=true** parameter in **saritasa/account/theme.properties** file. And after that, user will see application, only if his have assigned role for this app.

### Hide unused application

If you need to a hide specific application - add **hide** word in client description field and this application will not show in applications dashboard.

### Other changes

Now, by default Client Roles prints by Description instead Name, because if you work with an AWS - your Client Roles name are too long for correct draw them in UI.

#### Preview

![theme-preview](https://github.com/rma945/keycloack-saritasa-theme/raw/develop/.assets/preview.png)

#### Preview

![saml2aws-preview](https://github.com/rma945/keycloack-saritasa-theme/raw/develop/.assets/saml2aws.png)
