// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef STATUSQUO_QT_STATUSQUOADDRESSVALIDATOR_H
#define STATUSQUO_QT_STATUSQUOADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class StatusquoAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit StatusquoAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Statusquo address widget validator, checks for a valid statusquo address.
 */
class StatusquoAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit StatusquoAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // STATUSQUO_QT_STATUSQUOADDRESSVALIDATOR_H
