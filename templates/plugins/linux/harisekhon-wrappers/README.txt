Hari Sekhon Nagios Plugins - Custom Wrappers
============================================

DESCRIPTION
-----------

This directory contains custom Python wrappers for the Hari Sekhon
Nagios plugins.

These wrappers extend or customize the behavior of the original
plugins without modifying their source code or the Docker image.


EXECUTION
---------

IMPORTANT: Wrappers must NOT be executed directly from this directory
on the host system.

Wrappers must be executed inside the "harisekhon/nagios-plugins"
Docker container, where the original plugins and their Python
dependencies are available.

Each wrapper must be bind-mounted into the container and executed
using the Python interpreter available inside the container.

The original Docker image must remain unchanged.


GENERIC EXECUTION EXAMPLE
-------------------------

docker run --rm \
  --entrypoint python3 \
  -v /opt/icinga2-plugins/harisekhon-wrappers/WRAPPER.py:/github/nagios-plugins/WRAPPER.py:ro \
  harisekhon/nagios-plugins \
  /github/nagios-plugins/WRAPPER.py \
  [PLUGIN_ARGUMENTS]

Replace:
  WRAPPER.py        with the actual wrapper filename.
  PLUGIN_ARGUMENTS  with the plugin command-line arguments.

The ":ro" suffix mounts the wrapper file in read-only mode.


ICINGA2 INTEGRATION
-------------------

When integrating a wrapper into an Icinga2 CheckCommand, the command
must invoke Docker and execute the wrapper inside the container.

Do not configure Icinga2 to execute the wrapper directly from the
host filesystem.

The Docker bind mount must reference the wrapper file stored in
this directory.


MAINTENANCE
-----------

- Keep the original Hari Sekhon plugins unchanged.
- Do not modify the original Docker image.
- Store custom wrappers in this directory.
- Always mount wrapper files in read-only mode.
- Preserve compatibility with the original plugin arguments.
- Test wrappers inside Docker before deploying them to Icinga2.
- Verify compatibility after updating the Docker image.


REFERENCE
---------

Hari Sekhon Nagios Plugins:
https://github.com/harisekhon/nagios-plugins

Docker image:
harisekhon/nagios-plugins
