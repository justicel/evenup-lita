class lita (
  $base_path        = $::lita::params::base_path,
  $manage_bundler   = $::lita::params::manage_bundler,
  $bundler_package  = $::lita::params::bundler_package,
  $bundler_provider = $::lita::params::bundler_provider,
  $bundler_binpath  = $::lita::params::bundler_binpath,
  $extra_packages   = $::lita::params::extra_packages,

  # bot defaults
  $version          = $::lita::params::version,
  $adapter          = $::lita::params::adapter,
  $bot_name         = $::lita::params::name,
  $gems             = $::lita::params::gems,
  $mention_name     = $bot_name,
  $plugins          = $::lita::params::plugins,
  $plugin_config    = $::lita::params::plugin_config,
  $admins           = $::lita::params::admins,
  $adapter          = $::lita::params::adapter,
  $locale           = $::lita::params::locale,
  $log_level        = $::lita::params::log_level,
  $adapter_config   = $::lita::params::adapter_config,
  $http_host        = $::lita::params::http_host,
  $http_port        = $::lita::params::http_port,
  $redis_host       = $::lita::params::redis_host,
  $redis_port       = $::lita::params::redis_port,
) inherits lita::params {

  include ::systemd

  user { 'lita':
    ensure  => 'present',
    system  => true,
    gid     => 'lita',
    home    => '/opt/lita',
    shell   => '/bin/bash',
    require => Group['lita'],
  }

  group { 'lita':
    ensure => 'present',
    system => true,
  }

  if $manage_bundler {
    package { $bundler_package:
      ensure   => 'installed',
      provider => $bundler_provider,
    }
  }

  package { $extra_packages:
    ensure => 'installed',
  }

  file { $base_path:
    ensure => 'directory',
    owner  => 'lita',
    group  => 'lita',
  }

  file { '/usr/lib/systemd/system/lita@.service':
    owner   => root,
    group   => root,
    mode    => '0555',
    content => template('lita/lita.service.erb'),
    notify  => Exec['systemctl-daemon-reload'],
  }

}