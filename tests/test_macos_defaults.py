import os
from pathlib import Path
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).resolve().parents[1] / "platform/macos/system/set-defaults.sh"


class MacOSDefaultsTests(unittest.TestCase):
    def run_defaults(self, fail_domain=""):
        # Stub system commands so tests never change real macOS preferences.
        with tempfile.TemporaryDirectory(prefix="macos-defaults-test-") as directory:
            root = Path(directory)
            log = root / "calls"
            defaults = root / "defaults"
            defaults.write_text(
                '#!/bin/sh\n'
                'printf "%s\\n" "$*" >> "$DEFAULTS_LOG"\n'
                'if [ "$2" = "$FAIL_DOMAIN" ]; then\n'
                '  echo "Could not write domain $2; exiting" >&2\n'
                '  exit 1\n'
                'fi\n'
            )
            defaults.chmod(0o755)
            chflags = root / "chflags"
            chflags.write_text("#!/bin/sh\nexit 0\n")
            chflags.chmod(0o755)
            result = subprocess.run(
                ["bash", str(SCRIPT)],
                env={
                    **os.environ,
                    "PATH": str(root) + os.pathsep + os.environ["PATH"],
                    "HOME": str(root),
                    "DEFAULTS_LOG": str(log),
                    "FAIL_DOMAIN": fail_domain,
                },
                text=True,
                capture_output=True,
                timeout=10,
            )
            return result, log.read_text().splitlines()

    def test_success_applies_safari_preferences_without_warning(self):
        result, calls = self.run_defaults()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stderr, "")
        self.assertIn("write com.apple.Safari ShowFavoritesBar -bool false", calls)
        self.assertIn("write com.apple.Safari ShowOverlayStatusBar -bool true", calls)
        self.assertIn("write com.apple.Safari IncludeDevelopMenu -bool true", calls)
        self.assertFalse(any("com.apple.Safari.plist" in call for call in calls))

    def test_safari_failure_warns_once_and_continues_other_settings(self):
        for domain in ("com.apple.Safari", "com.apple.Safari.SandboxBroker"):
            with self.subTest(domain=domain):
                result, calls = self.run_defaults(domain)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stderr.count("[WARN]"), 1)
                self.assertEqual(result.stderr.count("Could not write domain"), 1)
                self.assertIn("Full Disk Access", result.stderr)
                self.assertIn("write NSGlobalDomain WebKitDeveloperExtras -bool true", calls)
                self.assertNotIn("write com.apple.Safari IncludeDevelopMenu -bool true", calls)

    def test_non_safari_failure_is_reported_as_failure(self):
        result, calls = self.run_defaults("com.apple.NetworkBrowser")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Could not write domain com.apple.NetworkBrowser", result.stderr)
        self.assertNotIn("[WARN]", result.stderr)
        self.assertFalse(any("com.apple.Safari" in call for call in calls))


if __name__ == "__main__":
    unittest.main()
