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
        "commandeAjoutee",
        "",
        "idCommande",
        "countChanged",
        "get",
        "QVariantMap",
        "index",
        "ajouterCommande",
        "clientId",
        "date",
        "total",
        "QVariantList",
        "plats",
        "modifierCommande",
        "id",
        "supprimerCommande",
        "detailsModel",
        "DetailsCommande*",
        "count"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'commandeAjoutee'
        QtMocHelpers::SignalData<void(int)>(1, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 3 },
        }}),
        // Signal 'countChanged'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'get'
        QtMocHelpers::MethodData<QVariantMap(int) const>(5, 2, QMC::AccessPublic, 0x80000000 | 6, {{
            { QMetaType::Int, 7 },
        }}),
        // Method 'ajouterCommande'
        QtMocHelpers::MethodData<bool(int, const QString &, double, const QVariantList &)>(8, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 9 }, { QMetaType::QString, 10 }, { QMetaType::Double, 11 }, { 0x80000000 | 12, 13 },
        }}),
        // Method 'modifierCommande'
        QtMocHelpers::MethodData<bool(int, int, const QString &, double)>(14, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 15 }, { QMetaType::Int, 9 }, { QMetaType::QString, 10 }, { QMetaType::Double, 11 },
        }}),
        // Method 'supprimerCommande'
        QtMocHelpers::MethodData<bool(int)>(16, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 15 },
        }}),
        // Method 'detailsModel'
        QtMocHelpers::MethodData<DetailsCommande *() const>(17, 2, QMC::AccessPublic, 0x80000000 | 18),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'count'
        QtMocHelpers::PropertyData<int>(19, QMetaType::Int, QMC::DefaultPropertyFlags, 1),
        // property 'detailsModel'
        QtMocHelpers::PropertyData<DetailsCommande*>(17, 0x80000000 | 18, QMC::DefaultPropertyFlags | QMC::EnumOrFlag | QMC::Constant),
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
        case 0: _t->commandeAjoutee((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 1: _t->countChanged(); break;
        case 2: { QVariantMap _r = _t->get((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->ajouterCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QVariantList>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->modifierCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: { bool _r = _t->supprimerCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 6: { DetailsCommande* _r = _t->detailsModel();
            if (_a[0]) *reinterpret_cast< DetailsCommande**>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (Commande::*)(int )>(_a, &Commande::commandeAjoutee, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (Commande::*)()>(_a, &Commande::countChanged, 1))
            return;
    }
    if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< DetailsCommande* >(); break;
        }
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<int*>(_v) = _t->rowCount(); break;
        case 1: *reinterpret_cast<DetailsCommande**>(_v) = _t->detailsModel(); break;
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
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 7;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void Commande::commandeAjoutee(int _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 0, nullptr, _t1);
}

// SIGNAL 1
void Commande::countChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
