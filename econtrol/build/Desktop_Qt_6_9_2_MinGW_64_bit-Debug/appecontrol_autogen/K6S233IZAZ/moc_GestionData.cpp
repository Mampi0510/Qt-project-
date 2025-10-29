/****************************************************************************
** Meta object code from reading C++ file 'GestionData.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../headers/GestionData.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'GestionData.h' doesn't include <QObject>."
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
        "stockChanged",
        "detailsStockChanged",
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
        "deletePlat",
        "getStock",
        "addStock",
        "nom_produit",
        "quantite",
        "updateStock",
        "deleteStock",
        "getDetailsStock",
        "addDetailsStock",
        "id_plat",
        "id_produit",
        "quantite_prise",
        "deleteDetailsStock"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'clientsChanged'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'platsChanged'
        QtMocHelpers::SignalData<void()>(3, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'commandesChanged'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'stockChanged'
        QtMocHelpers::SignalData<void()>(5, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'detailsStockChanged'
        QtMocHelpers::SignalData<void()>(6, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'getClients'
        QtMocHelpers::MethodData<QVariantList()>(7, 2, QMC::AccessPublic, 0x80000000 | 8),
        // Method 'addClient'
        QtMocHelpers::MethodData<bool(const QString &, const QString &, const QString &)>(9, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 10 }, { QMetaType::QString, 11 }, { QMetaType::QString, 12 },
        }}),
        // Method 'updateClient'
        QtMocHelpers::MethodData<bool(int, const QString &, const QString &, const QString &)>(13, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 14 }, { QMetaType::QString, 10 }, { QMetaType::QString, 11 }, { QMetaType::QString, 12 },
        }}),
        // Method 'deleteClient'
        QtMocHelpers::MethodData<bool(int)>(15, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'getCommandes'
        QtMocHelpers::MethodData<QVariantList()>(16, 2, QMC::AccessPublic, 0x80000000 | 8),
        // Method 'addCommande'
        QtMocHelpers::MethodData<bool(const QVariant &, const double, int)>(17, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { 0x80000000 | 18, 19 }, { QMetaType::Double, 20 }, { QMetaType::Int, 21 },
        }}),
        // Method 'updateCommande'
        QtMocHelpers::MethodData<bool(int, const QDateTime &, const double, int)>(22, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 14 }, { QMetaType::QDateTime, 19 }, { QMetaType::Double, 20 }, { QMetaType::Int, 21 },
        }}),
        // Method 'deleteCommande'
        QtMocHelpers::MethodData<bool(int)>(23, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'getPlats'
        QtMocHelpers::MethodData<QVariantList()>(24, 2, QMC::AccessPublic, 0x80000000 | 8),
        // Method 'addPlat'
        QtMocHelpers::MethodData<bool(const QString &, const float, const QString &)>(25, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 26 }, { QMetaType::Float, 27 }, { QMetaType::QString, 28 },
        }}),
        // Method 'updatePlat'
        QtMocHelpers::MethodData<bool(int, const QString &, const float, const QString &)>(29, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 14 }, { QMetaType::QString, 26 }, { QMetaType::Float, 27 }, { QMetaType::QString, 28 },
        }}),
        // Method 'deletePlat'
        QtMocHelpers::MethodData<bool(int)>(30, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'getStock'
        QtMocHelpers::MethodData<QVariantList()>(31, 2, QMC::AccessPublic, 0x80000000 | 8),
        // Method 'addStock'
        QtMocHelpers::MethodData<bool(const QString &, double)>(32, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 33 }, { QMetaType::Double, 34 },
        }}),
        // Method 'updateStock'
        QtMocHelpers::MethodData<bool(int, const QString &, double)>(35, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 14 }, { QMetaType::QString, 33 }, { QMetaType::Double, 34 },
        }}),
        // Method 'deleteStock'
        QtMocHelpers::MethodData<bool(int)>(36, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'getDetailsStock'
        QtMocHelpers::MethodData<QVariantList()>(37, 2, QMC::AccessPublic, 0x80000000 | 8),
        // Method 'addDetailsStock'
        QtMocHelpers::MethodData<bool(int, int, double)>(38, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 39 }, { QMetaType::Int, 40 }, { QMetaType::Double, 41 },
        }}),
        // Method 'deleteDetailsStock'
        QtMocHelpers::MethodData<bool(int, int)>(42, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 39 }, { QMetaType::Int, 40 },
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
        case 3: _t->stockChanged(); break;
        case 4: _t->detailsStockChanged(); break;
        case 5: { QVariantList _r = _t->getClients();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 6: { bool _r = _t->addClient((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 7: { bool _r = _t->updateClient((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 8: { bool _r = _t->deleteClient((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 9: { QVariantList _r = _t->getCommandes();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 10: { bool _r = _t->addCommande((*reinterpret_cast< std::add_pointer_t<QVariant>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 11: { bool _r = _t->updateCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QDateTime>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 12: { bool _r = _t->deleteCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 13: { QVariantList _r = _t->getPlats();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 14: { bool _r = _t->addPlat((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<float>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 15: { bool _r = _t->updatePlat((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<float>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 16: { bool _r = _t->deletePlat((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 17: { QVariantList _r = _t->getStock();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 18: { bool _r = _t->addStock((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 19: { bool _r = _t->updateStock((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 20: { bool _r = _t->deleteStock((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 21: { QVariantList _r = _t->getDetailsStock();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 22: { bool _r = _t->addDetailsStock((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 23: { bool _r = _t->deleteDetailsStock((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])));
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
        if (QtMocHelpers::indexOfMethod<void (DatabaseManager::*)()>(_a, &DatabaseManager::stockChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (DatabaseManager::*)()>(_a, &DatabaseManager::detailsStockChanged, 4))
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
        if (_id < 24)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 24;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 24)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 24;
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

// SIGNAL 3
void DatabaseManager::stockChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void DatabaseManager::detailsStockChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}
QT_WARNING_POP
