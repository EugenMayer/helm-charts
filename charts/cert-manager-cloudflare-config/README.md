# WAT

Deploys the configuration needed to run ACME DNS01 based certificates in the Cert-Manager, using Cloudflares API as 
challenge.

## Why

Since `ClusterIssuer` is a CRD you cannot deploy Cert-Manager via the helm-chart AND also deploy this configuration
since it won't be known in the same deployment (in terraform). It is pragmatic to have a simple config chart deploying 
that specific CRD, so you can depend on it.
