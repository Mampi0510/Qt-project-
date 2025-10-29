/****************************************************************************
** Meta object code from reading C++ file 'Plat.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../headers/Plat.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Plat.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN4PlatE_t {};
} // unnamed namespace

template <> constexpr inline auto Plat::qt_create_metaobjectdata<qt_meta_tag_ZN4PlatE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "Plat",
        "get",
        "QVariantMap",
        "",
        "index",
        "chargerPlats",
        "ajouterPlat",
        "nom",
        "prix",
        "categorie",
        "modifierPlat",
        "id",
        "supprimerPlat",
        "PlatRoles",
        "IdRole",
        "NomRole",
        "PrixRole",
        "CategorieRole"
    };

    QtMocHelpers::UintData qt_methods {
        // Method 'get'
        QtMocHelpers::MethodData<QVariantMap(int) const>(1, 3, QMC::AccessPublic, 0x80000000 | 2, {{
            { QMetaType::Int, 4 },
        }}),
        // Method 'chargerPlats'
        QtMocHelpers::MethodData<void()>(5, 3, QMC::AccessPublic, QMetaType::Void),
        // Method 'ajouterPlat'
        QtMocHelpers::MethodData<bool(const QString &, double, const QString &)>(6, 3, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 7 }, { QMetaType::Double, 8 }, { QMetaType::QString, 9 },
        }}),
        // Method 'modifierPlat'
        QtMocHelpers::MethodData<bool(int, const QString &, double, const QString &)>(10, 3, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 11 }, { QMetaType::QString, 7 }, { QMetaType::Double, 8 }, { QMetaType::QString, 9 },
        }}),
        // Method 'supprimerPlat'
        QtMocHelpers::MethodData<bool(int)>(12, 3, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::Int, 11 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
    };
    QtMocHelpers::UintData qt_enums {
        // enum 'PlatRoles'
        QtMocHelpers::EnumData<enum PlatRoles>(13, 13, QMC::EnumFlags{}).add({
            {   14, PlatRoles::IdRole },
            {   15, PlatRoles::NomRole },
            {   16, PlatRoles::PrixRole },
            {   17, PlatRoles::CategorieRole },
        }),
    };
    return QtMocHelpers::metaObjectData<Plat, qt_meta_tag_ZN4PlatE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject Plat::staticMetaObject = { {
    QMetaObject::SuperData::link<QAbstractListModel::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN4PlatE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN4PlatE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN4PlatE_t>.metaTypes,
    nullptr
} };

void Plat::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<Plat *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: { QVariantMap _r = _t->get((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 1: _t->chargerPlats(); break;
        case 2: { bool _r = _t->ajouterPlat((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->modifierPlat((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->supprimerPlat((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

const QMetaObject *Plat::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Plat::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN4PlatE_t>.strings))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int Plat::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
