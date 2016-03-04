core: 8.x
api: 2

projects:
  drupal:
    version: "8.0.5"
  purge:
    version: "3.x-dev"
  purge_queuer_url:
    version: "1.0-beta2"
  akamai:
    version: "3.x-dev"
  # Include demo_framework so we can have a working, complex site with content
  # already in place. This makes it much easier to test real-world caching
  # scenarios.
  df:
    type: "profile"
    download:
      # We are downloading this from git to avoid checksum issues.
      # @see https://www.drupal.org/node/1961304
      url: "http://git.drupal.org/project/df.git"
      revision: "8.x-1.x"
