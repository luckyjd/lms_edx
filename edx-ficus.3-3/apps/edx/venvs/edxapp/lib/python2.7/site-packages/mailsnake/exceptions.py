class MailSnakeException(Exception): pass

class SystemException(MailSnakeException): pass
class NetworkTimeoutException(SystemException): pass
class HTTPRequestException(SystemException): pass
class ParseException(SystemException): pass

class UserException(MailSnakeException): pass
class UserUnknownException(UserException): pass
class UserDisabledException(UserException): pass
class UserDoesNotExistException(UserException) :pass
class UserNotApprovedException(UserException) :pass
class InvalidApiKeyException(UserException) :pass
class UserUnderMaintenanceException(UserException) :pass
class InvalidAppKeyException(UserException) :pass
class InvalidIPException(UserException) :pass
class UserDoesExistException(UserException) :pass

class UserActionException(MailSnakeException): pass
class UserInvalidActionException(UserActionException): pass
class UserMissingEmailException(UserActionException): pass
class UserCannotSendCampaignException(UserActionException): pass
class UserMissingModuleOutboxException(UserActionException): pass
class UserModuleAlreadyPurchasedException(UserActionException): pass
class UserModuleNotPurchasedException(UserActionException): pass
class UserNotEnoughCreditException(UserActionException): pass
class MCInvalidPaymentException(UserActionException): pass

class ListException(MailSnakeException): pass
class ListDoesNotExistException(ListException): pass

class ListActionException(MailSnakeException): pass
class ListInvalidInterestFieldTypeException(ListActionException): pass
class ListInvalidOptionException(ListActionException): pass
class ListInvalidUnsubMemberException(ListActionException): pass
class ListInvalidBounceMemberException(ListActionException): pass
class ListAlreadySubscribedException(ListActionException): pass
class ListNotSubscribedException(ListActionException): pass

class ListImportException(MailSnakeException): pass
class ListInvalidImportException(ListImportException): pass
class MCPastedListDuplicateException(ListImportException): pass
class MCPastedListInvalidImportException(ListImportException): pass

class ListEmailException(MailSnakeException): pass
class EmailAlreadySubscribedException(ListEmailException): pass
class EmailAlreadyUnsubscribedException(ListEmailException): pass
class EmailNotExistsException(ListEmailException): pass
class EmailNotSubscribedException(ListEmailException): pass

class ListMergeException(MailSnakeException): pass
class ListMergeFieldRequiredException(ListMergeException): pass
class ListCannotRemoveEmailMergeException(ListMergeException): pass
class ListMergeInvalidMergeIDException(ListMergeException): pass
class ListTooManyMergeFieldsException(ListMergeException): pass
class ListInvalidMergeFieldException(ListMergeException): pass

class ListInterestGroupException(MailSnakeException): pass
class ListInvalidInterestGroupException(ListInterestGroupException): pass
class ListTooManyInterestGroupsException(ListInterestGroupException): pass

class CampaignException(MailSnakeException): pass
class CampaignDoesNotExistException(CampaignException): pass
class CampaignStatsNotAvailableException(CampaignException): pass

class CampaignOptionException(MailSnakeException): pass
class CampaignInvalidAbsplitException(CampaignOptionException): pass
class CampaignInvalidContentException(CampaignOptionException): pass
class CampaignInvalidOptionException(CampaignOptionException): pass
class CampaignInvalidStatusException(CampaignOptionException): pass
class CampaignNotSavedException(CampaignOptionException): pass
class CampaignInvalidSegmentException(CampaignOptionException): pass
class CampaignInvalidRssException(CampaignOptionException): pass
class CampaignInvalidAutoException(CampaignOptionException): pass
class MCContentImportInvalidArchiveException(CampaignOptionException): pass
class CampaignBounceMissingException(CampaignOptionException): pass

class CampaignEcommException(MailSnakeException): pass
class InvalidEcommOrderException(CampaignEcommException): pass

class CampaignAbsplitException(MailSnakeException): pass
class AbsplitUnknownErrorException(CampaignAbsplitException): pass
class AbsplitUnknownSplitTestException(CampaignAbsplitException): pass
class AbsplitUnknownTestTypeException(CampaignAbsplitException): pass
class AbsplitUnknownWaitUnitException(CampaignAbsplitException): pass
class AbsplitUnknownWinnerTypeException(CampaignAbsplitException): pass
class AbsplitWinnerNotSelectedException(CampaignAbsplitException): pass

class GenericValidationException(MailSnakeException): pass
class InvalidAnalyticsException(GenericValidationException): pass
class InvalidDateTimeException(GenericValidationException): pass
class InvalidEmailException(GenericValidationException): pass
class InvalidSendTypeException(GenericValidationException): pass
class InvalidTemplateException(GenericValidationException): pass
class InvalidTrackingOptionsException(GenericValidationException): pass
class InvalidOptionsException(GenericValidationException): pass
class InvalidFolderException(GenericValidationException): pass
class InvalidURLException(GenericValidationException): pass

class GenericUnknownException(MailSnakeException): pass
class ModuleUnknownException(GenericUnknownException): pass
class MonthlyPlanUnknownException(GenericUnknownException): pass
class OrderTypeUnknownException(GenericUnknownException): pass
class InvalidPagingLimitException(GenericUnknownException): pass
class InvalidPagingStartException(GenericUnknownException): pass
class MaxSizeReachedException(GenericUnknownException): pass

_ERROR_MAP = {
    # System Related Errors
    -32601: SystemException,
    -32602: SystemException,
    -99: SystemException,
    -98: SystemException,
    -92: SystemException,
    -91: SystemException,
    -90: SystemException,
    -50: SystemException,
    0: SystemException,

    # 100: User Related Errors
    100: UserUnknownException,
    101: UserDisabledException,
    102: UserDoesNotExistException,
    103: UserNotApprovedException,
    104: InvalidApiKeyException,
    105: UserUnderMaintenanceException,
    106: InvalidAppKeyException,
    107: InvalidIPException,
    108: UserDoesExistException,

    # 120: User - Action Related Errors
    120: UserInvalidActionException,
    121: UserMissingEmailException,
    122: UserCannotSendCampaignException,
    123: UserMissingModuleOutboxException,
    124: UserModuleAlreadyPurchasedException,
    125: UserModuleNotPurchasedException,
    126: UserNotEnoughCreditException,
    127: MCInvalidPaymentException,

    # 200: List Error
    200: ListDoesNotExistException,

    # 210: List - Basic Action Errors
    210: ListInvalidInterestFieldTypeException,
    211: ListInvalidOptionException,
    212: ListInvalidUnsubMemberException,
    213: ListInvalidBounceMemberException,
    214: ListAlreadySubscribedException,
    215: ListNotSubscribedException,

    # 220: List - Import Related  Errors
    220: ListInvalidImportException,
    221: MCPastedListDuplicateException,
    222: MCPastedListInvalidImportException,

    # 230: List - Email Related Errors
    230: EmailAlreadySubscribedException,
    231: EmailAlreadyUnsubscribedException,
    232: EmailNotExistsException,
    233: EmailNotSubscribedException,

    # 250: List - Merge Related Errors
    250: ListMergeFieldRequiredException,
    251: ListCannotRemoveEmailMergeException,
    252: ListMergeInvalidMergeIDException,
    253: ListTooManyMergeFieldsException,
    254: ListInvalidMergeFieldException,

    # 270: List - Interest Group Related Errors
    270: ListInvalidInterestGroupException,
    271: ListTooManyInterestGroupsException,

    # 300: Campaign Related Errors
    300: CampaignDoesNotExistException,
    301: CampaignStatsNotAvailableException,

    # 310: Campaign - Option Related Errors
    310: CampaignInvalidAbsplitException,
    311: CampaignInvalidContentException,
    312: CampaignInvalidOptionException,
    313: CampaignInvalidStatusException,
    314: CampaignNotSavedException,
    315: CampaignInvalidSegmentException,
    316: CampaignInvalidRssException,
    317: CampaignInvalidAutoException,
    318: MCContentImportInvalidArchiveException,
    319: CampaignBounceMissingException,

    # 330: Campaign - Ecomm Errors
    330: InvalidEcommOrderException,

    # 350: Campaign - Absplit Related Errors
    350: AbsplitUnknownErrorException,
    351: AbsplitUnknownSplitTestException,
    352: AbsplitUnknownTestTypeException,
    353: AbsplitUnknownWaitUnitException,
    354: AbsplitUnknownWinnerTypeException,
    355: AbsplitWinnerNotSelectedException,

    # 500: Generic Validation Errors
    500: InvalidAnalyticsException,
    501: InvalidDateTimeException,
    502: InvalidEmailException,
    503: InvalidSendTypeException,
    504: InvalidTemplateException,
    505: InvalidTrackingOptionsException,
    506: InvalidOptionsException,
    507: InvalidFolderException,
    508: InvalidURLException,

    # 550: Generic Unknown Errors
    550: ModuleUnknownException,
    551: MonthlyPlanUnknownException,
    552: OrderTypeUnknownException,
    553: InvalidPagingLimitException,
    554: InvalidPagingStartException,
    555: MaxSizeReachedException,
}


def exception_for_code(code):
    return _ERROR_MAP[code]
