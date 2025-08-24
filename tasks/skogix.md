---
state: skogix
created: 2025-08-24
priority: low
tags: [skogix, dump, todo]
depends: []
---


[defaults]
vault_password_file = /home/skogix/.ssh/ansible-vault-password
collections_path = ~/.ansible/.collections
fact_caching = community.general.yaml
fact_caching_connection = ~/.ansible/.cache
force_color = true
force_handlers = true
interpreter_python = python
inventory = .hosts
local_tmp = /tmp/.ansible
remote_tmp = /tmp/.ansible
roles_path = roles

[diff]
always = yes
vault_password_file = ~/.ssh/ansible-vault-pass
---
collections:
  - name: ansible.posix
    version: ">=1.5.0"
  - name: community.general
    version: ">=11.0.0"
  - name: kewlfft.aur
    version: ">=0.11.0"
---
# System Setup Flowchart

## Initial Bootstrap Flow (arch-base.yml)

```mermaid
graph TD
    Start([Fresh Install]) --> PreCheck{Ansible installed?}
    PreCheck -->|No| InstallAnsible[Install ansible via pacman]
    PreCheck -->|Yes| Collections[Install Ansible Collections<br/>requirements.yml]
    InstallAnsible --> Collections
    
    Collections --> PreTasks[Pre-Tasks:<br/>- Update pacman cache<br/>- Install base-devel, git, sudo]
    
    PreTasks --> Role01[01_host_info<br/>Verify Arch Linux]
    Role01 -->|Pass| Role02[02_basics<br/>- systemd-timesyncd<br/>- paccache.timer<br/>- reflector<br/>- mirrorlist]
    Role01 -->|Fail| Abort([Abort: Not Arch])
    
    Role02 --> Role03[03_gui<br/>GPU Detection & Drivers<br/>PLACEHOLDER]
    Role03 --> Role04[04_desktop<br/>Desktop Environment]
    Role04 --> Role05[05_packages<br/>- pacman packages<br/>- AUR helper<br/>- AUR packages<br/>- fonts]
    Role05 --> Role07[07_users<br/>- Create user<br/>- Set groups<br/>- Git config<br/>- VS Code extensions]
    
    Role07 --> PostTasks[Post-Tasks:<br/>- System upgrade?<br/>- Clean cache]
    PostTasks --> BaseComplete([Base System Ready])
```

## On-Demand Management Flow (site.yml)

```mermaid
graph LR
    User([User Request]) --> Choose{Which component?}
    
    Choose --> Packages[packages role<br/>Multi-distro support]
    Choose --> System[system role<br/>System config]
    Choose --> Dotfiles[dotfiles role<br/>Config management]
    Choose --> SSH[ssh role<br/>Keys & hardening]
    Choose --> Git[git role<br/>Config & signing]
    Choose --> Other[Other roles:<br/>tmux, vim, zsh, etc.]
    
    Packages --> Done([Task Complete])
    System --> Done
    Dotfiles --> Done
    SSH --> Done
    Git --> Done
    Other --> Done
```

## Variable Resolution Flow

```mermaid
graph TD
    Request([Ansible needs variable]) --> GroupVars{Check group_vars/all/}
    GroupVars --> GVUser[user.yml]
    GroupVars --> GVSystem[system.yml]
    GroupVars --> GVPackages[packages.yml]
    
    GVUser --> HostVars{Check host_vars/}
    GVSystem --> HostVars
    GVPackages --> HostVars
    
    HostVars --> RoleDefaults{Check role defaults/}
    RoleDefaults --> RoleVars{Check role vars/}
    RoleVars --> Value([Final Value])
```

## Maintenance Flow

```mermaid
graph TD
    Schedule([Regular Maintenance]) --> Maint[arch-maintenance.yml]
    Maint --> UpdateMirrors[Update mirrorlist]
    Maint --> UpdateSystem[Update packages]
    Maint --> UpdateAUR[Update AUR]
    Maint --> CleanCache[Clean caches]
    Maint --> CheckServices[Check failed services]
    Maint --> CheckPacnew[Check .pacnew files]
    CheckPacnew --> Complete([Maintenance Complete])
```

---

collections/:
ansible_collections

docs/:
llm
regular

group_vars/:
all

playbooks/:
arch-base.yml
arch-maintenance.yml
install_requirements.yml
site.yml
templates

roles:
01_host_info
02_basics
03_gui
04_desktop
05_packages
07_users
dotfiles
git
packages
ssh
system
tmux


