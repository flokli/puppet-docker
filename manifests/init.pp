class docker {
  include apt

  apt::key {'docker':
    id     => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
    server => 'pool.sks-keyservers.net',
  }

  apt::source {'docker':
    location => 'https://download.docker.com/linux/debian',
    repos    => 'stable',
    require  => Apt::Key['docker'],
  }

  package { 'docker-ce':
    ensure  => present,
    require => [Class['apt::update'], Apt::Source['docker']],
  }

  service { 'docker':
    ensure  => running,
    enable  => true,
    require => Package['docker-ce'],
  }
}
