KComm 2.1 Source Code Distribution  1 May 2013
===============================================

This source code is released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt).

If you modify the source code and release a version of this program created with this modified source code, you must also release the full source code under the same license conditions.

Copyright notices in the source code and the program may not be removed.

Release notes
-------------

This version of the source code represents the latest release version of the KComm for Windows. It has been developed using Lazarus (http://www.lazarus.freepascal.org). It was compiled using Lazarus 1.0.2.

To compile the software you will need to install SynaSer (for serial port access) and Synapse from www.ararat.cz and set their paths in the project options.

Non-Windows platforms
---------------------

This program has been developed under Windows. Earlier versions were also tested under Linux. Because I gave up Linux some time ago I am no longer able to compile or test KComm on that platform therefore I am no longer able to support a Linux version.

Windows-specific code has been enclosed in conditional compilation brackets so the source code should compile under Lazarus on Linux without any difficulty. It is recommended that the project be built for GTK2 widgets.

Many options including support for the PSK31 Core DLL are applicable to Windows only so those options will not appear in the Linux version.

If you try to create a Linux (or Mac OS) version of KComm and need to make source code changes to get it to work please feed those changes back to me.

Julian Moss, G4ILO