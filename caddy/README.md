# Setup

- exec `generate-secrets.sh` to generate secrets
- according to caddy docs, configure you certificate creation using acme_dns (https://caddy.community/t/how-to-use-dns-provider-modules-in-caddy-2/8148) and change the Dockerfile accordingly
- in all the files, look for `<diamonds>` to replace with your values

# Use it

- Add the following labels to the containers you want to route, replacing:
```yaml
    labels:
      caddy: <my-app.your-domain.com>
      caddy.reverse_proxy: '{{upstreams http <the port of the app>}}'
```