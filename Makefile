###################################
#		                            #
#		  Beanux OS instalacja      #
#                                 #
#   (kernel nie będzie działać)   #
#                                 #
###################################
pobierz: update-grub
	cd /home/$USER && wget https://ftp.icm.edu.pl/pub/OpenBSD/7.0/src.tar.gz && wget https://git.kernel.org/torvalds/t/linux-5.17-rc5.tar.gz
	apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev
wypakuj: pobierzsos
	cd /home/$USER && unxz -v linux-*.tar.xz
	cd /home/$USER && unxz -v src.tar.gz
utworz-bestie: wypakuj
	cd  /home/$USER/linux* && cp -r Makefile /home/$USER/scr
	cd  /home/$USER/scr && cp -r * /home/$USER/linux*
zainstaluj: utworz-bestie
	cd  /home/$USER/scr && cp -v /boot/config-$$(uname -r) .config
	cd  /home/$USER/scr && make -j $(nproc) && make modules_install && make install
update-grub: zainstaluj
	update-grub
	reboot
	
	