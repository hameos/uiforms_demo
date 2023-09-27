#ifndef PERSON_H
#define PERSON_H

#include <QObject>

class Person : public QObject
{   // customerId, firstName, lastName, title, email, address, city, zipCode, phoneNumber, notes, history
    Q_OBJECT
    Q_PROPERTY(QString customerId READ customerId WRITE setCustomerId NOTIFY customerIdChanged FINAL)
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged FINAL)
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged FINAL)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged FINAL)
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged FINAL)
    Q_PROPERTY(QString address READ address WRITE setAddress NOTIFY addressChanged FINAL)
    Q_PROPERTY(QString city READ city WRITE setCity NOTIFY cityChanged FINAL)
    Q_PROPERTY(QString zipCode READ zipCode WRITE setZipCode NOTIFY zipCodeChanged FINAL)
    Q_PROPERTY(QString phoneNumber READ phoneNumber WRITE setPhoneNumber NOTIFY phoneNumberChanged FINAL)
    Q_PROPERTY(QString notes READ notes WRITE setNotes NOTIFY notesChanged FINAL)
    Q_PROPERTY(QString history READ history WRITE setHistory NOTIFY historyChanged FINAL)

public:
    explicit Person(QObject *parent = nullptr);
    Person(const Person &p);
    Person(QString customerId, QString firstName, QString lastName, QString title
           , QString email, QString address, QString city, QString zipCode
           , QString phoneNumber, QString notes, QString history, QObject *parent = nullptr);

    Person& operator=(const Person &p);

    QString customerId() const;
    void setCustomerId(QString);

    QString firstName() const;
    void setFirstName(QString);

    QString lastName() const;
    void setLastName(QString);

    QString title() const;
    void setTitle(QString);

    QString email() const;
    void setEmail(QString);

    QString address() const;
    void setAddress(QString);

    QString city() const;
    void setCity(QString);

    QString zipCode() const;
    void setZipCode(QString);

    QString phoneNumber() const;
    void setPhoneNumber(QString);

    QString notes() const;
    void setNotes(QString);

    QString history() const;
    void setHistory(QString);

    virtual ~Person(){};

signals:
    void customerIdChanged();
    void firstNameChanged();
    void lastNameChanged();
    void titleChanged();
    void emailChanged();
    void addressChanged();
    void cityChanged();
    void zipCodeChanged();
    void phoneNumberChanged();
    void notesChanged();
    void historyChanged();

private:
    QString m_customerId;
    QString m_firstName;
    QString m_lastName;
    QString m_title;
    QString m_email;
    QString m_address;
    QString m_city;
    QString m_zipCode;
    QString m_phoneNumber;
    QString m_notes;
    QString m_history;
};

#endif // PERSON_H
