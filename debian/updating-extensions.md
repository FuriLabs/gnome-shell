Updating GNOME Shell extensions to GNOME Shell 51
=================================================

GNOME Shell extensions make use of internal interfaces in GNOME Shell,
which do not have a long-term-stable API.
This means that extensions need to be updated for each new GNOME Shell
release.

If the extension doesn't use any of the interfaces that have had
incompatible changes, it might be sufficient to patch the `metadata.json`
file to add `"51"` to the list of supported versions, replace any
`gnome-shell (<< 51)` dependencies with `gnome-shell (<< 52)` and recompile.
Please test before uploading!

If the extension does require source changes, they should be contributed
upstream.

Porting guide
-------------

The gjs project provides a porting guide for extension maintainers:
<https://gjs.guide/extensions/upgrading/gnome-shell-51.html>

Upgrading to GNOME Shell 51 for testing
---------------------------------------

GNOME Shell 51 can be installed from experimental.
All binary packages from `src:gnome-shell`, `src:mutter` and `src:gjs`
should be upgraded.

If testing an extension that is active in the gdm session,
all binary packages from `src:gdm3` should also be upgraded.

Dependencies
------------

Instead of duplicating information in debian/control, many extensions
automatically generate their dependencies with code like this in
debian/rules:

	override_dh_gencontrol:
		dh_gencontrol -- \
			-Vgnome:MinimumVersion=$(shell python3 -c "import json; print(min(int(x) for x in json.load(open('caffeine@patapon.info/metadata.json', 'rt'))['shell-version']))") \
			-Vgnome:MaximumVersion=$(shell python3 -c "import json; print(1+max(int(x) for x in json.load(open('caffeine@patapon.info/metadata.json', 'rt'))['shell-version']))")

and then use this in debian/control:

    Depends:
     gnome-shell (<< ${gnome:MaximumVersion}~),
     gnome-shell (>= ${gnome:MinimumVersion}~),

Uploading
---------

If the extension is still backward-compatible with GNOME Shell 50,
it can be uploaded to unstable immediately.

If the extension is no longer compatible with GNOME Shell 50, it should
be uploaded to experimental until the GNOME Shell 51 transition begins,
then re-uploaded to unstable as part of the transition.
