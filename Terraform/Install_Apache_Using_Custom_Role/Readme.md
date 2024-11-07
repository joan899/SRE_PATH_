# Apache Installation with Custom Role and Page Using Ansible

This project automates the installation of the Apache web server and sets up a custom HTML page using an Ansible role. The role installs Apache, configures a virtual host, and serves a custom index page.

## Prerequisites

Before you start, make sure you have the following:

- Ansible installed on your local machine.
- SSH access to the target machine where Apache will be installed.

## Role Overview

The role `apache_install` will:

1. Install necessary packages (e.g., `aptitude` and `apache2`).
2. Set up a custom HTML page (`index.html`) in the Apache document root.
3. Configure a virtual host for Apache.
4. Enable the new site and disable the default Apache site.
5. Open the required port in the firewall.

## Directory Structure

The project has the following directory structure:

roles/ └── apache_install/ ├── tasks/ │ └── main.yml # Task file to install Apache and configure the site ├── templates/ │ ├── index.html.j2 # Jinja2 template for the custom index page │ └── apache_config.j2 # Jinja2 template for Apache virtual host configuration ├── vars/ │ └── main.yml # Variables for the role (e.g., site title, Apache port) └── handlers/ └── main.yml # Handlers to restart Apache after changes

## Variables

The following variables need to be defined to run the role:

- `site_title`: The title of your site (e.g., "My Personal Website").
- `apache_port`: The port Apache should listen on (default: `8080`).

These variables can be defined in the `vars/main.yml` file, or they can be passed directly when running the playbook.

## Task Execution

### 1. **Install Prerequisites**
This task installs `aptitude` to manage package installations on the target system.

### 2. **Install Apache**
Apache2 is installed and updated to the latest version.

### 3. **Create Document Root**
The document root for the site is created at `/var/www/{{ site_title | lower | regex_replace(' ', '_') }}.com`.

### 4. **Copy Custom Index Page**
The `index.html.j2` template will be used to create a custom `index.html` page. The page will display the site title and the Apache port.

### 5. **Set Up Apache Virtual Host**
The `apache_config.j2` template configures the Apache virtual host to point to the custom document root.

### 6. **Enable the New Site**
The `a2ensite` command is used to enable the newly created virtual host configuration.

### 7. **Disable Default Apache Site**
The default Apache site (`000-default.conf`) is disabled using the `a2dissite` command.

### 8. **Allow HTTP Traffic on the Specified Port**
The `ufw` module is used to allow incoming HTTP traffic on the specified Apache port (default: `8080`).

## Handlers
The role includes handlers to restart Apache when changes are made:

- **Restart Apache**: This handler is triggered after the site configuration is changed or the default site is disabled.

## Running the Playbook
To run the playbook, execute the following command:

```ansible-playbook playbook/playbook.yml -i inventory/inventory.ini```

## Conclusion
This setup provides an easy way to install Apache and serve a custom page using Ansible, with the flexibility to modify the port and site title through variables.