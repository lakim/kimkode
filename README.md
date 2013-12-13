Install
-------

On your local machine:

```shell
vagrant up
vagrant ssh
```

On the VM:

```shell
cd /vagrant
docker build -t louisalbankim ./docker
docker run -p 80:80 -p 2222:22 \
  -v /home/deploy:/home/deploy \
  -v /vagrant:/vagrant \
  -e RACK_ENV=development \
  louisalbankim
```

TODO
----

* content helper: content(slug) => OK
* specify layout per type => OK
* view per type => OK
* posts#index => OK
* tags#show => OK
* tags helper => OK
* tags identity map => OK
* page caching => OK
* manage drafts (*) => OK
* sitemap => OK
* links should be target=_blank
* move page cache to public/cache
* code highlight
* pagination
* RSS feed
* config file (twitter account, GA id, ...)

* extract engine
* tests tests tests
** names : devcms, hackercms

Design inspiration
------------------

http://weareimpero.com/
http://thisisyoke.com/

Articles
--------
Proxmox keyboard config

* host and container share a data volume (docker run -v ...) => OK
* configure vagrant shared folder as deploy user => OK
* persist deploy folder on host => OK
* in prod, deploy with capistrano to container (or host?)
* run docker with Vagrantfile
