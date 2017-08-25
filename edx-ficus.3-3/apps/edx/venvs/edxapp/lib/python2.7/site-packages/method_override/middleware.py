from method_override import settings


__all__ = ['MethodOverrideMiddleware']


class MethodOverrideMiddleware(object):
    def process_view(self, request, callback, callback_args, callback_kwargs):
        if request.method != 'POST':
            return
        method = self._get_method_override(request)
        if method in settings.ALLOWED_HTTP_METHODS:
            setattr(request, method, request.POST.copy())
            request.method = method

    def _get_method_override(self, request):
        method = (request.POST.get(settings.PARAM_KEY) or
                  request.META.get(settings.HTTP_HEADER))
        return method and method.upper()
