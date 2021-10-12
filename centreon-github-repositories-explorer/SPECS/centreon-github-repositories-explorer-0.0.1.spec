Name: centreon-github-repositories-explorer
Version: 0.0.1        
Release: 1%{?dist}
Summary: Centreon github repositories explorer
BuildArch: noarch       

License: GPL 
Source0: %{name}-%{version}.tar.gz

Requires: bash    

%description
This script lists all Centreon GitHub repositories

%prep
%setup -q


%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
cp %{name}.sh $RPM_BUILD_ROOT/%{_bindir}

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}.sh


%changelog
* Sun Oct 10 2021 "Damien GHILES"
<damien.ghiles@gmail.com> - 0.0.1
- First version 
