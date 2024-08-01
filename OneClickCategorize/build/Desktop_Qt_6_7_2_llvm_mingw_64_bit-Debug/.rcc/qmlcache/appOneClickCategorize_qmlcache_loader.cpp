#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>
#include <QtCore/qhash.h>
#include <QtCore/qstring.h>

namespace QmlCacheGeneratedCode {
namespace _qt_qml_OneClickCategorize_Main_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_OneClickCategorize_texts_HeadingText_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_OneClickCategorize_texts_SubheadingText_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_OneClickCategorize_components_InputArea_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_OneClickCategorize_texts_InputText_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_OneClickCategorize_components_Button_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_OneClickCategorize_texts_ButtonText_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/OneClickCategorize/Main.qml"), &QmlCacheGeneratedCode::_qt_qml_OneClickCategorize_Main_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/OneClickCategorize/texts/HeadingText.qml"), &QmlCacheGeneratedCode::_qt_qml_OneClickCategorize_texts_HeadingText_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/OneClickCategorize/texts/SubheadingText.qml"), &QmlCacheGeneratedCode::_qt_qml_OneClickCategorize_texts_SubheadingText_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/OneClickCategorize/components/InputArea.qml"), &QmlCacheGeneratedCode::_qt_qml_OneClickCategorize_components_InputArea_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/OneClickCategorize/texts/InputText.qml"), &QmlCacheGeneratedCode::_qt_qml_OneClickCategorize_texts_InputText_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/OneClickCategorize/components/Button.qml"), &QmlCacheGeneratedCode::_qt_qml_OneClickCategorize_components_Button_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/OneClickCategorize/texts/ButtonText.qml"), &QmlCacheGeneratedCode::_qt_qml_OneClickCategorize_texts_ButtonText_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.structVersion = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qmlcache_appOneClickCategorize)() {
    ::unitRegistry();
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qmlcache_appOneClickCategorize))
int QT_MANGLE_NAMESPACE(qCleanupResources_qmlcache_appOneClickCategorize)() {
    return 1;
}
