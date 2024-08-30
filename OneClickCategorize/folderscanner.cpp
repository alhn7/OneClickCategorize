#include "folderscanner.h"
#include <QDir>
#include <QFileInfo>
#include <QSet>

FolderScanner::FolderScanner(QObject *parent) : QObject(parent) {}

void FolderScanner::scanFolder(const QString &path)
{
    QDir dir(path);
    QStringList extensions;
    QSet<QString> uniqueExtensions;

    if (dir.exists()) {
        QFileInfoList fileList = dir.entryInfoList(QDir::Files);
        for (const QFileInfo &fileInfo : fileList) {
            QString extension = fileInfo.suffix().toLower();
            if (!extension.isEmpty() && !uniqueExtensions.contains(extension)) {
                uniqueExtensions.insert(extension);
                extensions.append(extension);

            }
        }
        qDebug() << extensions;
    }

    emit scanCompleted(extensions);
} 
