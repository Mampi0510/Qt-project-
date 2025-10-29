/****************************************************************************
** Meta object code from reading C++ file 'DetailsCommandes.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../headers/DetailsCommandes.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'DetailsCommandes.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN15DetailsCommandeE_t {};
} // unnamed namespace

template <> constexpr inline auto DetailsCommande::qt_create_metaobjectdata<qt_meta_tag_ZN15DetailsCommandeE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "DetailsCommande",
        "ajouterDetail",
        "",
        "idCommande",
        "idPlat",
        "quantite",
        "prixUnitaire",
        "supprimerDetail",
        "supprimerDetailParCommande",
        "get",
        "QVariantMap",
        "index",
        "getDetailsByCommande",
        "QVariantList"
    };

    QtMocHelpers::UintData qt_methods {
        // Method 'ajouterDetail'
        QtMocHelpers::MethodData<bool(int, int, int, double)>(1, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 3 }, { QMetaType::Int, 4 }, { QMetaType::Int, 5 }, { QMetaType::Double, 6 },
        }}),
        // Method 'supprimerDetail'
        QtMocHelpers::MethodData<bool(int, int)>(7, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 3 }, { QMetaType::Int, 4 },
        }}),
        // Method 'supprimerDetailParCommande'
        QtMocHelpers::MethodData<bool(int)>(8, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 3 },
        }}),
        // Method 'get'
        QtMocHelpers::MethodData<QVariantMap(int) const>(9, 2, QMC::AccessPublic, 0x80000000 | 10, {{
            { QMetaType::Int, 11 },
        }}),
        // Method 'getDetailsByCommande'
        QtMocHelpers::MethodData<QVariantList(int)>(12, 2, QMC::AccessPublic, 0x80000000 | 13, {{
            { QMetaType::Int, 3 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<DetailsCommande, qt_meta_tag_ZN15DetailsCommandeE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject DetailsCommande::staticMetaObject = { {
    QMetaObject::SuperData::link<QAbstractListModel::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN15DetailsCommandeE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN15DetailsCommandeE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN15DetailsCommandeE_t>.metaTypes,
    nullptr
} };

void DetailsCommande::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<DetailsCommande *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: { bool _r = _t->ajouterDetail((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 1: { bool _r = _t->supprimerDetail((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->supprimerDetailParCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { QVariantMap _r = _t->get((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 4: { QVariantList _r = _t->getDetailsByCommande((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

const QMetaObject *DetailsCommande::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *DetailsCommande::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN15DetailsCommandeE_t>.strings))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int DetailsCommande::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
