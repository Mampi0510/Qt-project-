/****************************************************************************
** Meta object code from reading C++ file 'DetailsCommandes.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.2)
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
#error "This file was generated using the moc from 6.9.2. It"
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
struct qt_meta_tag_ZN16DetailsCommandesE_t {};
} // unnamed namespace

template <> constexpr inline auto DetailsCommandes::qt_create_metaobjectdata<qt_meta_tag_ZN16DetailsCommandesE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "DetailsCommandes",
        "commandeIdChanged",
        "",
        "platIdChanged",
        "quantiteChanged",
        "prixUnitaireChanged",
        "afficherDetails",
        "commandeId",
        "PlatId",
        "quantite",
        "prixUnitaire"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'commandeIdChanged'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'platIdChanged'
        QtMocHelpers::SignalData<void()>(3, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'quantiteChanged'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'prixUnitaireChanged'
        QtMocHelpers::SignalData<void()>(5, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'afficherDetails'
        QtMocHelpers::MethodData<void()>(6, 2, QMC::AccessPublic, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'commandeId'
        QtMocHelpers::PropertyData<int>(7, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 0),
        // property 'PlatId'
        QtMocHelpers::PropertyData<int>(8, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 1),
        // property 'quantite'
        QtMocHelpers::PropertyData<int>(9, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 2),
        // property 'prixUnitaire'
        QtMocHelpers::PropertyData<double>(10, QMetaType::Double, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 3),
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<DetailsCommandes, qt_meta_tag_ZN16DetailsCommandesE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject DetailsCommandes::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN16DetailsCommandesE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN16DetailsCommandesE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN16DetailsCommandesE_t>.metaTypes,
    nullptr
} };

void DetailsCommandes::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<DetailsCommandes *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->commandeIdChanged(); break;
        case 1: _t->platIdChanged(); break;
        case 2: _t->quantiteChanged(); break;
        case 3: _t->prixUnitaireChanged(); break;
        case 4: _t->afficherDetails(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (DetailsCommandes::*)()>(_a, &DetailsCommandes::commandeIdChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (DetailsCommandes::*)()>(_a, &DetailsCommandes::platIdChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (DetailsCommandes::*)()>(_a, &DetailsCommandes::quantiteChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (DetailsCommandes::*)()>(_a, &DetailsCommandes::prixUnitaireChanged, 3))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<int*>(_v) = _t->getCommandeId(); break;
        case 1: *reinterpret_cast<int*>(_v) = _t->getPlatId(); break;
        case 2: *reinterpret_cast<int*>(_v) = _t->getQuantite(); break;
        case 3: *reinterpret_cast<double*>(_v) = _t->getPrixUnitaire(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setCommandeId(*reinterpret_cast<int*>(_v)); break;
        case 1: _t->setPlatId(*reinterpret_cast<int*>(_v)); break;
        case 2: _t->setQuantite(*reinterpret_cast<int*>(_v)); break;
        case 3: _t->setPrixUnitaire(*reinterpret_cast<double*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *DetailsCommandes::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *DetailsCommandes::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN16DetailsCommandesE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int DetailsCommandes::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
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
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void DetailsCommandes::commandeIdChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void DetailsCommandes::platIdChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void DetailsCommandes::quantiteChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void DetailsCommandes::prixUnitaireChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
QT_WARNING_POP
