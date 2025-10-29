/****************************************************************************
** Meta object code from reading C++ file 'client.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../headers/client.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'client.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 69
#error "This file was generated using the moc from 6.9.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN6ClientE_t {};
} // unnamed namespace

template <> constexpr inline auto Client::qt_create_metaobjectdata<qt_meta_tag_ZN6ClientE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "Client",
        "get",
        "QVariantMap",
        "",
        "index",
        "chargerClients",
        "ajouterClient",
        "nom",
        "prenom",
        "telephone",
        "modifierClient",
        "id",
        "supprimerClient",
        "ClientRoles",
        "IdRole",
        "NomRole",
        "PrenomRole",
        "TelephoneRole"
    };

    QtMocHelpers::UintData qt_methods {
        // Method 'get'
        QtMocHelpers::MethodData<QVariantMap(int) const>(1, 3, QMC::AccessPublic, 0x80000000 | 2, {{
            { QMetaType::Int, 4 },
        }}),
        // Method 'chargerClients'
        QtMocHelpers::MethodData<void()>(5, 3, QMC::AccessPublic, QMetaType::Void),
        // Method 'ajouterClient'
        QtMocHelpers::MethodData<bool(const QString &, const QString &, const QString &)>(6, 3, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 7 }, { QMetaType::QString, 8 }, { QMetaType::QString, 9 },
        }}),
        // Method 'modifierClient'
        QtMocHelpers::MethodData<bool(int, const QString &, const QString &, const QString &)>(10, 3, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 11 }, { QMetaType::QString, 7 }, { QMetaType::QString, 8 }, { QMetaType::QString, 9 },
        }}),
        // Method 'supprimerClient'
        QtMocHelpers::MethodData<bool(int)>(12, 3, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 11 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
    };
    QtMocHelpers::UintData qt_enums {
        // enum 'ClientRoles'
        QtMocHelpers::EnumData<enum ClientRoles>(13, 13, QMC::EnumFlags{}).add({
            {   14, ClientRoles::IdRole },
            {   15, ClientRoles::NomRole },
            {   16, ClientRoles::PrenomRole },
            {   17, ClientRoles::TelephoneRole },
        }),
    };
    return QtMocHelpers::metaObjectData<Client, qt_meta_tag_ZN6ClientE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject Client::staticMetaObject = { {
    QMetaObject::SuperData::link<QAbstractListModel::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN6ClientE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN6ClientE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN6ClientE_t>.metaTypes,
    nullptr
} };

void Client::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<Client *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: { QVariantMap _r = _t->get((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 1: _t->chargerClients(); break;
        case 2: { bool _r = _t->ajouterClient((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->modifierClient((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->supprimerClient((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

const QMetaObject *Client::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Client::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN6ClientE_t>.strings))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int Client::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 5;
    }
    return _id;
}
QT_WARNING_POP
