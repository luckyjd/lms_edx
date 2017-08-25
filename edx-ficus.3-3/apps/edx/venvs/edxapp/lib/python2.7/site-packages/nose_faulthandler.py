
from nose.plugins.base import Plugin

import faulthandler


__version__ = '0.1'

import logging
log = logging.getLogger('nose.plugins.faulthandler')


class FaultHandler(Plugin):
    '''
    Activate `faulthandler` module before running tests.
    Enabled by default.
    '''

    enabled = True
    name = 'faulthandler'

    def options(self, parser, env):
        '''Register commandline options'''
        parser.add_option('--no-faulthandler', action='store_false',
                          dest='faulthandler', default=True,
                          help='Disable faulthandler module.')

    def configure(self, options, conf):
        '''Configure plugin.'''
        if not options.faulthandler:
            self.enabled = False

    def begin(self):
        log.info('Activating faulthandler module.')
        faulthandler.enable()
