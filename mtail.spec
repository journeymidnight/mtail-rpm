%global debug_package %{nil}
%global __strip /bin/true

Name:           mtail	
Version:        %{version}
Release:        %{release}

Summary:	mtail latest release binary 

Source:		%{name}_%{version}-%{release}_linux_amd64.tar.gz
Group:		YIG
License:        Apache-2.0
URL:		http://github.com/journeymidnight/mtail-rpm
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}_%{version}-%{release}-XXXXXX)
#BuildRequires:  

%description


%prep
%setup -q -n %{name}_%{version}-%{release}_linux_amd64


%build

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

