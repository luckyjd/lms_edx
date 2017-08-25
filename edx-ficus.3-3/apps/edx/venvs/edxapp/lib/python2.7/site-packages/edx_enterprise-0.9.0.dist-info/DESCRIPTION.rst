enterprise
=============================

.. image:: https://img.shields.io/pypi/v/edx-enterprise.svg
    :target: https://pypi.python.org/pypi/edx-enterprise/
    :alt: PyPI

.. image:: https://travis-ci.org/edx/edx-enterprise.svg?branch=master
    :target: https://travis-ci.org/edx/edx-enterprise
    :alt: Travis

.. image:: http://codecov.io/github/edx/edx-enterprise/coverage.svg?branch=master
    :target: http://codecov.io/github/edx/edx-enterprise?branch=master
    :alt: Codecov

.. image:: http://edx-enterprise.readthedocs.io/en/latest/?badge=latest
    :target: http://edx-enterprise.readthedocs.io/en/latest/
    :alt: Documentation

.. image:: https://img.shields.io/pypi/pyversions/edx-enterprise.svg
    :target: https://pypi.python.org/pypi/edx-enterprise/
    :alt: Supported Python versions

.. image:: https://img.shields.io/github/license/edx/edx-enterprise.svg
    :target: https://github.com/edx/edx-enterprise/blob/master/LICENSE.txt
    :alt: License

``Enterprise`` app provides enterprise features to Open edX platform. Most of such features are
structured around ``Enterprise Customer`` - an organization or a group of people that "consumes"
courses on Open edX platform.

Overview
--------

The ``README.rst`` file should then provide an overview of the code in this
repository, including the main components and useful entry points for starting
to understand the code in more detail.

Documentation
-------------

The full documentation is at https://edx-enterprise.readthedocs.org.

License
-------

The code in this repository is licensed under the AGPL 3.0 unless
otherwise noted.

Please see ``LICENSE.txt`` for details.

How To Contribute
-----------------

Contributions are very welcome.

Please read `How To Contribute <https://github.com/edx/edx-platform/blob/master/CONTRIBUTING.rst>`_ for details.

Even though they were written with ``edx-platform`` in mind, the guidelines
should be followed for Open edX code in general.

PR description template can be found at
`PR_TEMPLATE.md <https://github.com/edx/edx-enterprise/blob/master/PR_TEMPLATE.md>`_

Reporting Security Issues
-------------------------

Please do not report security issues in public. Please email security@edx.org.

Getting Help
------------

Have a question about this repository, or about Open edX in general?  Please
refer to this `list of resources`_ if you need any assistance.

.. _list of resources: https://open.edx.org/getting-help


Change Log
----------

..
   All enhancements and patches to cookiecutter-django-app will be documented
   in this file.  It adheres to the structure of http://keepachangelog.com/ ,
   but in reStructuredText instead of Markdown (for ease of incorporation into
   Sphinx documentation and the PyPI description).

   This project adheres to Semantic Versioning (http://semver.org/).

.. There should always be an "Unreleased" section for changes pending release.

Unreleased
~~~~~~~~~~

[0.9.0] - 2016-12-29
~~~~~~~~~~~~~~~~~~~~

Added
-----

* In django admin page for enterprise customer added alphabetical ordering for
  catalog drop down and displayed catalog details link next to selected catalog.


[0.8.0] - 2016-12-08
~~~~~~~~~~~~~~~~~~~~

Added
-----

* added the branding information api methods to return the enterprise customer logo on the basis of provider_id or uuid.
* Updated the logo image validator to take an image of size maximum of 4kb.

[0.7.0] - 2016-12-07
~~~~~~~~~~~~~~~~~~~~

Added
-----

* Added a feature to enroll users in a course while linking them to an
  enterprise customer.


[0.6.0] - 2016-12-04
~~~~~~~~~~~~~~~~~~~~

Added
_____

* Fixed EnterpriseCustomer form to make Catalog field optional
* Added user bulk linking option
* Added Data Sharing Consent feature


[0.5.0] - 2016-11-28
~~~~~~~~~~~~~~~~~~~~

Added
_____

* Added checks to make sure enterprise customer and identity provider has one-to-one relation.
* Added a helper method to retrieve enterprise customer branding information


[0.4.1] - 2016-11-24
~~~~~~~~~~~~~~~~~~~~

Added
_____

* Fixed User.post_save handler causing initial migrations to fail

[0.4.0] - 2016-11-21
~~~~~~~~~~~~~~~~~~~~

Added
_____

* Set up logic to call course catalog API to retrieve catalog listing to attach to EnterpriseCustomer.


[0.3.1] - 2016-11-21
~~~~~~~~~~~~~~~~~~~~

* Fixed missing migration.

[0.3.0] - 2016-11-16
~~~~~~~~~~~~~~~~~~~~

Added
_____

* Added Pending Enterprise Customer User model - keeps track of user email linked to Enterprise Customer, but not
  yet used by any user.
* Added custom "Manage Learners" admin view.

Technical features
------------------

* Added sphinx-napoleon plugin to support rendering Google Style docstrings into documentation properly (i.e.
  make it recognize function arguments, returns etc.)
* Added translation files


[0.2.0] - 2016-11-15
~~~~~~~~~~~~~~~~~~~~

Added
_____

* Linked EnterpriseCustomer model to Identity Provider model


[0.1.2] - 2016-11-04
~~~~~~~~~~~~~~~~~~~~

Added
_____

* Linked EnterpriseCustomer model to django Site model


[0.1.1] - 2016-11-03
~~~~~~~~~~~~~~~~~~~~

Added
_____

* Enterprise Customer Branding Model and Django admin integration


[0.1.0] - 2016-10-13
~~~~~~~~~~~~~~~~~~~~

Added
_____

* First release on PyPI.
* Models and Django admin integration


