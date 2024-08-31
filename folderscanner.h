#ifndef FOLDERSCANNER_H
#define FOLDERSCANNER_H

#include <QObject>
#include <QStringList>

class FolderScanner : public QObject
{
    Q_OBJECT

public:
    explicit FolderScanner(QObject *parent = nullptr);

public slots:
    void scanFolder(const QString &path);

signals:
    void scanCompleted(const QStringList &extensions);
};

#endif // FOLDERSCANNER_H