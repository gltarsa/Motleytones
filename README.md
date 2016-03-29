# README

This app serves up the Motley Tones website.

### Features

* Delivers static pages with DRY (Don't Repeat Yourself) layout
 * About Motley Tones
 * Biographies of the group
 * Performance Schedule and Bookint
 * Photos
 * Videos

* Generates schedule pages dynamically from the database
 * Future and current gigs are displayed
 * Past gigs are displayed as struck-out text
 * Full Add/Modify/Delete capabilities for Admin users

* User logins and management
 * Admin users can create new users
 * Full Add/Modify/Delete capabilities for Admin users

### Future features

* Generate video page from database

### Project Management

* Trello Board for this project can be [found here](https://trello.com/b/VwHfdHD4/motley-tones-web-app).

### Development Notes (Mac OS X)

* Start PostgreSQL: ```pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start```
* Stop PostgreSQL: ```pg_ctl -D /usr/local/var/postgres stop -s -m fast```

Note: when upgrading Mac OS X you may find postgres does not start properly due to missing directories. These commands will create empty versions of those directories, which should remedy the problem:

```mkdir /usr/local/var/postgres/{pg_tblspc,pg_twophase,pg_stat,pg_stat_tmp,pg_replslot,pg_snapshots}/```
```mkdir /usr/local/var/postgres/pg_logica{l,l/mappings,l/snapshots}```

### Miscellaneous

The styling of this app is generally based on an original static page created by Rebecca Tarsa using the [HTML5 Verti design](http://html6up.net/verti).  It no longer uses any of the original code or packages.

If you are reading this, [Like the Motley Tones on Facebook](http://facebook.com./motleytones.com).
