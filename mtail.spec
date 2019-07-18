%global debug_package %{nil}
%global __strip /bin/true

Name:           mtail	
Version:        %{ver}
Release:        %{rel}%{?dist}

Summary:	mtail latest release binary 

Group:		YIG
License:        Apache-2.0
URL:		http://github.com/journeymidnight/mtail-rpm
Source0:	%{name}-%{version}.tar.gz
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-XXXXXX)
#BuildRequires:  

%description


%prep
%setup -q -n %{name}-%{version}


%build
#The go build still use source code in GOPATH/src/legitlab/yig/
#keep git source tree clean, better ways to build?
#I do not know

%install
rm -rf %{buildroot}
install -D -m 755 mtail %{buildroot}%{_bindir}/mtail
install -D -m 644 mtail.service   %{buildroot}/usr/lib/systemd/system/mtail.service

%post
systemctl enable mtail 

%preun

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
/usr/bin/mtail
/usr/lib/systemd/system/mtail.service


%changelog

