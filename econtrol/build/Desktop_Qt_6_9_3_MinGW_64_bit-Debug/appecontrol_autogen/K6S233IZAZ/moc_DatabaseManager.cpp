/****************************************************************************
** Meta object code from reading C++ file 'DatabaseManager.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../headers/DatabaseManager.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'DatabaseManager.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN15DatabaseManagerE_t {};
} // unnamed namespace

template <> constexpr inline auto DatabaseManager::qt_create_metaobjectdata<qt_meta_tag_ZN15DatabaseManagerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "DatabaseManager",
        "clientsChanged",
        "",
        "platsChanged",
        "commandesChanged",
        "getClients",
        "QVariantList",
        "addClient",
        "nom",
        "prenom",
        "telephone",
        "updateClient",
        "id",
        "deleteClient",
        "getCommandes",
        "addCommande",
        "QVariant",
        "date_commande",
        "total",
        "id_client",
        "updateCommande",
        "deleteCommande",
        "getPlats",
        "addPlat",
        "nom_plat",
        "prix",
        "categorie",
        "updatePlat",
        "deletePlat"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'clientsChanged'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'platsChanged'
        QtMocHelpers::SignalData<void()>(3, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'commandesChanged'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'getClients'
        QtMocHelpers::MethodData<QVariantList()>(5, 2, QMC::AccessPublic, 0x80000000 | 6),
        // Method 'addClient'
        QtMocHelpers::MethodData<bool(const QString &, const QString &, const QString &)>(7, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 8 }, { QMetaType::QString, 9 }, { QMetaType::QString, 10 },
        }}),
        // Method 'updateClient'
        QtMocHelpers::MethodData<bool(int, const QString &, const QString &, const QString &)>(11, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 12 }, { QMetaType::QString, 8 }, { QMetaType::QString, 9 }, { QMetaType::QString, 10 },
        }}),
        // Method 'deleteClient'
        QtMocHelpers::MethodData<bool(int)>(13, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 12 },
        }}),
        // Method 'getCommandes'
        QtMocHelpers::MethodData<QVariantList()>(14, 2, QMC::AccessPublic, 0x80000000 | 6),
        // Method 'addCommande'
        QtMocHelpers::MethodData<bool(const QVariant &, const double, int)>(15, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { 0x80000000 | 16, 17 }, { QMetaType::Double, 18 }, { QMetaType::Int, 19 },
        }}),
        // Method 'updateCommande'
        QtMocHelpers::MethodData<bool(int, const QDateTime &, const double, int)>(20, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 12 }, { QMetaType::QDateTime, 17 }, { QMetaType::Double, 18 }, { QMetaType::Int, 19 },
        }}),
        // Method 'deleteCommande'
        QtMocHelpers::MethodData<bool(int)>(21, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 12 },
        }}),
        // Method 'getPlats'
        QtMocHelpers::MethodData<QVariantList()>(22, 2, QMC::AccessPublic, 0x80000000 | 6),
        // Method 'addPlat'
        QtMocHelpers::MethodData<bool(const QString &, const float, const QString &)>(23, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 24 }, { QMetaType::Float, 25 }, { QMetaType::QString, 26 },
        }}),
        // Method 'updatePlat'
        QtMocHelpers::MethodData<bool(int, const QString &, const float, const QString &)>(27, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 12 }, { QMetaType::QString, 24 }, { QMetaType::Float, 25 }, { QMetaType::QString, 26 },
        }}),
        // Method 'deletePlat'
        QtMocHelpers::MethodData<bool(int)>(28, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 12 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<DatabaseManager, qt_meta_tag_ZN15DatabaseManagerE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject DatabaseManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN15DatabaseManagerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN15DatabaseManagerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN15DatabaseManagerE_t>.metaTypes,
    nullptr
} };

void DatabaseManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<DatabaseManager *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->clientsChanged(); break;
        case 1: _t->platsChanged(); break;
        case 2: _t->commandesChanged(); break;
        case 3: { QVariantList _r = _t->getClients();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->addClient((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: { bool _r = _t->updateClient((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 6: { bool _r = _t->deleteClient((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 7: { QVariantList _r = _t->getCommandes();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 8: { bool _r = _t->addCommande((*reinterpret_cast< std::add_pointer_t<QVariant>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 9: { bool _r = _t->updateCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QDateTime>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 10: { bool _r = _t->deleteCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 11: { QVariantList _r = _t->getPlats();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 12: { bool _r = _t->addPlat((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<float>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 13: { bool _r = _t->updatePlat((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<float>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 14: { bool _r = _t->deletePlat((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (DatabaseManager::*)()>(_a, &DatabaseManager::clientsChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (DatabaseManager::*)()>(_a, &DatabaseManager::platsChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (DatabaseManager::*)()>(_a, &DatabaseManager::commandesChanged, 2))
            return;
    }
}

const QMetaObject *DatabaseManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *DatabaseManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN15DatabaseManagerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int DatabaseManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 15)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 15;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 15)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 15;
    }
    return _id;
}

// SIGNAL 0
void DatabaseManager::clientsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void DatabaseManager::platsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void DatabaseManager::commandesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
