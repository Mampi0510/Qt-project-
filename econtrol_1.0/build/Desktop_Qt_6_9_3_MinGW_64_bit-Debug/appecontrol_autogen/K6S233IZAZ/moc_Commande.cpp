/****************************************************************************
** Meta object code from reading C++ file 'Commande.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../headers/Commande.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Commande.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN8CommandeE_t {};
} // unnamed namespace

template <> constexpr inline auto Commande::qt_create_metaobjectdata<qt_meta_tag_ZN8CommandeE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "Commande",
        "countChanged",
        "",
        "get",
        "QVariantMap",
        "index",
        "ajouterCommande",
        "clientId",
        "date",
        "total",
        "modifierCommande",
        "id",
        "supprimerCommande",
        "count"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'countChanged'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'get'
        QtMocHelpers::MethodData<QVariantMap(int) const>(3, 2, QMC::AccessPublic, 0x80000000 | 4, {{
            { QMetaType::Int, 5 },
        }}),
        // Method 'ajouterCommande'
        QtMocHelpers::MethodData<bool(int, const QString &, double)>(6, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 7 }, { QMetaType::QString, 8 }, { QMetaType::Double, 9 },
        }}),
        // Method 'modifierCommande'
        QtMocHelpers::MethodData<bool(int, int, const QString &, double)>(10, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 11 }, { QMetaType::Int, 7 }, { QMetaType::QString, 8 }, { QMetaType::Double, 9 },
        }}),
        // Method 'supprimerCommande'
        QtMocHelpers::MethodData<bool(int)>(12, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 11 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'count'
        QtMocHelpers::PropertyData<int>(13, QMetaType::Int, QMC::DefaultPropertyFlags, 0),
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<Commande, qt_meta_tag_ZN8CommandeE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject Commande::staticMetaObject = { {
    QMetaObject::SuperData::link<QAbstractListModel::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN8CommandeE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN8CommandeE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN8CommandeE_t>.metaTypes,
    nullptr
} };

void Commande::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<Commande *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->countChanged(); break;
        case 1: { QVariantMap _r = _t->get((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->ajouterCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->modifierCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->supprimerCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (Commande::*)()>(_a, &Commande::countChanged, 0))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<int*>(_v) = _t->rowCount(); break;
        default: break;
        }
    }
}

const QMetaObject *Commande::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Commande::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN8CommandeE_t>.strings))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int Commande::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    return _id;
}

// SIGNAL 0
void Commande::countChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
