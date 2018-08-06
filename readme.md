### Description
Custom theme for a [Keycloak](https://www.keycloak.org) that provide a simple dashboard with SASL applications for users.

**Features:**
* Application groups
* Application icons
* Default Applications group
* Hide unused applications




### Application groups
Applications automatically groups by Application name prefix. So if you create 2 application with a same prefix like:

```
MyCompany-{appname}
```

and it will be placed in same group


### Application icons
Application icons automatically assigns by application name.
Create a new application with any name line "My GitHub SSO" and place icon named as **github.png** in theme folder:

```
saritasa/account/resources/icon/
```

### Default Applications group
Change **mainApp** variable in  **saritasa/account/theme.properties** to your main application group name, and this group will be always at first place in dashboard.


### Hide unused application

Add **hide** word in client description field and this application will not show in applications dashboard.

### Other changes

Now, by default Client Roles prints by Description instead Name, because if you work with an AWS - your Client Roles name are too long for correct draw them in UI.

#### Preview

![theme-preview](https://github.com/rma945/keycloack-saritasa-theme/raw/develop/.assets/preview.png)
