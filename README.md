**cdev** is a small batch file that aims to help manage C\C++(and much more) projects.

Since this is just a bunch of Windows Batch files, absolutely everything can be customized to suit specifically your needs.
Text editor, compiler, a path to your projects folder, pre\post -build steps, you name it. The files located here is just a place to start from.

Feel free to use, copy, modify, share and do whatever you want with these files. It's **Public Domain**.

**Configuration:**

You need to modify 2 files: `cdev.bat` and `tools/build.bat`

Just replace placeholders in `[customize those variables]` sections and it should work.

Folder `files` contains files that will be copied into `code` folder of your project.

Folder `tools` contains files that will be copied into `tools` folder of you project.
These tools can be accessed through cmd once you've loaded\created a project.

Also, you might want to put folder with cdev.bat in users\systems path variable for accessing cdev directly from the console just as other cmd commands like "cd".

**Have fun!**
