# Installation of SonarQube Runner
class sonarqube::runner::install (
  $package_name,
  $version,
  $download_url,
  $installroot,
) {

  if ! defined(Package[unzip]) {
    package { 'unzip':
      ensure => present,
    }
  }
  if ! defined(Package[wget]) {
    package { 'wget':
      ensure => present,
    }
  }
  Archive {
    provider => 'wget',
    require  => Package['wget', 'unzip'],
  }

  archive { 'download-sonar-runner':
    path         => "/tmp/${package_name}-dist-${version}.zip",
    source       => "${download_url}/${version}/sonar-runner-dist-${version}.zip",
    extract      => true,
    extract_path => $installroot,
    creates      => "${installroot}/sonar-runner-${version}/bin",
    cleanup      => true,
  } ->
  file { "${installroot}/${package_name}-${version}":
    ensure => directory,
  } ->
  file { "${installroot}/${package_name}":
    ensure => link,
    force  => true,
    target => "${installroot}/${package_name}-${version}",
  }

  # Sonar settings for terminal sessions.
  file { '/etc/profile.d/sonarhome.sh':
    content => "export SONAR_RUNNER_HOME=${installroot}/${package_name}-${version}",
  }
  file { '/usr/bin/sonar-runner':
    ensure => link,
    target => "${installroot}/${package_name}-${version}/bin/sonar-runner",
  }
}
