from django.conf import settings


ALLOWED_HTTP_METHODS = getattr(settings,
                               'METHOD_OVERRIDE_ALLOWED_HTTP_METHODS',
                               ['GET', 'HEAD', 'PUT', 'POST', 'DELETE', 'OPTIONS', 'PATCH'])

PARAM_KEY = getattr(settings,
                    'METHOD_OVERRIDE_PARAM_KEY',
                    '_method')

HTTP_HEADER = getattr(settings,
                      'METHOD_OVERRIDE_HTTP_HEADER',
                      'HTTP_X_HTTP_METHOD_OVERRIDE')

INPUT_TEMPLATE = getattr(settings,
                         'METHOD_OVERRIDE_INPUT_TEMPLATE',
                         '<input type="hidden" name="{name}" value="{value}">')
