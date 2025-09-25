target_root :='/mnt'
target_home :='/mnt/home/pcp'
default:
  just -l
disk-install HOST DISK:
	sudo nix run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake ".#{{HOST}}" --disk main {{DISK}}
mount_target DISK:
	sudo mount {{DISK}} {{target_root}}
copy_host_key:
	sudo mkdir -p {{target_root}}/etc/ssh
	sudo cp /etc/ssh/ssh_host_ed25519_key {{target_root}}/etc/ssh/ssh_host_ed25519_key
	sudo cp /etc/ssh/ssh_host_ed25519_key.pub {{target_root}}/etc/ssh/ssh_host_ed25519_key.pub
copy_user_key:
	mkdir -p {{target_home}}/etc/ssh
	cp -i ~/.ssh/id_ed25519 {{target_home}}/.ssh/id_ed25519
	cp -i ~/.ssh/id_ed25519.pub {{target_home}}/.ssh/id_ed25519.pub
clone_dotfiles:
	git clone https://github.com/postcyberpunk/dotfiles {{target_home}}/dotfiles
init_flatpak:
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fix_steamvr:
	sudo setcap CAP_SYS_NICE+ep ~/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher
