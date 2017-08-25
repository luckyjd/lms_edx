"""
Tests of all installed XBlockUserStateClient backend implementations.

If you wish to include these tests in your own backend implementation
test suite, use the snippet:

    from edx_user_state_client.tests import UserStateClientTestBase

    class TestMyUserStateClient(UserStateClientTestBase):
        __test__ = True

        def setUp(self):
            super(TestDictUserStateClient, self).setUp()
            self.client = MyUserStateClient()  # Add your setup here

"""

from datetime import datetime
from unittest import TestCase

import pytz
from contracts import contract
from opaque_keys.edx.locator import BlockUsageLocator, CourseLocator
from xblock.fields import Scope

from edx_user_state_client.interface import XBlockUserStateClient, XBlockUserState


class _UserStateClientTestUtils(TestCase):
    """
    Utility methods for implementing blackbox XBlockUserStateClient tests.

    User and Block indexes should provide unique user ids and UsageKeys.
    Course indexes should be assigned to blocks by using integer division by 1000
    (this allows for tests of up to 1000 blocks per course).
    """

    __test__ = False

    scope = Scope.user_state
    client = None

    @contract(user=int)
    def _user(self, user):
        """Return the username for user ``user``."""
        return "user{}".format(user)

    @contract(block=int)
    def _block(self, block):
        """Return a UsageKey for the block ``block``."""
        course = block // 1000
        return BlockUsageLocator(
            self._course(course),
            self._block_type(block),
            'block{}'.format(block)
        )

    @contract(block=int)
    def _block_type(self, block):  # pylint: disable=unused-argument
        """Return the block type for the specified ``block``."""
        return 'block_type'

    @contract(course=int)
    def _course(self, course):
        """Return a CourseKey for the course ``course``"""
        return CourseLocator(
            'org{}'.format(course),
            'course{}'.format(course),
            'run{}'.format(course),
        )

    @contract(user=int, block=int, fields="list(string)|None")
    def get(self, user, block, fields=None):
        """
        Get the state for the specified user and block.

        This wraps :meth:`~XBlockUserStateClient.get`
        to take indexes rather than actual values to make tests easier
        to write concisely.
        """
        return self.client.get(
            username=self._user(user),
            block_key=self._block(block),
            scope=self.scope,
            fields=fields
        )

    @contract(user=int, block=int, state="dict(string:*)")
    def set(self, user, block, state):
        """
        Set the state for the specified user and block.

        This wraps :meth:`~XBlockUserStateClient.set`
        to take indexes rather than actual values to make tests easier
        to write concisely.
        """
        return self.client.set(
            username=self._user(user),
            block_key=self._block(block),
            state=state,
            scope=self.scope,
        )

    @contract(user=int, block=int, fields="list(string)|None")
    def delete(self, user, block, fields=None):
        """
        Delete the state for the specified user and block.

        This wraps :meth:`~XBlockUserStateClient.delete`
        to take indexes rather than actual values to make tests easier
        to write concisely.
        """
        return self.client.delete(
            username=self._user(user),
            block_key=self._block(block),
            scope=self.scope,
            fields=fields
        )

    @contract(user=int, blocks="list(int)", fields="list(string)|None")
    def get_many(self, user, blocks, fields=None):
        """
        Get the state for the specified user and blocks.

        This wraps :meth:`~XBlockUserStateClient.get_many`
        to take indexes rather than actual values to make tests easier
        to write concisely.
        """
        return self.client.get_many(
            username=self._user(user),
            block_keys=[self._block(block) for block in blocks],
            scope=self.scope,
            fields=fields,
        )

    @contract(user=int, block_to_state="dict(int: dict(string: *))")
    def set_many(self, user, block_to_state):
        """
        Set the state for the specified user and blocks.

        This wraps :meth:`~XBlockUserStateClient.set_many`
        to take indexes rather than actual values to make tests easier
        to write concisely.
        """
        return self.client.set_many(
            username=self._user(user),
            block_keys_to_state={
                self._block(block): state
                for block, state
                in block_to_state.items()
            },
            scope=self.scope,
        )

    @contract(user=int, blocks="list(int)", fields="list(string)|None")
    def delete_many(self, user, blocks, fields=None):
        """
        Delete the state for the specified user and blocks.

        This wraps :meth:`~XBlockUserStateClient.delete_many`
        to take indexes rather than actual values to make tests easier
        to write concisely.
        """
        return self.client.delete_many(
            username=self._user(user),
            block_keys=[self._block(block) for block in blocks],
            scope=self.scope,
            fields=fields,
        )

    @contract(user=int, block=int)
    def get_history(self, user, block):
        """
        Return the state history for the specified user and block.

        This wraps :meth:`~XBlockUserStateClient.get_history`
        to take indexes rather than actual values to make tests easier
        to write concisely.
        """
        return self.client.get_history(
            username=self._user(user),
            block_key=self._block(block),
            scope=self.scope,
        )

    @contract(block=int)
    def iter_all_for_block(self, block):
        """
        Yield the state for all users for the specified block.

        This wraps :meth:`~XBlockUserStateClient.iter_all_for_blocks`
        to take indexes rather than actual values, to make tests easier
        to write concisely.
        """
        return self.client.iter_all_for_block(
            block_key=self._block(block),
            scope=self.scope,
        )

    @contract(course=int, block_type="string|None")
    def iter_all_for_course(self, course, block_type=None):
        """
        Yield the state for all users for the specified block.

        This wraps :meth:`~XBlockUserStateClient.iter_all_for_blocks`
        to take indexes rather than actual values, to make tests easier
        to write concisely.
        """
        return self.client.iter_all_for_course(
            course_key=self._course(course),
            block_type=block_type,
            scope=self.scope,
        )


class _UserStateClientTestCRUD(_UserStateClientTestUtils):
    """
    Blackbox tests of basic XBlockUserStateClient get/set/delete functionality.
    """

    __test__ = False

    def test_set_get(self):
        self.set(user=0, block=0, state={'a': 'b'})
        self.assertEquals(self.get(user=0, block=0).state, {'a': 'b'})

    def test_set_get_get(self):
        self.set(user=0, block=0, state={'a': 'b'})
        self.assertEquals(self.get(user=0, block=0).state, {'a': 'b'})
        self.assertEquals(self.get(user=0, block=0).state, {'a': 'b'})

    def test_set_set_get(self):
        self.set(user=0, block=0, state={'a': 'b'})
        self.set(user=0, block=0, state={'a': 'c'})
        self.assertEquals(self.get(user=0, block=0).state, {'a': 'c'})

    def test_set_overlay(self):
        self.set(user=0, block=0, state={'a': 'b'})
        self.set(user=0, block=0, state={'b': 'c'})
        self.assertEquals(self.get(user=0, block=0).state, {'a': 'b', 'b': 'c'})

    def test_get_fields(self):
        self.set(user=0, block=0, state={'a': 'b', 'b': 'c'})
        self.assertEquals(self.get(user=0, block=0, fields=['a']).state, {'a': 'b'})
        self.assertEquals(self.get(user=0, block=0, fields=['b']).state, {'b': 'c'})
        self.assertEquals(self.get(user=0, block=0, fields=['a', 'b']).state, {'a': 'b', 'b': 'c'})

    def test_get_missing_block(self):
        self.set(user=0, block=1, state={})
        with self.assertRaises(self.client.DoesNotExist):
            self.get(user=0, block=0)

    def test_get_missing_user(self):
        self.set(user=1, block=0, state={})
        with self.assertRaises(self.client.DoesNotExist):
            self.get(user=0, block=0)

    def test_get_missing_field(self):
        self.set(user=0, block=0, state={'a': 'b'})
        self.assertEquals(self.get(user=0, block=0, fields=['a', 'b']).state, {'a': 'b'})

    def test_set_two_users(self):
        self.set(user=0, block=0, state={'a': 'b'})
        self.set(user=1, block=0, state={'b': 'c'})
        self.assertEquals(self.get(user=0, block=0).state, {'a': 'b'})
        self.assertEquals(self.get(user=1, block=0).state, {'b': 'c'})

    def test_set_two_blocks(self):
        self.set(user=0, block=0, state={'a': 'b'})
        self.set(user=0, block=1, state={'b': 'c'})
        self.assertEquals(self.get(user=0, block=0).state, {'a': 'b'})
        self.assertEquals(self.get(user=0, block=1).state, {'b': 'c'})

    def test_set_many(self):
        self.set_many(user=0, block_to_state={0: {'a': 'b'}, 1: {'b': 'c'}})
        self.assertEquals(self.get(user=0, block=0).state, {'a': 'b'})
        self.assertEquals(self.get(user=0, block=1).state, {'b': 'c'})

    def test_get_many(self):
        self.set_many(user=0, block_to_state={0: {'a': 'b'}, 1: {'b': 'c'}})
        self.assertItemsEqual(
            [(entry.username, entry.block_key, entry.state) for entry in self.get_many(user=0, blocks=[0, 1])],
            [
                (self._user(0), self._block(0), {'a': 'b'}),
                (self._user(0), self._block(1), {'b': 'c'})
            ]
        )

    def test_delete(self):
        with self.assertRaises(self.client.DoesNotExist):
            self.get(user=0, block=0)

        self.set(user=0, block=0, state={'a': 'b'})
        self.assertEqual(self.get(user=0, block=0).state, {'a': 'b'})

        self.delete(user=0, block=0)
        with self.assertRaises(self.client.DoesNotExist):
            self.get(user=0, block=0)

    def test_delete_partial(self):
        with self.assertRaises(self.client.DoesNotExist):
            self.get(user=0, block=0)

        self.set(user=0, block=0, state={'a': 'b', 'b': 'c'})
        self.assertEqual(self.get(user=0, block=0).state, {'a': 'b', 'b': 'c'})

        self.delete(user=0, block=0, fields=['a'])
        self.assertEqual(self.get(user=0, block=0).state, {'b': 'c'})

    def test_delete_last_field(self):
        with self.assertRaises(self.client.DoesNotExist):
            self.get(user=0, block=0)

        self.set(user=0, block=0, state={'a': 'b'})
        self.assertEqual(self.get(user=0, block=0).state, {'a': 'b'})

        self.delete(user=0, block=0, fields=['a'])
        with self.assertRaises(self.client.DoesNotExist):
            self.get(user=0, block=0)

    def test_delete_many(self):
        self.assertItemsEqual(self.get_many(user=0, blocks=[0, 1]), [])

        self.set_many(user=0, block_to_state={
            0: {'a': 'b'},
            1: {'b': 'c'},
        })

        self.delete_many(user=0, blocks=[0, 1])
        self.assertItemsEqual(self.get_many(user=0, blocks=[0, 1]), [])

    def test_delete_many_partial(self):
        self.assertItemsEqual(self.get_many(user=0, blocks=[0, 1]), [])

        self.set_many(user=0, block_to_state={
            0: {'a': 'b'},
            1: {'b': 'c'},
        })

        self.delete_many(user=0, blocks=[0, 1], fields=['a'])
        self.assertItemsEqual(
            [(entry.block_key, entry.state) for entry in self.get_many(user=0, blocks=[0, 1])],
            [(self._block(1), {'b': 'c'})]
        )

    def test_delete_many_last_field(self):
        self.assertItemsEqual(self.get_many(user=0, blocks=[0, 1]), [])

        self.set_many(user=0, block_to_state={
            0: {'a': 'b'},
            1: {'b': 'c'},
        })

        self.delete_many(user=0, blocks=[0, 1], fields=['a', 'b'])
        self.assertItemsEqual(self.get_many(user=0, blocks=[0, 1]), [])

    def test_get_mod_date(self):
        start_time = datetime.now(pytz.utc)
        self.set_many(user=0, block_to_state={0: {'a': 'b'}, 1: {'b': 'c'}})
        end_time = datetime.now(pytz.utc)

        mod_dates = self.get(user=0, block=0)

        self.assertItemsEqual(mod_dates.state.keys(), ["a"])
        self.assertGreater(mod_dates.updated, start_time)
        self.assertLess(mod_dates.updated, end_time)

    def test_get_many_mod_date(self):
        start_time = datetime.now(pytz.utc)
        self.set_many(
            user=0,
            block_to_state={0: {'a': 'b'}, 1: {'a': 'd'}})
        mid_time = datetime.now(pytz.utc)
        self.set_many(
            user=0,
            block_to_state={1: {'a': 'c'}})
        end_time = datetime.now(pytz.utc)

        mod_dates = list(self.get_many(
            user=0,
            blocks=[0, 1],
            fields=["a"]))

        self.assertItemsEqual(
            [result.block_key for result in mod_dates],
            [self._block(0), self._block(1)])
        self.assertItemsEqual(
            mod_dates[0].state.keys(),
            ["a"])
        self.assertGreater(mod_dates[0].updated, start_time)
        self.assertLess(mod_dates[0].updated, mid_time)
        self.assertItemsEqual(
            mod_dates[1].state.keys(),
            ["a"])
        self.assertGreater(mod_dates[1].updated, mid_time)
        self.assertLess(mod_dates[1].updated, end_time)


class _UserStateClientTestHistory(_UserStateClientTestUtils):
    """
    Blackbox tests of basic XBlockUserStateClient history functionality.
    """

    __test__ = False

    def test_empty_history(self):
        with self.assertRaises(self.client.DoesNotExist):
            next(self.get_history(user=0, block=0))

    def test_single_history(self):
        self.set(user=0, block=0, state={'a': 'b'})
        self.assertEquals(
            [history.state for history in self.get_history(user=0, block=0)],
            [{'a': 'b'}]
        )

    def test_multiple_history_entries(self):
        for val in xrange(3):
            self.set(user=0, block=0, state={'a': val})

        history = list(self.get_history(user=0, block=0))

        self.assertEquals(
            [entry.state for entry in history],
            [{'a': 2}, {'a': 1}, {'a': 0}]
        )

        # Assert that the update times are reverse sorted (by
        # actually reverse-sorting them, and then asserting that
        # the sorted version is the same as the initial version)
        self.assertEquals(
            [entry.updated for entry in history],
            sorted((entry.updated for entry in history), reverse=True)
        )

    def test_history_distinct(self):
        self.set(user=0, block=0, state={'a': 0})
        self.set(user=0, block=1, state={'a': 1})

        self.assertEquals(
            [history.state for history in self.get_history(user=0, block=0)],
            [{'a': 0}]
        )
        self.assertEquals(
            [history.state for history in self.get_history(user=0, block=1)],
            [{'a': 1}]
        )

    def test_history_after_delete(self):
        self.set(user=0, block=0, state={str(val): val for val in xrange(3)})
        for val in xrange(3):
            self.delete(user=0, block=0, fields=[str(val)])

        self.assertEquals(
            [history.state for history in self.get_history(user=0, block=0)],
            [
                None,
                {'2': 2},
                {'2': 2, '1': 1},
                {'2': 2, '1': 1, '0': 0}
            ]
        )

    def test_set_many_with_history(self):
        self.set_many(user=0, block_to_state={0: {'a': 0}, 1: {'a': 1}})

        self.assertEquals(
            [history.state for history in self.get_history(user=0, block=0)],
            [{'a': 0}]
        )
        self.assertEquals(
            [history.state for history in self.get_history(user=0, block=1)],
            [{'a': 1}]
        )


class _UserStateClientTestIterAll(_UserStateClientTestUtils):
    """
    Blackbox tests of basic XBlockUserStateClient global iteration functionality.
    """

    __test__ = False

    def test_iter_blocks_empty(self):
        self.assertItemsEqual(
            self.iter_all_for_block(block=0),
            []
        )

    def test_iter_blocks_single_user(self):
        self.set_many(user=0, block_to_state={0: {'a': 'b'}, 1: {'c': 'd'}})

        self.assertItemsEqual(
            (item.state for item in self.iter_all_for_block(block=0)),
            [{'a': 'b'}]
        )

        self.assertItemsEqual(
            (item.state for item in self.iter_all_for_block(block=1)),
            [{'c': 'd'}]
        )

    def test_iter_blocks_many_users(self):
        for user in xrange(3):
            self.set_many(user, {0: {'a': user}, 1: {'c': user}})

        self.assertItemsEqual(
            ((item.username, item.state) for item in self.iter_all_for_block(block=0)),
            [
                (self._user(0), {'a': 0}),
                (self._user(1), {'a': 1}),
                (self._user(2), {'a': 2}),
            ]
        )

    def test_iter_blocks_deleted_block(self):
        for user in xrange(3):
            self.set_many(user, {0: {'a': user}, 1: {'c': user}})

        self.delete(user=1, block=0)

        self.assertItemsEqual(
            ((item.username, item.state) for item in self.iter_all_for_block(block=0)),
            [
                (self._user(0), {'a': 0}),
                (self._user(2), {'a': 2}),
            ]
        )

    def test_iter_course_empty(self):
        self.assertItemsEqual(
            self.iter_all_for_course(course=0),
            []
        )

    def test_iter_course_single_user(self):
        self.set_many(user=0, block_to_state={0: {'a': 'b'}, 1001: {'c': 'd'}})

        self.assertItemsEqual(
            (item.state for item in self.iter_all_for_course(course=0)),
            [{'a': 'b'}]
        )

        self.assertItemsEqual(
            (item.state for item in self.iter_all_for_course(course=1)),
            [{'c': 'd'}]
        )

    def test_iter_course_many_users(self):
        for user in xrange(2):
            for course in xrange(2):
                self.set_many(
                    user,
                    block_to_state={
                        course * 1000 + 0: {'course': course},
                        course * 1000 + 1: {'user': user}
                    }
                )

        self.assertItemsEqual(
            ((item.username, item.block_key, item.state) for item in self.iter_all_for_course(course=1)),
            [
                (self._user(0), self._block(1000), {'course': 1}),
                (self._user(0), self._block(1001), {'user': 0}),
                (self._user(1), self._block(1000), {'course': 1}),
                (self._user(1), self._block(1001), {'user': 1}),
            ]
        )

    def test_iter_course_deleted_block(self):
        for user in xrange(2):
            for course in xrange(2):
                self.set_many(
                    user,
                    block_to_state={
                        course * 1000 + 0: {'course': user},
                        course * 1000 + 1: {'user': user}
                    }
                )

        self.delete(user=1, block=0)
        self.delete(user=1, block=1001)

        self.assertItemsEqual(
            ((item.username, item.block_key, item.state) for item in self.iter_all_for_course(course=0)),
            [
                (self._user(0), self._block(0), {'course': 0}),
                (self._user(0), self._block(1), {'user': 0}),
                (self._user(1), self._block(1), {'user': 1}),
            ]
        )

        self.assertItemsEqual(
            ((item.username, item.block_key, item.state) for item in self.iter_all_for_course(course=1)),
            [
                (self._user(0), self._block(1000), {'course': 0}),
                (self._user(0), self._block(1001), {'user': 0}),
                (self._user(1), self._block(1000), {'course': 1}),
            ]
        )


class UserStateClientTestBase(_UserStateClientTestCRUD,
                              _UserStateClientTestHistory,
                              _UserStateClientTestIterAll):
    """
    Blackbox tests for XBlockUserStateClient implementations.
    """

    __test__ = False


class DictUserStateClient(XBlockUserStateClient):
    """
    The simplest possible in-memory implementation of DictUserStateClient,
    for testing the tests.
    """
    def __init__(self):
        self._history = {}

    def _add_state(self, username, block_key, scope, state):
        """
        Add the specified state to the state history of this block.
        """
        history_list = self._history.setdefault((username, block_key, scope), [])
        history_list.insert(0, XBlockUserState(username, block_key, state, datetime.now(pytz.utc), scope))

    def get_many(self, username, block_keys, scope=Scope.user_state, fields=None):
        for key in block_keys:
            if (username, key, scope) not in self._history:
                continue

            entry = self._history[(username, key, scope)][0]

            if entry.state is None:
                continue

            if fields is None:
                current_fields = entry.state.keys()
            else:
                current_fields = fields

            yield entry._replace(state={
                field: entry.state[field]
                for field in current_fields
                if field in entry.state
            })

    def set_many(self, username, block_keys_to_state, scope=Scope.user_state):
        for key, state in block_keys_to_state.items():
            if (username, key, scope) in self._history:
                current_state = self._history[(username, key, scope)][0].state.copy()
                current_state.update(state)
                self._add_state(username, key, scope, current_state)
            else:
                self._add_state(username, key, scope, state)

    def delete_many(self, username, block_keys, scope=Scope.user_state, fields=None):
        for key in block_keys:
            if (username, key, scope) not in self._history:
                continue

            if fields is None:
                self._add_state(username, key, scope, None)
            else:
                state = self._history[(username, key, scope)][0].state.copy()
                for field in fields:
                    if field in state:
                        del state[field]
                if not state:
                    self._add_state(username, key, scope, None)
                else:
                    self._add_state(username, key, scope, state)

    def get_history(self, username, block_key, scope=Scope.user_state):
        """
        Retrieve history of state changes for a given block for a given
        student.  We don't guarantee that history for many blocks will be fast.

        If the specified block doesn't exist, raise :class:`~DoesNotExist`.

        Arguments:
            username: The name of the user whose history should be retrieved.
            block_key (UsageKey): The UsageKey identifying which xblock history to retrieve.
            scope (Scope): The scope to load data from.

        Yields:
            UserStateHistory entries for each modification to the specified XBlock, from latest
            to earliest.
        """
        if (username, block_key, scope) not in self._history:
            raise self.DoesNotExist(username, block_key, scope)

        for entry in self._history[(username, block_key, scope)]:
            yield entry

    def iter_all_for_block(self, block_key, scope=Scope.user_state, batch_size=None):
        """
        You get no ordering guarantees. Fetching will happen in batch_size
        increments. If you're using this method, you should be running in an
        async task.
        """
        for (_, key, scope), entries in self._history.iteritems():
            if entries[0].state is None:
                continue

            if key == block_key and scope == scope:
                yield entries[0]

    def iter_all_for_course(self, course_key, block_type=None, scope=Scope.user_state, batch_size=None):
        """
        You get no ordering guarantees. Fetching will happen in batch_size
        increments. If you're using this method, you should be running in an
        async task.
        """
        for (_, key, scope), entries in self._history.iteritems():
            if entries[0].state is None:
                continue

            if (
                    key.course_key == course_key and
                    scope == scope and
                    (block_type is None or key.block_type == block_type)
            ):

                yield entries[0]


class TestDictUserStateClient(UserStateClientTestBase):
    """
    Tests of the DictUserStateClient backend.
    """
    __test__ = True

    def setUp(self):
        super(TestDictUserStateClient, self).setUp()
        self.client = DictUserStateClient()
