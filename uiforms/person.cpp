#include "person.h"

Person::Person(QObject *parent)
    : QObject{parent}
    , m_customerId(""), m_firstName(""), m_lastName("")
    , m_title(""), m_email(""), m_address(""), m_city("")
    , m_zipCode(""), m_phoneNumber(""), m_notes(""), m_history("") { }

Person::Person(const Person &p): QObject{ p.parent() }
    , m_customerId(p.customerId()), m_firstName(p.firstName()), m_lastName(p.lastName())
    , m_title(p.title()), m_email(p.email()), m_address(p.address()), m_city(p.city())
    , m_zipCode(p.zipCode()), m_phoneNumber(p.phoneNumber()), m_notes(p.notes()), m_history(p.history()) { }

Person::Person(QString customerId, QString firstName, QString lastName, QString title
                , QString email, QString address, QString city, QString zipCode
               , QString phoneNumber, QString notes, QString history, QObject *parent) : QObject { parent }
    , m_customerId(customerId), m_firstName(firstName), m_lastName(lastName)
    , m_title(title), m_email(email), m_address(address), m_city(city)
    , m_zipCode(zipCode), m_phoneNumber(phoneNumber), m_notes(notes), m_history(history) { }

Person& Person::operator=(const Person &p) {
    if (this != &p) {
        this->m_customerId = p.m_customerId;
        this->m_firstName = p.m_firstName;
        this->m_lastName = p.m_lastName;
        this->m_title = p.m_title;
        this->m_email = p.m_email;
        this->m_address = p.m_address;
        this->m_city = p.m_city;
        this->m_zipCode = p.m_zipCode;
        this->m_phoneNumber = p.m_phoneNumber;
        this->m_notes = p.m_notes;
        this->m_history = p.m_history;
    }

    return *this;
}

QString Person::customerId() const
{
    return m_customerId;
}

void Person::setCustomerId(QString value)
{
    if (m_customerId != value) {
        m_customerId = value;
        emit customerIdChanged();
    }
}

QString Person::firstName() const
{
    return m_firstName;
}

void Person::setFirstName(QString value)
{
    if (m_firstName != value) {
        m_firstName = value;
        emit firstNameChanged();
    }
}

QString Person::lastName() const
{
    return m_lastName;
}

void Person::setLastName(QString value)
{
    if (m_lastName != value) {
        m_lastName = value;
        emit lastNameChanged();
    }
}

QString Person::title() const
{
    return m_title;
}

void Person::setTitle(QString value)
{
    if (m_title != value) {
        m_title = value;
        emit titleChanged();
    }
}

QString Person::email() const
{
    return m_email;
}

void Person::setEmail(QString value)
{
    if (m_email != value) {
        m_email = value;
        emit emailChanged();
    }
}

QString Person::address() const
{
    return m_address;
}

void Person::setAddress(QString value)
{
    if (m_address != value) {
        m_address = value;
        emit addressChanged();
    }
}

QString Person::city() const
{
    return m_city;
}

void Person::setCity(QString value)
{
    if (m_city != value) {
        m_city = value;
        emit cityChanged();
    }
}

QString Person::zipCode() const
{
    return m_zipCode;
}

void Person::setZipCode(QString value)
{
    if (m_zipCode != value) {
        m_zipCode = value;
        emit zipCodeChanged();
    }
}

QString Person::phoneNumber() const
{
    return m_phoneNumber;
}

void Person::setPhoneNumber(QString value)
{
    if (m_phoneNumber != value) {
        m_phoneNumber = value;
        emit phoneNumberChanged();
    }
}

QString Person::notes() const
{
    return m_notes;
}

void Person::setNotes(QString value)
{
    if (m_notes != value) {
        m_notes = value;
        emit notesChanged();
    }
}

QString Person::history() const
{
    return m_history;
}

void Person::setHistory(QString value)
{
    if (m_history != value) {
        m_history = value;
        emit historyChanged();
    }
}


