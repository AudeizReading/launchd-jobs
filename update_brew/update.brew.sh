#!/bin/sh

BREW="/opt/homebrew/bin/brew"
if [ -x "${BREW}" ] ; then
  osascript -e 'display notification "Looking for Homebrew updates…" with title "Looking for Homebrew updates"'
else
  echo "Problem with the var BREW:$BREW:"
  exit 1;
fi

# Searching for new updates
${BREW} update 2>&1 > /dev/null
outdated=`${BREW} outdated | tr ' ' '\n'`
MESSAGE=`date`

# send notif and acts if upgrading is needed
if [ -z "${outdated}" ]; then
  osascript -e 'display notification "Nothing to do. Stay flex!" with title "No new Homebrew updates"'
  MESSAGE="${MESSAGE}\tNo new Homebrew updates\n"
else
  osascript -e 'display notification "Upgrading Homebrew Formulae. Nothing to do: job is planned for doing it. Stay flex!!" with title "New Homebrew updates available"'
  ${BREW} upgrade 2>&1 > /dev/null
  MESSAGE="${MESSAGE}\tUpgrading formulae:\n${outdated}\n"
fi

echo "${MESSAGE}"

${BREW} cleanup # little cleaning
${BREW} autoremove