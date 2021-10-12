#From a linux distribution that uses rpm
from fedora
#Installing rpm build tools
RUN dnf install -y rpmdevtools rpmlint
#As rpmbuild need a user worskpace, creating a specific user
RUN useradd rpmbuilder
USER rpmbuilder
#Initalizing rpm build folder structure
RUN rpmdev-setuptree
#Building the rpm from a spec file specified in environment variable, some volumes should be mounted for SPECS and SOURCES folders
CMD ["sh", "-c", "rpmbuild -ba /home/rpmbuilder/rpmbuild/SPECS/${SPEC_FILE}"]
