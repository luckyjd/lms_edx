from mock import *
from nose.tools import *

from method_override.middleware import *


class TestMethodOverrideMiddleware(object):
    def test_noop(self):
        request = MagicMock()
        request.method = 'POST'
        request.POST = {}
        middleware = MethodOverrideMiddleware()
        middleware.process_view(request, None, [], {})
        assert_equal(request.method, 'POST')

    def test_get_param_noop(self):
        request = MagicMock()
        request.method = 'GET'
        request.POST = {'_method': 'PUT'}
        middleware = MethodOverrideMiddleware()
        middleware.process_view(request, None, [], {})
        assert_equal(request.method, 'GET')

    def test_unsupported_method(self):
        request = MagicMock()
        request.method = 'POST'
        request.POST = {'_method': 'DESTROY'}
        middleware = MethodOverrideMiddleware()
        middleware.process_view(request, None, [], {})
        assert_equal(request.method, 'POST')

    def test_param_put_override(self):
        request = MagicMock()
        request.method = 'POST'
        request.POST = {'_method': 'PUT'}
        middleware = MethodOverrideMiddleware()
        middleware.process_view(request, None, [], {})
        assert_equal(request.method, 'PUT')

    def test_param_put_query_dict(self):
        request = MagicMock()
        request.method = 'POST'
        request.POST = {'_method': 'PUT', 'name': 'Bob'}
        middleware = MethodOverrideMiddleware()
        middleware.process_view(request, None, [], {})
        assert_equal(request.PUT.get('name'), 'Bob')

    def test_lowercase_param(self):
        request = MagicMock()
        request.method = 'POST'
        request.POST = {'_method': 'put'}
        middleware = MethodOverrideMiddleware()
        middleware.process_view(request, None, [], {})
        assert_equal(request.method, 'PUT')

    def test_header_override(self):
        request = MagicMock()
        request.method = 'POST'
        request.POST = {}
        request.META = {'HTTP_X_HTTP_METHOD_OVERRIDE': 'PUT'}
        middleware = MethodOverrideMiddleware()
        middleware.process_view(request, None, [], {})
        assert_equal(request.method, 'PUT')
