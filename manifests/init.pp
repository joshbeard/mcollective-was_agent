# == Class: mco_was_agent
#
# Installs the WAS Mcollective agent for interacting with IBM WebSphere
# profiles.
#
# === Parameters
#
# Document parameters here.
#
# [*ensure*]
#   Specifies the state of the agent and application.
#   Valid values are: present, installed, and absent.
#   'present' and 'installed' are synonomous and will ensure the files are
#   present on a system.  'absent' will ensure they're not present.
#   Defaults to 'present'
#
# [*profile_dirs*]
#   Array of absolute paths to find WAS profiles.
#
# [*mco_libdir*]
#   Specifies the absolute path to the Mcollective lib directory.
#   On PE, this defaults to /opt/puppet/libexec/mcollective/mcollective
#   On POSS, this defaults to /usr/libexec/mcollective/mcollective
#
# [*owner*]
#   What user should own the files.
#   Defaults to: 'root'
#
# [*group*]
#   What group should own the files.
#   Defaults to: 'root'
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*is_pe*]
#   If this top-scope variable is present, the mco_libdir will be set to the
#   PE location.  Otherwise, POSS' location for mcollective libraries.
#
# === Examples
#
#  class { 'mco_was_agent':
#    ensure => 'present',
#  }
#
# === Authors
#
# Josh Beard <beard@puppetlabs.com>
#
# === Copyright
#
# Copyright 2014 Josh Beard, unless otherwise noted.
#
class mco_was_agent (
  $ensure       = $mco_was_agent::params::ensure,
  $mco_libdir   = $mco_was_agent::params::mco_libdir,
  $profile_dirs = $mco_was_agent::params::profile_dirs,
  $owner        = $mco_was_agent::params::owner,
  $group        = $mco_was_agent::params::group,
) inherits mco_was_agent::params {

  validate_re($ensure, '(present|installed|absent)')
  validate_absolute_path($mco_libdir)
  validate_array($profile_dirs)


  ## Allow for the removal of everything this class manages and be smart
  ## about what type of 'ensure' parameter we pass to resources
  case $ensure {
    /present|installed/: {
      $file_ensure = 'file'
      $dir_ensure  = 'directory'
    }
    'absent': {
      $file_ensure = 'absent'
      $dir_ensure  = 'absent'
    }
    default: {
      fail("Invalid parameter for ensure: ${ensure}")
    }
  }

  file { 'mcowas_agent_agent':
    ensure  => $file_ensure,
    path    => "${mco_libdir}/agent/was.rb",
    content => template('mco_was_agent/was.rb.erb'),
    owner   => $owner,
    group   => $group,
    notify  => Service['pe-mcollective'],
  }

  file { 'mcowas_agent_ddl':
    ensure => $file_ensure,
    path   => "${mco_libdir}/agent/was.ddl",
    source => 'puppet:///modules/mco_was_agent/agent/was.ddl',
    owner  => $owner,
    group  => $group,
    notify => Service['pe-mcollective'],
  }

  service { 'pe-mcollective': }

}
