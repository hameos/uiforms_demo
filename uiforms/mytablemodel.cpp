#include "mytablemodel.h"
#include "person.h"
#include <QDebug>

#include <QSqlDatabase>
#include <QSqlQuery>

// Model:
// id, first_name, last_name, title, email, address, city, zip_code, phone_number, notes, history

MyTableModel::MyTableModel(QObject *parent)
    : QAbstractTableModel{parent}
{

    m_db = QSqlDatabase::addDatabase("QMYSQL");
    m_db.setHostName("127.0.0.1");
    m_db.setDatabaseName("hameos");
    m_db.setUserName("myuser");
    m_db.setPassword("mypass");
    bool ok = m_db.open();
    qDebug() << "Result db connection: " << ok ;

    if (ok) {
        QSqlQuery query;
        query.exec("SELECT * FROM customer");

        while (query.next()) {
            QString id = query.value(ColNames::CustomerId).toString();
            QString firstName = query.value(ColNames::FirstName).toString();
            QString lastName = query.value(ColNames::LastName).toString();
            QString title = query.value(ColNames::Title).toString();
            QString email = query.value(ColNames::Email).toString();
            QString address = query.value(ColNames::Address).toString();
            QString city = query.value(ColNames::City).toString();
            QString zipCode = query.value(ColNames::ZipCode).toString();
            QString phoneNumber = query.value(ColNames::PhoneNumber).toString();
            QString notes = query.value(ColNames::Notes).toString();
            QString history = query.value(ColNames::History).toString();

            mtable.append(Person{id,firstName,lastName,title,email,address,city,zipCode,phoneNumber,notes,history});
        }

        m_db.close();
    }
}

QVariant MyTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    QVariant variant;
    if (orientation == Qt::Horizontal) {
        variant = COLNAMES[section];
    } else {
        variant = section;
    }

    return variant;
}

int MyTableModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return mtable.size();
}

int MyTableModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return COLNAMES.size();
}

QVariant MyTableModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != CellRole)
        return QVariant();

    QVariant variant;
    const int row = index.row();
    const int col = index.column();
    switch(col) {
    case ColNames::CustomerId:
        variant = mtable.at(row).customerId();
        break;
    case ColNames::FirstName:
        variant = mtable.at(row).firstName();
        break;
    case ColNames::LastName:
        variant = mtable.at(row).lastName();
        break;
    case ColNames::Title:
        variant = mtable.at(row).title();
        break;
    case ColNames::Email:
        variant = mtable.at(row).email();
        break;
    case ColNames::Address:
        variant = mtable.at(row).address();
        break;
    case ColNames::City:
        variant = mtable.at(row).city();
        break;
    case ColNames::ZipCode:
        variant = mtable.at(row).zipCode();
        break;
    case ColNames::PhoneNumber:
        variant = mtable.at(row).phoneNumber();
        break;
    case ColNames::Notes:
        variant = mtable.at(row).notes();
        break;
    case ColNames::History:
        variant = mtable.at(row).history();
        break;
    }

    return variant;
}

bool  MyTableModel::setData(const QModelIndex &index, const QVariant &value, int role) {

    if (!index.isValid())
        return false;

    const int row = index.row();
    const int col = index.column();
    switch(col) {
    case ColNames::CustomerId:
        mtable[row].setCustomerId(value.toString());
        break;
    case ColNames::FirstName:
        mtable[row].setFirstName(value.toString());
        break;
    case ColNames::LastName:
        mtable[row].setLastName(value.toString());
        break;
    case ColNames::Title:
        mtable[row].setTitle(value.toString());
        break;
    case ColNames::Email:
        mtable[row].setEmail(value.toString());
        break;
    case ColNames::Address:
        mtable[row].setAddress(value.toString());
        break;
    case ColNames::City:
        mtable[row].setCity(value.toString());
        break;
    case ColNames::ZipCode:
        mtable[row].setZipCode(value.toString());
        break;
    case ColNames::PhoneNumber:
        mtable[row].setPhoneNumber(value.toString());
        break;
    case ColNames::Notes:
        mtable[row].setNotes(value.toString());
        break;
    case ColNames::History:
        mtable[row].setHistory(value.toString());
        break;
    }

    if (col == ColNames::PhoneNumber || col == ColNames::Notes) {
        bool ok = m_db.open();
        if (ok) {

            if (col == ColNames::PhoneNumber) { // first_name,last_name,title,email,address,city,zip_code,phone_number
                QSqlQuery query;
                query.exec("UPDATE customer SET " + DB_COLNAMES[ColNames::FirstName] + " = '" + mtable[row].firstName() +
                           "', " + DB_COLNAMES[ColNames::LastName] + " = '" + mtable[row].lastName() +
                           "', " + DB_COLNAMES[ColNames::Title] + " = '" + mtable[row].title() +
                           "', " + DB_COLNAMES[ColNames::Email] + " = '" + mtable[row].email() +
                           "', " + DB_COLNAMES[ColNames::Address] + " = '" + mtable[row].address() +
                           "', " + DB_COLNAMES[ColNames::City] + " = '" + mtable[row].city() +
                           "', " + DB_COLNAMES[ColNames::ZipCode] + " = '" + mtable[row].zipCode() +
                           "', " + DB_COLNAMES[ColNames::PhoneNumber] + " = '" + mtable[row].phoneNumber() +
                           "' WHERE " + DB_COLNAMES[ColNames::CustomerId] + " = '" + mtable[row].customerId() +
                           "';") ;
            }
            else {  // notes
                QSqlQuery query;
                query.exec("UPDATE customer SET " + DB_COLNAMES[ColNames::Notes] + " = '" + mtable[row].notes() +
                           "' WHERE " + DB_COLNAMES[ColNames::CustomerId] + " = '" + mtable[row].customerId() +
                           "';") ;
            }

            m_db.close();

            emit dataChanged(index,index, {role});
        }
    }

    return true;
}
