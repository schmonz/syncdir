Name: syncdir
Summary: Synchronous directory library
Version: 1.0
Release: 1
Copyright: GPL
Group: Libraries
Source: http://www.qcc.sk.ca/~bguenter/distrib/syncdir/syncdir-%{PACKAGE_VERSION}.tar.gz
BuildRoot: /tmp/syncdir
Packager: Bruce Guenter <bruce.guenter@qcc.sk.ca>

%description
Provides an alternate implementation for open, link, rename, and unlink
that executes a fsync on any modified directories.

%prep
%setup

%build
make CFLAGS="$RPM_OPT_FLAGS -g"

%install
rm -fr $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/lib

make prefix=$RPM_BUILD_ROOT/usr install

%clean
rm -rf $RPM_BUILD_ROOT

%post
/sbin/ldconfig

%postun
/sbin/ldconfig

%files
%defattr(-,root,root)
/usr/lib/libsyncdir.so
/usr/lib/libsyncdir.a
