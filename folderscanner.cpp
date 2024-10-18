#include "folderscanner.h"
#include <QDir>
#include <QFileInfo>
#include <QSet>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

FolderScanner::FolderScanner(QObject *parent) : QObject(parent) {}

QVariantMap FolderScanner::scanFolder(const QString &path)
{
    QDir dir(path);
    QSet<QString> uniqueExtensions;
    QSet<QString> uniqueFolders;

    qDebug() << "Scanning folder:" << path;

    if (dir.exists())
    {
        QFileInfoList fileList = dir.entryInfoList(QDir::Files);
        qDebug() << "Number of files found:" << fileList.size();

        for (const QFileInfo &fileInfo : fileList)
        {
            QString extension = fileInfo.suffix().toLower();
            if (!extension.isEmpty())
            {
                uniqueExtensions.insert(extension);
                QString folder = getFolderForExtension(extension);
                if (!folder.isEmpty())
                {
                    uniqueFolders.insert(folder);
                }
            }
        }
    }
    else
    {
        qDebug() << "Directory does not exist:" << path;
    }

    QVariantList extensionsList;
    for (const QString &extension : uniqueExtensions)
    {
        extensionsList.append(QVariant(extension));
    }

    QVariantList foldersList;
    for (const QString &folder : uniqueFolders)
    {
        foldersList.append(QVariant(folder));
    }

    qDebug() << "Scan completed. Unique extensions:" << extensionsList;
    qDebug() << "Unique folders:" << foldersList;

    QVariantMap result;
    result["extensions"] = extensionsList;
    result["folders"] = foldersList;

    return result;
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
