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

public slots:
    void scanFolder(const QString &path);
    QString getFolderForExtension(const QString &extension);
    Q_INVOKABLE QStringList getUniqueFolders();

signals:
    void scanCompleted(const QStringList &extensions, const QStringList &folders);
    void folderForExtensionFound(const QString &extension, const QString &folder);

private:
    QJsonObject extensionMap;
    void loadExtensionMap();
};

#endif // FOLDERSCANNER_H