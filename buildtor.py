#!/usr/bin/python
#
# Author: Antitree
# Tor build script
# Designed to automatically compile Tor and
# wrap it into a DEB for the raspberry pi
#
import subprocess
import re, glob
import logging
import os, argparse, sys, shutil
import time
from email.mime.text import MIMEText

class BuildTor:
    def __init__(self, srcpath):
        self.version = ""
        self.srcpath = srcpath
        self.path = ""
        self.result = "Incomplete"
        self.update = "Incomplete"
        self.force = True  # Force an update even if it's already done
        self.DEBUG = False  # don't perform actions, just test
        self.ERROR = None  # build check variable
        self.quiet = False
        self.signkey = None
        self.start = self.timestamp()
        self.finish = None
        self.logfile = self.srcpath + "/torbuild.log"
        self.set_logging(self.logfile)
        os.chdir(self.srcpath)

    def set_logging(self, logpath):
        logging.basicConfig(filename=logpath,level=logging.DEBUG)
        logging.debug("Logging started %s", self.start)

    def timestamp(self):
        return time.time()

    def cleanup(self):
        '''Cleanup old files'''
        try:
            logging.debug("Cleaning up old files")
            shutil.rmtree(self.path)
        except:
            logging.debug("ERROR: Unable to cleanup old directory")
        logging.debug("Cleanup complete")

    def set_version(self, value):
        ##TODO check formatting
        vpattern = r"[0-9]+\.[0-9]+\.[0-9]+(?:\.[0-9]+)"
        if len(re.findall(vpattern, value)):  # TODO make better
            self.version = value
            logging.debug("Setting Tor version: %s", value)
        else:
            logging.debug("Improper Tor version found: %s" % value)

    def set_path(self, value):
        ##TODO add checks to make sure that the path
        ## contains the tor source
        self.path = value
        logging.debug("Path set to %s", value)

    def update_source(self):
        ''' Update the Tor source code '''
        commands = ['sudo', 'apt-get', 'update']
        out, err, rc = self._execute(commands)
        logging.debug("Results of apt-get update command are: %s %s", out, err)
        if rc is not 0:
            logging.debug("Error executing apt-get. Are you in the sudoers file?")
            self.ERROR = True
        else:
            logging.debug("Apt-get update command successful")

        commands = ['apt-get', 'source', 'tor']
        out, err, rc = self._execute(commands)
        if rc is not 0:
            logging.debug("Error updating source.")
            self.ERROR = True
        else:
            logging.debug("Source update successful")
        ##TODO subprocess does not return this text.
        aptpat = r"(Skipping already downloaded file \'tor_[0-9].*)+(orig\.tar\.gz\'$)"
        if len(re.findall(aptpat, out)) > 0:
            self.update = "No new updates found"
        else:
            self.update = "New updates found"

    def find_version(self):
        ''' Find the version of Tor based on the source directories '''
        dirs = glob.glob("tor-[0-9]*[0-9]")
        if len(dirs) == 0:
            logging.debug("Could not find tor dir. Found: %s" % dirs)
            self.update_source()
            logging.debug("Re-downloaded source")
            if len(dirs) == 1:
                path = dirs[0]
                version = path[4:]
            else:
                self.ERROR = True
        elif len(dirs) > 1:
            logging.debug("More than one tor dir")
            self.ERROR = True
        else:
            path = dirs[0]
            version = path[4:]
            logging.debug("path and version set to %s and %s" % (path, version))

        self.set_version(version)
        self.set_path(path)

    def _execute(self, commands):
        ''' private function to execute os commands '''
        try:
            logging.debug("Executing command: %s", commands)
            exe = subprocess.Popen(commands, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

            out, err = exe.communicate()
            ## TODO this is a hack to get around the None cond
            if not out:
                out = "No output"
            if not err:
                err = "No error"

            rc = exe.returncode
            if rc != 0:
                logging.debug(
                    "Error executing shell command: \n"
                    "Output\n%s\n"
                    "Errors:\n%s\n"
                    % (out, err)
                )
                return out, err, rc
            else:
                return out, err, rc
        except:
            print("Invalid command format: %s" % commands)
            self.ERROR = True

    def mail_results(self):
        ''' Send an email with the results of the process '''
        msg = MIMEText(
            "== Tor Builder Report ==\n"
            "Start time: %s\n"
            "End time: %s\n"
            "Tor Version: %s \n"
            "Error Status: %s \n"
            "Result: %s \n"
            "========================"
            % (
                self.start,
                self.finish,
                self.version,
                self.ERROR,
                self.result
            )
        )
        msg["From"] = self.mfrom
        msg["To"] = self.mto
        msg["Subject"] = self.msubject


        logging.debug("Sending mail from %s to %s, with a subject of %s", self.mfrom, self.mto, self.msubject)
        try:
            p = subprocess.Popen(
                ["/usr/sbin/sendmail", "-t"],
                stdin=subprocess.PIPE
            )
            p.communicate(msg.as_string())
        except:
            logging.error("Error sending email")
            self.ERROR = True

    def set_mail(self, mto, mfrom="root@localhost", msubject=None):
        ''' Configure who to send the reports to '''
        self.mto = mto
        self.mfrom = mfrom
        if not msubject:
            self.msubject = "Tor Build Status: %s" % self.result
        else:
            self.msubject = msubject

    def check_debs(self):
        ''' Find which deb files have already been build'''
        ##TODO unused
        for file in glob.glob("*.deb"):
            print(file)

    def git(self):
        '''Commit and push results to git'''
        try:
            torfile = glob.glob("tor_"+self.version+"*armhf.deb")[0]
        except:
            logging.debug("ERROR: Cannot find valid deb file that was built")
            self.status = "Failed"
            sys.exit()
        # Move file to latest.deb
        shutil.copy(torfile, "latest.deb")
        logging.debug("Copied %s to latest.deb", torfile)
        # git commit $version.deb
        gitcmds = ['git', 'add', torfile]
        o, e, r = self._execute(gitcmds)
        if e:
            logging.debug("Error executing git add command")
        else:
            logging.debug("Added file to git")
        gitcmds = ['git', 'commit', '-am', "Autobuilding: " + torfile]
        o, e, r = self._execute(gitcmds)
        if e:
            logging.debug("Error commiting files to git")
        if not self.DEBUG:
            gitcmds = ['git', 'push']
            o, e, r = self._execute(gitcmds)
            if not e:
                logging.debug("Git push completed successfully")

    def build(self):
        ##TODO execut command to build
        os.chdir(self.path)

        ##TODO add ./configure handling if this is a brand new system

        if self.signkey:
            commands = ["debuild", "-rfakeroot", "-k%s" % self.signkey] # sign with key
        else:
            logging.warning("No signing key found. The package will not be signed")
            commands = ["debuild", "-rfakeroot", "-uc", "-us"] # do not sign

        out, err, rc = self._execute(commands)

        ##TODO check for actual confirmation that it was successful
        if rc is not 0:
            self.result = "Failed"
            print(err)
            print(out)
        else:
            self.result = "Success"
            logging.debug(out)
        os.chdir(self.srcpath)

        # dpkg-sig -k 0x6FD1635C --sign pi tor_0.2.5.10-1~d70.wheezy+1_armhf.deb
        torfile = glob.glob("tor_"+self.version+"*armhf.deb")[0] # TODO do this gooder
        commands = ["dpkg-sig","-k",self.signkey,"--sign", "buildbot", torfile]
        out, err, rc = self._execute(commands)

        if rc is not 0:
            self.result = "Failed"
            print(err)
            print(out)
        else:
            self.result = "Success"
            logging.debug(out)

def main():
    # get command line arguments
    parser = argparse.ArgumentParser(
        description='Auto-build the Tor debian package')
    parser.add_argument("path",
        help='Path to tor-arm-source directory')
    parser.add_argument('-t',
        dest='to',
        help='Email address to send alerts to')
    parser.add_argument('-f',
        dest='frm',
        help="Email address to send alerts from")
    parser.add_argument('-k',
        dest='sig',
        help="Signing key for the deb package (optional)")
    # TODO: add quiet, force, and DEBUG options

    args = parser.parse_args()

    if not args.path:
        print("You need to supply path to the arm-tor-source directory")
        sys.exit()
    else:
        build = BuildTor(args.path)

    if not args.to and args.frm:
        print("Email information mandatory. Use -t and -f")
        sys.exit()

    if args.sig:
        print("Signing key set to %s" % args.sig)
        build.signkey = args.sig

    try:
        if not build.ERROR:
            # find versions installed
            build.find_version()
        if not build.ERROR:
            # cleanup
            build.cleanup()
            # update tor source
        if not build.ERROR:
            build.update_source()
            # See if new versions were downloaded
        if not build.ERROR:
            build.find_version()
        if not build.ERROR:
            # build
            if not build.DEBUG:
                build.build()
            # set end time
            build.result = "Completed successfully"
    except:
        logging.exception("Build process failed!!!")

    try:   # email results
        build.set_mail(args.to, args.frm)
        build.mail_results()
    except:
        logging.exception("Could not email results")

    # TODO move build deb to latest
    if not build.ERROR:
        build.git()
    # TODO verify everything is correct
    # Timstamp finish
    build.finish = build.timestamp

if __name__ == '__main__':
    main()
