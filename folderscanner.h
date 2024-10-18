#ifndef FOLDERSCANNER_H
#define FOLDERSCANNER_H

#include <QObject>
#include <QStringList>
#include <QJsonObject>

class FolderScanner : public QObject
{
    Q_OBJECT

public:
    explicit FolderScanner(QObject *parent = nullptr);
    Q_INVOKABLE QVariantMap scanFolder(const QString &path);

public slots:
    QString getFolderForExtension(const QString &extension);
    Q_INVOKABLE QStringList getUniqueFolders();

private:
    QJsonObject extensionMap;
    void loadExtensionMap();
};

#endif // FOLDERSCANNER_H
