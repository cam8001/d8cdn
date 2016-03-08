#!/bin/sh
# Change to echo for testing, eval for running
CMD='eval'
# Name of Acquia environment we are deploying to.
UPSTREAM_ACE_NAME='d8cdn'
# Local machine db for testing
LOCALDBNAME="d8cdn"

$CMD svn export https://github.com/cam8001/drupal_settings/trunk/ --force sites/default/
# .bak trick for compatibility between Darwin and Linux.
$CMD "sed -i.bak 's/ACDOCROOT/$UPSTREAM_ACE_NAME/' sites/default/settings.php"
$CMD "sed -i.bak 's/LOCALDBNAME/$LOCALDBNAME/' sites/default/settings.local.php"
$CMD "rm sites/default/*.bak"

# Remove .gitignore which can make deploying to Acquia Cloud confusing
$CMD "rm profiles/df/.gitignore"


# Set up composer the way Drupal likes it
$CMD "php profiles/df/modules/contrib/composer_manager/scripts/init.php"
$CMD "composer drupal-update"

# @todo - detect installed drush versions
$CMD drush8 si -vy df
$CMD drush8 es -vy dfs_tec
$CMD drush8 en -y purge purge_ui purge_drush purge_queuer_url akamai devel web_profiler
