# WAT

Chart for an OpenLDAP test server with pre-defined structure. Testing purposes only.
See https://github.com/EugenMayer/docker-image-ldapexample for the structure and 
general documentation of the ldap server itself.

# Install

```bash
helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
helm install eugenmayer/openldap-test
```

# Values

Check the `values.yaml` file

If you deploy the service, be sure to set the `service.externalIp`
