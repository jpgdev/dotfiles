import subprocess
import yaml
from getch import getch


# Move this
def load_yml_file(path):
    stream = open(path, "r")
    docs = yaml.load(stream)
    return docs


class PacmanHelper:
    def install(self, packages, only_needed=True):
        cmd = ["pacman", "-S"] + packages

        if only_needed is True:
            cmd.append("--needed")

        # Run the command
        p = subprocess.Popen(cmd, stderr=subprocess.PIPE)
        output, error = p.communicate()

        # If error
        if p.returncode is not 0:
            error_str = error.decode("utf-8")
            # lines = error_str.split('\n')
            # print(lines)

            raise PacmanException(
                message=error_str, args=cmd, status_code=p.returncode)

            # # If error is 'package not found'
            # not_found_pos = error_str.find('not found')
            # need_root = error_str.find('root')
            # if not_found_pos > 0:
            #     semi_colon_pos = error_str.find(':')
            #     missing_pkgs = []
            #     for line in lines:
            #         # Split the string to get the packages names
            #         missing_pkgs.append(line[not_found_pos + semi_colon_pos:])
            #     raise PacmanException(
            #         message='Pacman could not find this packages: '
            #         ', '.join(missing_pkgs),
            #         args=cmd)
            #
            #     raise PacmanException(message=error_str, args=cmd)
            # if need_root > 0:
            #     raise PacmanException(message=error_str, args=cmd)
            # else:
            #     raise PacmanException(
            #         message='There was an unknown error while installing '
            #         'packages with pacman',
            #         args=cmd)

            # print('Process result : ', p.returncode, p.stderr, p.stdout)

        return p.return_code

    def load_and_install_packages(self,
                                  path,
                                  get_confirmation=True,
                                  pkgs_name='pkgs'):

        yaml_file = load_yml_file(path)

        if pkgs_name not in yaml_file:
            raise Exception(pkgs_name, ' not found in the package yaml file')

        base_pkgs = yaml_file[pkgs_name]

        if get_confirmation is True:
            str_pkgs = ', '.join(base_pkgs)
            print('Install theses packages (Y/n)?')
            print('-> ', str_pkgs)

            ch = getch()
            if ch is 'n':
                print('The installation was cancelled')
                return False
        try:
            # self.install(["dsfdsadd", "sdf", "dsf"])
            # status_code = pacman_install(["git"], only_needed=False)
            self.install(base_pkgs)
        except PacmanException as e:
            # print('There was an error with pacman ')
            # print('The command ran -> "', ' '.join(e.args), '"')
            print(e.message)
            return False

        return True


class PacmanException(Exception):
    default_message = 'There was an unknown error with pacman'

    def __init__(self, message=default_message, status_code=0, args=[]):
        self.args = args
        self.message = message
        self.status_code = status_code
