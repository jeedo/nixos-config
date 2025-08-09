# nix configuration

## nix commands

Deploying new configuration


```bash
cd ~/home-manager-nix
# deploy the flake in the current directory
sudo nixos-rebuild switch --falke .
```

Showing detailed error messages.


```bash
cd ~/home-manager-nix
# deploy the flake in the current directory
sudo nixos-rebuild switch --falke . --show-trace --print-build-logs --verbose
```

## git cheatsheet

Rolling back to previous commit

```bash
cd ~/home-manager-nix
git checkout HEAD^1
# deploy the flake in the current directory
sudo nixos-rebuild switch --falke .
```
