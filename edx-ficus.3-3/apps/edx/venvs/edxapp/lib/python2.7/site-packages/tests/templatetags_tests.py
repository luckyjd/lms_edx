from mock import *
from nose.tools import *

from method_override.templatetags.method_override import *


class TestTemplateTags(object):
    def test_method_override(self):
        result = method_override('PUT')
        assert_equal(result, '<input type="hidden" name="_method" value="PUT">')
