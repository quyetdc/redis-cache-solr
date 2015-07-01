## README

### Intro
This is a tutorial project I created for

* Redis
* Cache
* Full text searching

### What I uses 

* rails 
* ruby 
* redis 
* sunspot
* twitter-bootstrap
* rack mini profiler
* devise
...

### How to

* Install redis on your local first

```
$ wget http://download.redis.io/redis-stable.tar.gz
$ tar xvzf redis-stable.tar.gz
$ cd redis-stable

$ make
$ make test

$ cp src/redis-server src/redis-cli /usr/bin

$ redis-serve
```

* Migrate database

* Run db seed

* Start sorl on your local

```
$ bundle exec rake sunspot:solr:start
```

* Check things on ```localhost:3000/categories```
