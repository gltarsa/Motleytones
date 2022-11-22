# README

This app serves up the Motley Tones website. It has been designed so that it should be
possible to customize it for other bands or applications.  Feel free to fork a copy and
make it work for you.

[![CircleCI](https://circleci.com/gh/GregT-home/Motleytones.svg?style=shield)](https://circleci.com/gh/gltarsa/Motleytones)
[![codebeat badge](https://codebeat.co/badges/a5914128-2e2a-421a-8876-8b53dc349468)](https://codebeat.co/projects/github-com-gltarsa-motleytones-master)


### Features

* Delivers static pages with DRY (Don't Repeat Yourself) layout
 * About Motley Tones
 * Biographies of the group
 * Performance Schedule and Booking
 * Photos
 * Videos

* Generates gig schedule pages dynamically from the database
 * Future and current gigs are displayed
 * Past gigs are displayed as struck-out text
 * Full Create/Read/Update/Delete capabilities for Admin users

* User logins and management
 * Admin users can create new users
 * Full Create/Read/Update/Delete capabilities for Admin users

### Future features

* Generate video page from database
* Generate photo albums w/o having to be logged into Facebook

### Project Management

* Trello Board for this project can be [found here](https://trello.com/b/VwHfdHD4/motley-tones-web-app).

### Development Notes (Mac OS X)

Building this app from scratch requires the following:

* `brew install postgres`
* Start PostgreSQL: `pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start`
  or `brew services start postgresql`

For completeness, there is also:

* Stop PostgreSQL: `pg_ctl -D /usr/local/var/postgres stop -s -m fast`
  or `brew services stop postgresql`

Note: when upgrading Mac OS X you may find postgres does not start properly due
to missing directories. These commands will create empty versions of those
directories, which should remedy the problem:

```mkdir /usr/local/var/postgres/{pg_tblspc,pg_twophase,pg_stat,pg_stat_tmp,pg_replslot,pg_snapshots}/```
```mkdir /usr/local/var/postgres/pg_logica{l,l/mappings,l/snapshots}```

### Miscellaneous

The styling of this app is generally based on an original static page created
by Rebecca Tarsa using the [HTML5 Verti design](http://html6up.net/verti).  It
no longer uses any of the original code or packages.

If you are reading this, [Like the Motley Tones on Facebook](http://facebook.com./motleytones.com).

### License

This source code is licensed under the MIT Open Source License.  See LICENSE.md for
details.

