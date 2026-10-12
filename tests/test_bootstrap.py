import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


BOOTSTRAP = Path(__file__).resolve().parents[1] / "script/bootstrap"


class BootstrapTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="bootstrap-test-")
        self.addCleanup(self.temp.cleanup)
        root = Path(self.temp.name).resolve()
        self.repo = root / "dotfiles repo"
        self.home = root / "home"
        (self.repo / "script").mkdir(parents=True)
        self.home.mkdir()
        shutil.copy2(BOOTSTRAP, self.repo / "script/bootstrap")

        # Avoid the unrelated Git identity setup prompt.
        gitconfig = self.repo / "git/gitconfig.local.symlink"
        gitconfig.parent.mkdir()
        gitconfig.write_text("fixture\n")
        (self.home / ".gitconfig.local").symlink_to(gitconfig)

        self.links = {
            self.home / ".vimrc": self.repo / "vim/vimrc.symlink",
            self.home / ".zshrc": self.repo / "platform/macos/home/zshrc.symlink",
            self.home / ".config/shared/settings": self.repo / "config/shared/settings",
            self.home / ".config/platform/settings": (
                self.repo / "platform/macos/config/platform/settings.symlink"
            ),
        }
        for destination, source in self.links.items():
            source.parent.mkdir(parents=True, exist_ok=True)
            source.write_text("new content\n")
            destination.parent.mkdir(parents=True, exist_ok=True)

    def run_bootstrap(self, answers=""):
        return subprocess.run(
            ["bash", str(self.repo / "script/bootstrap"), "--skip-packages"],
            input=answers,
            text=True,
            capture_output=True,
            env={**os.environ, "HOME": str(self.home), "DOTFILES_PROFILE": "macos"},
            timeout=10,
        )

    def create_conflicts(self, dangling=False):
        for destination in self.links:
            if dangling:
                destination.symlink_to(self.home / "missing target")
            else:
                destination.write_text("original content\n")

    def assert_original(self, destination, dangling):
        if dangling:
            self.assertTrue(destination.is_symlink())
            self.assertEqual(os.readlink(destination), str(self.home / "missing target"))
        else:
            self.assertFalse(destination.is_symlink())
            self.assertEqual(destination.read_text(), "original content\n")

    def test_conflict_choices_across_all_file_discovery_loops(self):
        for action in "sSoObB":
            for dangling in (False, True):
                with self.subTest(action=action, dangling=dangling):
                    self.create_conflicts(dangling)
                    answers = action if action.isupper() else action * len(self.links)
                    result = self.run_bootstrap(answers)
                    self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                    expected_prompts = 1 if action.isupper() else len(self.links)
                    self.assertEqual(result.stdout.count("File already exists:"), expected_prompts)
                    for destination, source in self.links.items():
                        backup = Path(str(destination) + ".backup")
                        if action.lower() == "s":
                            self.assert_original(destination, dangling)
                        else:
                            self.assertTrue(destination.is_symlink())
                            self.assertEqual(os.readlink(destination), str(source))
                        if action.lower() == "b":
                            self.assert_original(backup, dangling)
                            backup.unlink()
                        else:
                            self.assertFalse(os.path.lexists(backup))
                        destination.unlink()

    def test_fresh_install_and_repeat_run(self):
        for _ in range(2):
            result = self.run_bootstrap()
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertNotIn("File already exists:", result.stdout)
            for destination, source in self.links.items():
                self.assertEqual(os.readlink(destination), str(source))

    def test_invalid_and_blank_choices_reprompt(self):
        self.create_conflicts()
        result = self.run_bootstrap("x\nS")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(result.stdout.count("Please choose"), 2)
        for destination in self.links:
            self.assert_original(destination, False)

    def test_missing_input_fails_without_replacing_files(self):
        self.create_conflicts()
        result = self.run_bootstrap()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("could not read a choice", result.stdout)
        self.assertNotIn("File exists", result.stderr)
        for destination in self.links:
            self.assert_original(destination, False)


if __name__ == "__main__":
    unittest.main()
