# 
# When logging in with username and password .bash_profile is called and .bashrc is not called
# For non-login shells .bashrc is called and .bash_profile is not called.
# This means we need to source .bashrc here so that the customizations are applied to login shell
# as well
# .bash_profile is good for actions that need to be done at log-in time only like displaying MOTD
# etc

# Get the bashrc customizations
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


