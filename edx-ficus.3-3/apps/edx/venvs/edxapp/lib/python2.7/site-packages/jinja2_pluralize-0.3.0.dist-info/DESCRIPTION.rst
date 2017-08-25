===============================
Jinja2 Pluralize
===============================

.. image:: https://img.shields.io/pypi/v/jinja2_pluralize.svg?style=flat
        :target: https://pypi.python.org/pypi/jinja2_pluralize

.. image:: https://travis-ci.org/audreyr/jinja2_pluralize.svg?branch=master
        :target: https://travis-ci.org/audreyr/jinja2_pluralize

.. image:: https://api.codacy.com/project/badge/eb497c487012455688a62383afccccb7
    :target: https://www.codacy.com/app/aroy/jinja2_pluralize

.. image:: https://img.shields.io/pypi/pyversions/jinja2_pluralize.svg?style=flat

.. image:: https://img.shields.io/pypi/status/jinja2_pluralize.svg?style=flat

Jinja2 pluralize filters.

* Free software: BSD license
* Documentation: http://jinja2-pluralize.readthedocs.org

Features
--------

1. Simple pluralize filter based on inflect.py. For example, this renders as `geese`:

.. code-block:: jinja

    {{ 'goose'|pluralize }}

2. Django-style pluralize filter. Works as described in the `Django docs`_. For example, this renders as `votes`:

.. code-block:: jinja

    vote{{ 0|pluralize }}

.. _`Django docs`: https://docs.djangoproject.com/en/dev/ref/templates/builtins/#pluralize

Usage
-----

To use it with Jinja2, update the `filters` dict on the environment like this:

.. code-block:: python

    from jinja2 import Environment
    from jinja2_pluralize import pluralize_dj

    env = Environment()
    env.filters['pluralize'] = pluralize_dj
    tmpl = env.from_string('vote{{ 0|pluralize }}')
    assert tmpl.render() == 'votes'





History
-------

0.3.0 (2015-10-09)
------------------

* Fix RST formatting on PyPI.
* Stable status.
* Test on Python 3.4 and 3.5.
* Add more badges to README.

0.2.1 (2014-07-09)
--------------------

* Remove the shebang from `__init__.py` (`#2`_), thanks to `@dashea`_.

.. _`#2`: https://github.com/audreyr/jinja2_pluralize/pull/2
.. _`@dashea`: https://github.com/dashea

0.2.0 (2014-07-02)
--------------------

* Package works as per the README.

0.1.0 (2014-04-25)
--------------------

* First release on PyPI.

