sealed class EmailOptionsResult {}

class SendEmailSuccess implements EmailOptionsResult {}

class SendEmailNetworkError implements EmailOptionsResult {}

class SendEmailConflictError implements EmailOptionsResult {}

class SendEmailError implements EmailOptionsResult {}
