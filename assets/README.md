This folder is where the site images should live so the `static-site/` folder is self-contained.

How to populate:
- From the repository root run (PowerShell):

  cd static-site
  .\copy-assets.ps1

This will copy all files from `../src/assets` into `static-site/assets`.

Files expected (examples):
- hero-bg.jpg
- project-1.jpg
- project-2.jpg
- project-3.jpg
- dashboard-1.jpg
- dashboard-2.jpg
- dashboard-3.jpg

If you prefer to copy manually, place those images into this folder and the pages will reference them as `assets/<filename>`.
