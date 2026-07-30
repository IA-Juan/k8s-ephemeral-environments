@echo off
setlocal

echo ==========================================
echo  Creating k8s-ephemeral-environments
echo  repository structure
echo ==========================================
echo.

REM Root folders

mkdir .github 2>nul
mkdir .github\workflows 2>nul

mkdir apps 2>nul
mkdir apps\demo-web 2>nul
mkdir apps\demo-web\src 2>nul
mkdir apps\demo-web\test 2>nul

mkdir charts 2>nul
mkdir charts\edc-environment 2>nul
mkdir charts\edc-environment\templates 2>nul
mkdir charts\edc-environment\charts 2>nul
mkdir charts\edc-environment\values 2>nul

mkdir docs 2>nul

mkdir environments 2>nul

mkdir scripts 2>nul


echo.
echo Creating base files...
echo.

REM Root files

type nul > README.md
type nul > LICENSE
type nul > Makefile
type nul > .gitignore


REM Application files

type nul > apps\demo-web\package.json
type nul > apps\demo-web\Dockerfile
type nul > apps\demo-web\.dockerignore


REM Helm files

type nul > charts\edc-environment\Chart.yaml
type nul > charts\edc-environment\values.yaml


REM Environment files

type nul > environments\demo-123.yaml
type nul > environments\demo-456.yaml


REM Scripts

type nul > scripts\bootstrap.sh
type nul > scripts\build.sh
type nul > scripts\deploy.sh
type nul > scripts\destroy.sh
type nul > scripts\load-image.sh


REM Documentation

type nul > docs\architecture.md
type nul > docs\architecture-decisions.md
type nul > docs\deployment.md
type nul > docs\walkthrough.md
type nul > docs\interview-notes.md


REM Github Actions

type nul > .github\workflows\build.yml


echo.
echo ==========================================
echo Structure created successfully
echo ==========================================
echo.

tree /F

pause

endlocal