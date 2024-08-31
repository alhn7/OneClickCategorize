#include "folderscanner.h"
#include <QDir>
#include <QFileInfo>
#include <QSet>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

FolderScanner::FolderScanner(QObject *parent) : QObject(parent) {}

void FolderScanner::scanFolder(const QString &path)
{
    QDir dir(path);
    QStringList extensions;
    QSet<QString> uniqueExtensions;
    QSet<QString> uniqueFolders;

    if (dir.exists())
    {
        QFileInfoList fileList = dir.entryInfoList(QDir::Files);
        for (const QFileInfo &fileInfo : fileList)
        {
            QString extension = fileInfo.suffix().toLower();
            if (!extension.isEmpty() && !uniqueExtensions.contains(extension))
            {
                uniqueExtensions.insert(extension);
                extensions.append(extension);
                QString folder = getFolderForExtension(extension);
                if (!folder.isEmpty())
                {
                    uniqueFolders.insert(folder);
                }
                emit folderForExtensionFound(extension, folder);
            }
        }
    }

    // Convert QSet to QStringList
    QStringList foldersList;
    for (const QString &folder : uniqueFolders)
    {
        foldersList.append(folder);
    }

    emit scanCompleted(extensions, foldersList);
}

void FolderScanner::loadExtensionMap()
{
    QFile file(":/test.json");
    if (file.open(QIODevice::ReadOnly))
    {
        QByteArray jsonData = file.readAll();
        QJsonDocument document = QJsonDocument::fromJson(jsonData);
        extensionMap = document.object();
    }
}

QString FolderScanner::getFolderForExtension(const QString &extension)
{
    if (extensionMap.isEmpty())
    {
        loadExtensionMap();
    }
    return extensionMap.value(extension.toLower()).toString();
}

QStringList FolderScanner::getUniqueFolders()
{
    if (extensionMap.isEmpty())
    {
        loadExtensionMap();
    }

    QStringList uniqueFolders;
    for (auto it = extensionMap.begin(); it != extensionMap.end(); ++it)
    {
        QString folder = it.value().toString();
        if (!uniqueFolders.contains(folder))
        {
            uniqueFolders.append(folder);
        }
    }

    return uniqueFolders;
}
