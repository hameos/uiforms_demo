#ifndef MYTABLEMODEL_H
#define MYTABLEMODEL_H

#include <QAbstractTableModel>
#include <QModelIndex>
#include <QHash>
#include <QVariant>
#include <QByteArray>
#include <QList>
#include <QString>
#include <QSqlDatabase>

#include "person.h"


class MyTableModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    enum Roles {
        CellRole = 0
    };

    Q_ENUM(Roles)

    Q_INVOKABLE inline virtual QHash<int,QByteArray> roleNames() const override {
        return {{Roles::CellRole, "value"}};
    }

    explicit MyTableModel(QObject *parent = nullptr);
    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE virtual bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Q_INVOKABLE QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

private:
    QList<Person> mtable;
    QSqlDatabase m_db;
protected:
    enum ColNames {
        CustomerId,
        FirstName,
        LastName,
        Title,
        Email,
        Address,
        City,
        ZipCode,
        PhoneNumber,
        Notes,
        History
    };

    const QHash<int, QByteArray> COLNAMES = {
        { ColNames::CustomerId, "customerId" },
        { ColNames::FirstName, "firstName" },
        { ColNames::LastName, "lastName" },
        { ColNames::Title, "title" },
        { ColNames::Email, "email" },
        { ColNames::Address, "address" },
        { ColNames::City, "city" },
        { ColNames::ZipCode, "zipCode" },
        { ColNames::PhoneNumber, "phoneNumber" },
        { ColNames::Notes, "notes" },
        { ColNames::History, "history" },
    };

    const QHash<int, QByteArray> DB_COLNAMES = {
        { ColNames::CustomerId, "id" },
        { ColNames::FirstName, "first_name" },
        { ColNames::LastName, "last_name" },
        { ColNames::Title, "title" },
        { ColNames::Email, "email" },
        { ColNames::Address, "address" },
        { ColNames::City, "city" },
        { ColNames::ZipCode, "zip_code" },
        { ColNames::PhoneNumber, "phone_number" },
        { ColNames::Notes, "notes" },
        { ColNames::History, "history" },
    };
};

#endif // MYTABLEMODEL_H
